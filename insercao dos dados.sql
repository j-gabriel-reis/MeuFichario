INSERT INTO 
	materia(nome)
VALUES
	('Matemática'),
	('Português'),
	('História'),
	('Geografia'),
	('Física'),
	('Química'),
	('Biologia'),
	('Filosofia'),
	('Sociologia');

INSERT INTO 
	turma(serie, turno)
VALUES
	(1, 'Matutino'),
	(1, 'Matutino'),
	(2, 'Matutino'),
	(2, 'Matutino'),
	(3, 'Matutino'),
	(3, 'Matutino'),
	(1, 'Vespertino'),
	(2, 'Vespertino'),
	(3, 'Vespertino');
	
INSERT INTO 
	professor(nome, email, materia_id)
VALUES
	('João Felipe', 'joaofelipe@gmail.com', 1),
	('Ana Cristina', 'anacristina@gmail.com', 2),
	('André Luís', 'andreluis@gmail.com', 3),
	('Júlio César', 'juliocesar@gmail.com', 4),
	('Alexande Sampaio', 'alexandresampaio@gmail.com', 5),
	('Fábio Pereira', 'fabiopereira@gmail.com', 6),
	('Geraldo Rodrigues', 'geraldorodrigues@gmail.com', 7),
	('Fernando Augusto', 'fernandoaugusto@gmail.com', 8),
	('Igor Ramos', 'igorramos@gmail.com', 9),
	('Priscila Almeida', 'priscilaalmeida@gmail.com', 1),
	('Ricardo Pereira', 'ricardopereira@gmail.com', 2),
	('Lendro Silva', 'lendrosilva@gmail.com', 3),
	('Juliana Ramos', 'julianaramos@gmail.com', 4),
	('Gabriel Souza', 'gabrielsouza@gmail.com', 5);

INSERT INTO
	prof_turma(professor_matricula, turma_codigo)
VALUES
	(1, 1), (1, 2), (1, 3),	(1, 4),	(1, 5),	(1, 6),
	(2, 1),	(2, 2),	(2, 3),	(2, 4),	(2, 5),	(2, 6),
	(3, 1),	(3, 2),	(3, 3),	(3, 4),	(3, 5),	(3, 6),
	(4, 1),	(4, 2),	(4, 3),	(4, 4),	(4, 5),	(4, 6),
	(5, 1),	(5, 2),	(5, 3),	(5, 4),	(5, 5),	(5, 6),
	(6, 1),	(6, 2),	(6, 3),	(6, 4),	(6, 5),	(6, 6),
	(7, 1),	(7, 2),	(7, 3),	(7, 4),	(7, 5),	(7, 6),
	(8, 1),	(8, 2),	(8, 3),	(8, 4),	(8, 5),	(8, 6),
	(9, 1),	(9, 2),	(9, 3),	(9, 4),	(9, 5),	(9, 6),
	(10, 7),(10, 8),(10, 9), 
	(11, 7), (11, 8), (11, 9),
	(12, 7), (12, 8), (12, 9),
	(13, 7), (13, 8), (13, 9),
	(14, 7), (14, 8), (14, 9),
	(6, 7),	(6, 8),	(6, 9),	
	(7, 7),	(7, 8),	(7, 9),
	(8, 7),	(8, 8),	(8, 9),	
	(9, 7),	(9, 8),	(9, 9);

INSERT INTO
	aluno(nome, email, turma_codigo, senha)
VALUES
	('João Gabriel', 'joaogabriel@gmail.com', 1, '123456'),
	('Laura Cristina', 'lauracristina@gmail.com', 2, '123456'),
	('Eduado Côrtes', 'eduardocortes@gmail.com', 3, '123456'),
	('Gabriel Reis', 'gabrielreis@gmail.com', 4, '123456'),
	('Marcelo Pereira', 'marcelopereira@gmail.com', 5, '123456'),
	('Juliana Paula', 'julianapaula@gmail.com', 6, '123456'),
	('Jessica Vasconcelos', 'jessicavasconcelos@gmail.com', 7, '123456'),
	('Rodrigo Fernando', 'rodrigofernando@gmail.com', 1, '123456'),
	('Leticia Reis', 'leticiareis@gmail.com', 1, '123456');

