--DROP SCHEMA public CASCADE;
--CREATE SCHEMA public;

CREATE TABLE turma(
	codigo SERIAL,
	serie INT NOT NULL,
	turno VARCHAR NOT NULL,
	PRIMARY KEY(codigo)
);

CREATE TABLE aluno(
	matricula SERIAL,
	nome VARCHAR(45) NOT NULL,
	email VARCHAR(45) NOT NULL,
	turma_codigo INT NOT NULL,
	foto BYTEA,
	senha VARCHAR(45),
	PRIMARY KEY(matricula),
	FOREIGN KEY(turma_codigo) REFERENCES turma (codigo)
);

CREATE TABLE login(
	aluno_matricula INT,
	senha VARCHAR(45) NOT NULL,
	PRIMARY KEY(aluno_matricula),
	FOREIGN KEY(aluno_matricula) REFERENCES aluno (matricula)
);

CREATE TABLE telefone(
	aluno_matricula INT,
	numero_telefone VARCHAR(11),
	PRIMARY KEY(aluno_matricula, numero_telefone),
	FOREIGN KEY(aluno_matricula) REFERENCES aluno (matricula)
);

CREATE TABLE agenda(
	id SERIAL,
	data_lembrete DATE NOT NULL,
	lembrete TEXT NOT NULL,
	aluno_matricula INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(aluno_matricula) REFERENCES aluno (matricula)
);

CREATE TABLE materia(
	id SERIAL,
	nome VARCHAR(45) NOT NULL,
	PRIMARY KEY(ID)
);

CREATE TABLE faltas(
	aluno_matricula INT,
	horario_falta TIMESTAMP NOT NULL,
	materia_id INT NOT NULL,
	PRIMARY KEY(aluno_matricula, horario_falta),
	FOREIGN KEY(aluno_matricula) REFERENCES aluno (matricula),
	FOREIGN KEY(materia_id) REFERENCES materia (id)
);

CREATE TABLE caderno(
	nome VARCHAR(45) NOT NULL,
	aluno_matricula INT NOT NULL,
	materia_id INT NOT NULL,
	PRIMARY KEY(nome, aluno_matricula),
	FOREIGN KEY(aluno_matricula) REFERENCES aluno (matricula),
	FOREIGN KEY(materia_id) REFERENCES materia (id)
);

CREATE TABLE seguidores(
	aluno_matricula INT,
	caderno_nome varchar(45),
	matricula_proprietario INT,
	pode_editar BOOLEAN NOT NULL,
	PRIMARY KEY(aluno_matricula, caderno_nome, matricula_proprietario),
	FOREIGN KEY(aluno_matricula) REFERENCES aluno (matricula),
	FOREIGN KEY(matricula_proprietario, caderno_nome) REFERENCES caderno (aluno_matricula, nome) ON DELETE CASCADE
);

CREATE TABLE nota(
	aluno_matricula INT,
	caderno_nome VARCHAR(45),
	matricula_proprietario INT,
	nota_avaliada INT NOT NULL,
	PRIMARY KEY(aluno_matricula, caderno_nome, matricula_proprietario),
	FOREIGN KEY(aluno_matricula) REFERENCES aluno (matricula),
	FOREIGN KEY(matricula_proprietario, caderno_nome) REFERENCES caderno (aluno_matricula, nome) ON DELETE CASCADE
);

CREATE TABLE anotacao(
	id SERIAL,
	data_anotacao DATE NOT NULL,
	nome VARCHAR(80) NOT NULL,
	anexo_pdf BYTEA,
	texto TEXT NOT NULL,
	caderno_nome VARCHAR(45),
	aluno_matricula INT,
	PRIMARY KEY(id, caderno_nome, aluno_matricula),
	FOREIGN KEY(caderno_nome, aluno_matricula) REFERENCES caderno (nome, aluno_matricula) ON DELETE CASCADE
);

CREATE TABLE professor(
	matricula SERIAL,
	nome VARCHAR(45),
	email VARCHAR(45) NOT NULL,
	materia_id INT NOT NULL,
	PRIMARY KEY(matricula),
	FOREIGN KEY(materia_id) REFERENCES materia (id)
);

CREATE TABLE prof_turma(
	professor_matricula INT,
	turma_codigo INT,
	PRIMARY KEY(professor_matricula, turma_codigo),
	FOREIGN KEY(professor_matricula) REFERENCES professor (matricula),
	FOREIGN KEY(turma_codigo) REFERENCES turma (codigo)
);

CREATE TABLE monitor(
	matricula SERIAL,
	nome VARCHAR(45),
	email VARCHAR(45) NOT NULL,
	materia_id INT NOT NULL,
	PRIMARY KEY(matricula),
	FOREIGN KEY(materia_id) REFERENCES materia (id)
);

CREATE TABLE frequencia(
	monitor_matricula INT,
	horario_atendimento TIMESTAMP NOT NULL,
	PRIMARY KEY(monitor_matricula, horario_atendimento),
	FOREIGN KEY(monitor_matricula) REFERENCES monitor (matricula)
);


--- Função para inserção dos PDFs

create or replace function bytea_import(p_path text, p_result out bytea) 
                   language plpgsql as $$
declare
  l_oid oid;
begin
  select lo_import(p_path) into l_oid;
  select lo_get(l_oid) INTO p_result;
  perform lo_unlink(l_oid);
end;$$;

--- View para adicionar média das notas nos cadernos
CREATE VIEW vw_caderno_materia AS
	SELECT 
		caderno.nome, aluno_matricula, materia.nome as materia
	FROM 
		caderno, materia
	where
		caderno.materia_id = materia.id;

CREATE VIEW vw_notas_cadernos AS 
SELECT 
	caderno_nome, matricula_proprietario, materia, media
FROM 
	vw_caderno_materia
JOIN 
	(SELECT 
		caderno_nome, matricula_proprietario, AVG(nota_avaliada)::numeric(10,2) as media
	FROM 
		nota
	JOIN 
	 	caderno on caderno_nome=caderno.nome
	GROUP BY 
		caderno_nome, matricula_proprietario) n2
	ON n2.caderno_nome = vw_caderno_materia.nome and n2.matricula_proprietario = vw_caderno_materia.aluno_matricula
ORDER BY media DESC;

Select * from vw_notas_cadernos;

--------- PROCEDURE
CREATE OR REPLACE FUNCTION aluno_destaque(matricula INT) RETURNS VARCHAR AS $$
	DECLARE
		nota_media DECIMAL;
	BEGIN
		SELECT 
			AVG(nota_avaliada)::numeric(10,2) into nota_media
		FROM 
			nota
		WHERE 
			matricula_proprietario=matricula;
		
		IF nota_media > 0.9 THEN
			RETURN 'ALUNO DESTAQUE';
		ELSE
			RETURN 'PODE MELHORAR';
		END IF;
		
	END;
$$ LANGUAGE plpgsql;

SELECT aluno_destaque(1)