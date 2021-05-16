import psycopg2;
from datetime import date
import codecs

class aluno:

    def __init__(self, matricula_aluno):
        self.matricula = matricula_aluno

    def confere_login(self, senha):

        # Connect to an existing database
        conn = psycopg2.connect(
        dbname="MeuFichario", 
        user="joao",
        password="14279897")

        # Open a cursor to perform database operations
        cur = conn.cursor()

        cur.execute(f"SELECT matricula, senha FROM aluno WHERE matricula={self.matricula} AND senha='{senha}';")
        match = cur.fetchone()

        # Close the cursor
        cur.close()

        # Close the conection
        conn.close()

        if isinstance(match, tuple):
            return True
        else:
            return False

class materia:

    def todas_materias(self):
        # Connect to an existing database
        conn = psycopg2.connect(
        dbname="MeuFichario", 
        user="joao",
        password="14279897")

        # Open a cursor to perform database operations
        cur = conn.cursor()
        
        cur.execute("select * from materia")

        materias = cur.fetchall()

        # Close the cursor
        cur.close()

        # Close the conection
        conn.close()

        return materias



class caderno:

    def __init__(self, matricula_aluno):
        self.matricula = matricula_aluno

    def meus_cadernos(self):
        # Connect to an existing database
        conn = psycopg2.connect(
        dbname="MeuFichario", 
        user="joao",
        password="14279897")

        # Open a cursor to perform database operations
        cur = conn.cursor()
        
        cur.execute(f'''
            select 
                caderno.nome, materia.nome 
            from 
                caderno 
            join 
                materia on caderno.materia_id = materia.id 
            where
                caderno.aluno_matricula={self.matricula};
            ''')

        cadernos = cur.fetchall()

        # Close the cursor
        cur.close()

        # Close the conection
        conn.close()

        return cadernos

    def cria_caderno(self, nome_caderno, id_materia_caderno):
        # Connect to an existing database
        conn = psycopg2.connect(
        dbname="MeuFichario", 
        user="joao",
        password="14279897")

        # Open a cursor to perform database operations
        cur = conn.cursor()
        cur.execute('''
            INSERT INTO
	            caderno(nome, aluno_matricula, materia_id)
            VALUES
	            (%s, %s, %s);
        ''', (nome_caderno, self.matricula, id_materia_caderno))

        # Make the changes to the database persistent
        conn.commit()

        # Close the cursor
        cur.close()

        # Close the conection
        conn.close()

    def edita_caderno(self, nome_atual, novo_nome=None, nova_materia=None):
        # Connect to an existing database
        conn = psycopg2.connect(
        dbname="MeuFichario", 
        user="joao",
        password="14279897")

        # Open a cursor to perform database operations
        cur = conn.cursor()
        
        SQL = "UPDATE caderno SET"
        
        if novo_nome is not None:
            SQL += " nome = %(nome)s"
            if nova_materia is not None:
                SQL += ","
        if nova_materia is not None:
            SQL += " materia_id = %(materia)s"
        if nova_materia is None and novo_nome is None:
            return 0

        SQL += " WHERE caderno.aluno_matricula = %(matricula)s and caderno.nome = %(antigo_nome)s;"

        cur.execute(SQL, {'nome':novo_nome, 'materia':nova_materia, 'matricula':self.matricula, 'antigo_nome':nome_atual})

        # Make the changes to the database persistent
        conn.commit()

        # Close the cursor
        cur.close()

        # Close the conection
        conn.close()

    def apaga_caderno(self, nome_caderno):
        # Connect to an existing database
        conn = psycopg2.connect(
        dbname="MeuFichario", 
        user="joao",
        password="14279897")

        # Open a cursor to perform database operations
        cur = conn.cursor()
        cur.execute(f'''
            DELETE FROM caderno
            WHERE aluno_matricula={self.matricula} and nome='{nome_caderno}';
        ''')

        # Make the changes to the database persistent
        conn.commit()

        # Close the cursor
        cur.close()

        # Close the conection
        conn.close()