INSERT INTO
	agenda(data_lembrete, lembrete, aluno_matricula)
VALUES
	('2021-05-01', 'Prova de matemática', 4),
	('2021-05-06', 'Estudar Física', 4),
	('2021-05-08', 'Prova de português', 6),
	('2021-05-10', 'Devolver o livro na biblioteca', 6),
	('2021-05-08', 'Prova de português', 2);

INSERT INTO
	telefone(aluno_matricula, numero_telefone)
VALUES
	(1, '61981085581'),
	(1, '61993501996'),
	(8, '61984612546'),
	(5, '61988464125'),
	(3, '61958165468');
	
INSERT INTO
	faltas(aluno_matricula, horario_falta, materia_id)
VALUES
	(9, '2020-02-05 07:35:58', 1),
	(9,'2020-02-10 07:30:28', 2),
	(9,'2020-02-12 08:50:10', 1),
	(9, '2020-02-28 07:38:15', 1),
	(9, '2020-03-10 11:33:20', 1);
	
INSERT INTO
	caderno(nome, aluno_matricula, materia_id)
VALUES
	('Caderno 1', 1, 1),
	('Caderno 2', 1, 2),
	('Caderno 3', 3, 3),
	('Caderno 4', 3, 4),
	('Caderno 5', 2, 5);
	
INSERT INTO
	anotacao(data_anotacao, nome, caderno_nome, aluno_matricula, texto, anexo_pdf)
VALUES
	('2020-05-06', 'Função afim', 'Caderno 1', 1, 'A função afim é classificada como função de primeiro grau', bytea_import('/home/joao/Downloads/Laboratorio DML1.pdf')),
	('2020-05-07', 'Geometria', 'Caderno 1', 1, 'A área do triângulo pode ser calculada através das medidas da base e da altura da figura.', bytea_import('/home/joao/Downloads/Laboratorio DML1.pdf')),
	('2020-05-08', 'Teorama Pitágoras', 'Caderno 1', 1, 'O teorema de Pitágoras é uma relação matemática entre os comprimentos dos lados de qualquer triângulo retângulo.', NULL),
	('2020-05-09', 'Progressão geométrica', 'Caderno 1', 1, 'Progressão geométrica é toda sequência numérica em que cada termo, a partir do segundo, é igual ao produto do termo anterior por uma constante q.', NULL),
	('2020-05-25', 'Resposta para a pergunta fundamental sobre a vida, o universo e tudo mais', 'Caderno 1', 1, '42', NULL);


INSERT INTO
	seguidores(aluno_matricula, caderno_nome, matricula_proprietario, pode_editar)
VALUES
	(2, 'Caderno 1', 1, FALSE),
	(3, 'Caderno 1', 1, FALSE),
	(4, 'Caderno 1', 1, FALSE),
	(5, 'Caderno 1', 1, FALSE),
	(6, 'Caderno 1', 1, FALSE);

INSERT INTO
	nota(aluno_matricula, caderno_nome, matricula_proprietario, nota_avaliada)
VALUES
	(2, 'Caderno 1', 1, 10),
	(3, 'Caderno 1', 1, 9),
	(4, 'Caderno 4', 3, 9),
	(5, 'Caderno 3', 3, 10),
	(6, 'Caderno 1', 1, 10);
	
INSERT INTO 
	monitor(nome, email, materia_id)
VALUES
	('Alan Douglas', 'alandouglas@gmail.com', 1),
	('Jonatan Silva', 'jonatansilva@gmail.com', 2),
	('Camila Martins', 'camilamartins@gmail.com', 3),
	('Júlio César', 'juliocesar@gmail.com', 4),
	('Artur Dent', 'arthurdent@gmail.com', 5)
	
INSERT INTO 
	frequencia(monitor_matricula, horario_atendimento)
VALUES
	(1, '2020-02-05 07:35:58'),
	(2, '2020-02-10 07:30:28'),
	(3, '2020-02-12 08:50:10'),
	(4, '2020-02-28 07:38:15'),
	(5, '2020-03-10 11:33:20')
	
	
	
