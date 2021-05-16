-- Seleciona todos os professores do João Gabriel

select 
	professor.nome
from 
	aluno, turma, prof_turma, professor
where 
	aluno.nome = 'João Gabriel' and
	aluno.turma_codigo = codigo and 
	turma.codigo = prof_turma.turma_codigo and
	prof_turma.professor_matricula = professor.matricula;

-- Seleciona todos os telefones dos alunos da turma 1
select 
	numero_telefone
from 
	telefone, aluno, turma
where 
	telefone.aluno_matricula = aluno.matricula and
	aluno.turma_codigo = codigo and 
	turma.codigo = 1;
	
-- Seleciona todos as anotações do João Gabriel

select
	texto
from
	anotacao
join
	caderno on caderno.nome = anotacao.caderno_nome and 
	caderno.aluno_matricula = anotacao.aluno_matricula
join
	aluno on aluno.matricula = caderno.aluno_matricula
where
	aluno.nome = 'João Gabriel';

-- Seleciona todos as datas das faltas da leticia por materia

select
	aluno.nome aluno, horario_falta, materia.nome materia
from 
	faltas
join 
	aluno on aluno.matricula = faltas.aluno_matricula
join
	materia on materia.id = faltas.materia_id
where
	aluno.nome = 'Leticia Reis';

-- Todos os alunos e as notas que deram para o caderno do aluno 1
select
	aluno.nome aluno, nota.nota_avaliada
from 
	aluno
join 
	nota on aluno.matricula = nota.aluno_matricula
join
	caderno on nota.caderno_nome = caderno.nome and
	nota.matricula_proprietario = caderno.aluno_matricula
where
	caderno.aluno_matricula = 1;


select * from aluno;
select * from caderno;
select * from anotacao;
select * from seguidores;
select * from nota

select 
	caderno.nome, materia.nome 
from caderno 
join materia on caderno.materia_id=materia.id where caderno.aluno_matricula=1;