class anotacao:

    def __init__(self, matricula_aluno, nome_caderno):
        self.matricula = matricula_aluno
        self.nome_caderno = nome_caderno

    def anotacao_especifica(self, id):
        # Connect to an existing database
        conn = psycopg2.connect(
        dbname="MeuFichario", 
        user="joao",
        password="14279897")

        # Open a cursor to perform database operations
        cur = conn.cursor()
        
        cur.execute(f'''
            select 
                id, data_anotacao, nome, texto
            from 
                anotacao 
            where
                id={id};
            ''')

        anot = cur.fetchone()

        # Close the cursor
        cur.close()

        # Close the conection
        conn.close()

        return anot


    def todas_anotacoes(self):
        # Connect to an existing database
        conn = psycopg2.connect(
        dbname="MeuFichario", 
        user="joao",
        password="14279897")

        # Open a cursor to perform database operations
        cur = conn.cursor()
        
        cur.execute(f'''
            select 
                id, data_anotacao, nome, texto
            from 
                anotacao 
            where
                aluno_matricula={self.matricula} and caderno_nome= '{self.nome_caderno}';
            ''')

        anotacoes = cur.fetchall()

        # Close the cursor
        cur.close()

        # Close the conection
        conn.close()

        return anotacoes

    def cria_anotacao(self, nome_anotacao, texto, anexo_pdf = None):
        # Connect to an existing database
        conn = psycopg2.connect(
        dbname="MeuFichario", 
        user="joao",
        password="14279897")

        # Open a cursor to perform database operations
        cur = conn.cursor()
        cur.execute('''
            INSERT INTO
	            anotacao(data_anotacao, nome, anexo_pdf, texto, caderno_nome, aluno_matricula)
            VALUES
	            (%s, %s, %s, %s, %s, %s);
        ''', (date.today(), nome_anotacao, anexo_pdf, texto, self.nome_caderno, self.matricula))

        # Make the changes to the database persistent
        conn.commit()

        # Close the cursor
        cur.close()

        # Close the conection
        conn.close()

    def edita_anotacao(self, id, novo_nome=None, novo_texto=None):
        # Connect to an existing database
        conn = psycopg2.connect(
        dbname="MeuFichario", 
        user="joao",
        password="14279897")

        # Open a cursor to perform database operations
        cur = conn.cursor()
        
        SQL = "UPDATE anotacao SET"

        if novo_nome is not None:
            SQL += " nome = %(nome_anotacao)s"
            if novo_texto is not None:
                SQL += ","

        if novo_texto is not None:
            SQL += " texto = %(texto)s" 
        
        SQL += " WHERE id=%(id)s;"

        cur.execute(SQL, {'nome_anotacao':novo_nome, 'texto':novo_texto, 'id':id})

        # Make the changes to the database persistent
        conn.commit()

        # Close the cursor
        cur.close()

        # Close the conection
        conn.close()

    def apaga_anotacao(self, id_anotacao):
        # Connect to an existing database
        conn = psycopg2.connect(
        dbname="MeuFichario", 
        user="joao",
        password="14279897")

        # Open a cursor to perform database operations
        cur = conn.cursor()
        cur.execute(f'''
            DELETE FROM anotacao
            WHERE id={id_anotacao};
        ''')

        # Make the changes to the database persistent
        conn.commit()

        # Close the cursor
        cur.close()

        # Close the conection
        conn.close()

    def insere_pdf(self, id_anotacao, caminho_pdf):
        
        datafile = open(caminho_pdf,'rb')
        pdfdata = datafile.read()
        datafile.close()

        # Connect to an existing database
        conn = psycopg2.connect(
        dbname="MeuFichario", 
        user="joao",
        password="14279897")

        # Open a cursor to perform database operations
        cur = conn.cursor()
    
        cur.execute(f'''
            UPDATE 
                anotacao
            SET
                anexo_pdf={psycopg2.Binary(pdfdata)}
            WHERE
                id={id_anotacao}
            ''') 

        # Make the changes to the database persistent
        conn.commit()

        # Close the cursor
        cur.close()

        # Close the conection
        conn.close()

    def visualiza_pdf(self, id_anotacao):
        
        # Connect to an existing database
        conn = psycopg2.connect(
        dbname="MeuFichario", 
        user="joao",
        password="14279897")

        # Open a cursor to perform database operations
        cur = conn.cursor()
    
        cur.execute(f'''
            Select 
                anexo_pdf
            From
                anotacao
            WHERE
                id={id_anotacao}
            ''') 
        
        pdf = cur.fetchone()[0]

        # Close the cursor
        cur.close()

        # Close the conection
        conn.close()

        return pdf

class melhores_cadernos:
    def consultar_melhores(self):
                
        # Connect to an existing database
        conn = psycopg2.connect(
        dbname="MeuFichario", 
        user="joao",
        password="14279897")

        # Open a cursor to perform database operations
        cur = conn.cursor()

        cur.execute(f'''
            Select * FROM vw_notas_cadernos;   
            ''') 
        
        top_cadernos = cur.fetchall()

        # Close the cursor
        cur.close()

        # Close the conection
        conn.close()

        return top_cadernos

class destaques:
    def status(self, matricula):
                
        # Connect to an existing database
        conn = psycopg2.connect(
        dbname="MeuFichario", 
        user="joao",
        password="14279897")

        # Open a cursor to perform database operations
        cur = conn.cursor()

        cur.execute(f'''
            SELECT aluno_destaque({matricula})   
            ''') 
        
        status = cur.fetchone()[0]

        # Close the cursor
        cur.close()

        # Close the conection
        conn.close()

        return status

#print(melhores_cadernos().status(1))

