ALUNOS: Isys Naila Santos Silva 


LISTA 


–2 tabelas que contenham chaves estrangeiras, pelo menos. 1 coluna com NOT NULL em cada tabela 1 coluna com DEFAULT, pelo menos. 1 campo SERIAL 1 campo DATE 1 campo TIME 1 campo NUMERIC 1 campo INTEGER 1 campo VARCHAR 1 campo de outro tipo, que não usamos em sala de aula ainda. 




CREATE TABLE autor(
        id_autor SERIAL PRIMARY KEY,
        nome_autor CHAR(30) NOT NULL,
        nacionalidade VARCHAR(20),
        data_nasc DATE
);


CREATE TABLE genero(
        id_genero SERIAL PRIMARY KEY,
        descricao VARCHAR(20),
         
);


CREATE TABLE livros(
        id_livro SERIAL PRIMARY KEY,
           nome_livro VARCHAR(15),
           num_pags INTEGER,
        preco_livro NUMERIC(6,2) DEFAULT(15),
        publicado BOOLEAN,
        id_autor SERIAL NOT NULL,
        id_genero SERIAL NOT NULL,
           id_editora SERIAL NOT NULL,
        FOREIGN KEY (id_autor) REFERENCES autor (id_autor),
        FOREIGN KEY (id_genero) REFERENCES genero (id_genero),
           FOREIGN KEY (id_editora) REFERENCES editora(id_editora)
);


CREATE TABLE editora(
        id_editora SERIAL PRIMARY KEY,
        nome_ed VARCHAR(30) NOT NULL,
        pais_ed VARCHAR(20)
          
);


CREATE TABLE telefone(
        id_editora SERIAL,
        telefone CHAR(11),
        PRIMARY KEY(id_editora,telefone),
        FOREIGN KEY (id_editora) REFERENCES editora (id_editora)


);


CREATE TABLE publicacao(
        id_livro SERIAL NOT NULL,
        id_editora SERIAL NOT NULL,
        id_autor SERIAL NOT NULL,
           hora_publi TIME,
        PRIMARY KEY (id_livro, id_editora),
        FOREIGN KEY (id_livro) REFERENCES livro(id_livro),
        FOREIGN KEY (id_editora) REFERENCES editora(id_editora),
        FOREIGN KEY (id_autor) REFERENCES autor (id_autor)
);




–1 criação de coluna em uma tabela já existente. 
–1 campo TIME 


ALTER TABLE publicacao
ADD COLUMN hora_publi TIME


–1 exclusão de coluna em uma tabela já existente. 


ALTER TABLE autor
DROP COLUMN nacionalidade


–1 alteração do nome de uma coluna 


ALTER TABLE livro
RENAME COLUMN preco_livro TO preco


–1 coluna como UNIQUE em uma tabela já existente 


ALTER TABLE autor
ADD CONSTRAINT nome  UNIQUE (nome_autor);




–1 exclusão de restrição UNIQUE 
ALTER TABLE autor
DROP CONSTRAINT nome;


–1 modificação de valor DEFAULT 


ALTER TABLE ONLY livro
ALTER COLUMN preco SET DEFAULT(10)


–1 modificação do tipo de uma coluna 


ALTER TABLE autor
ALTER COLUMN nome_autor TYPE VARCHAR(30)


–1 alteração do nome de uma tabela 


ALTER TABLE livro
RENAME TO livros


–1 comando INSERT escrevendo as colunas 


INSERT INTO autor
(nome_autor,data_nasc)
VALUES
('Nicolas Cage','1964/01/07')


–1 comando INSERT não escrevendo as colunas 
INSERT INTO autor
VALUES
(2,'Stephen King','1947/09/21')


–1 comando INSERT com RETURNING 


INSERT INTO autor
(nome_autor, data_nasc) 
VALUES 
('Adam Sandler', '1966/09/09') RETURNING id_autor;


–1 comando UPDATE 


UPDATE autor
SET data_nasc='1948/10/01'
WHERE id_autor=2


–1 comando UPDATE com IN 


UPDATE autor
SET data_nasc='1948/10/02'
WHERE id_autor in (2)
– 1 comando UPDATE com NOT IN 




UPDATE livros
SET preco=40
WHERE id_autor not in (2)


–1 comando DELETE  




delete from livros


–1 comando DELETE com WHERE  


DELETE FROM genero
WHERE id_genero=2


–1 comando SELECT com ORDER BY com ordenação ASC  


SELECT nome_autor, data_nasc
FROM autor
ORDER BY data_nasc ASC




–1 comando SELECT com ORDER BY com ordenação DESC  


SELECT nome_autor, data_nasc
FROM autor
ORDER BY data_nasc DESC


–1 comando SELECT com GROUP BY  


SELECT nome_autor, nome_livro
FROM autor,livros
WHERE autor.id_autor=livros.id_autor
GROUP BY nome_autor, nome_livro


–1 comando SELECT com GROUP BY com uma função de agregação


select id_editora,count(1) from livros GROUP BY id_editora


–1 comando SELECT com usando a função de agregação MAX 
select MAX(preco)
from livros


–1 comando SELECT com usando a função de agregação MIN 


select MIN(preco)
from livros


–1 comando SELECT com usando a função de agregação COUNT 


SELECT COUNT(id_livro)
FROM livros


–1 comando SELECT com usando a função de agregação AVG 


select AVG(preco)
from livros


–1 comando SELECT com usando a função de agregação SUM


select SUM(preco)
from livros


–1 comando SELECT com DISTINCT 


SELECT DISTINCT nome_livro FROM livros


–1 comando SELECT com AND 


SELECT nome_livro
FROM livros
WHERE id_livro=4 AND preco=25


–1 comando SELECT com OR 


SELECT nome_livro
FROM livros
WHERE id_livro=4 OR preco=42


–1 comando SELECT com NOT 


SELECT nome_livro
FROM livros
WHERE preco NOT IN (42)


–1 comando SELECT com BETWEEN 


SELECT nome_livro
FROM livros
WHERE preco BETWEEN 50 AND 58


–1 comando SELECT com NATURAL JOIN 


select id_autor, nome_autor, nome_livro
FROM livros
NATURAL JOIN autor


–1 comando SELECT com INNER JOIN 


SELECT livros.nome_livro, nome_ed
FROM livros
INNER JOIN editora
ON livros.id_editora=editora.id_editora
GROUP BY livros.nome_livro, nome_ed


–1 comando SELECT com LEFT JOIN 


SELECT livros.nome_livro, nome_ed
FROM livros
LEFT JOIN editora
ON livros.id_editora=editora.id_editora
GROUP BY livros.nome_livro, nome_ed




–1 comando SELECT com RIGHT JOIN 


SELECT livros.nome_livro, descricao, nome_ed
FROM livros
JOIN genero ON genero.id_genero = livros.id_genero
RIGHT JOIN editora ON editora.id_editora = livros.id_editora
GROUP BY livros.nome_livro, descricao, nome_ed


–1 comando SELECT com FULL OUTER JOIN


SELECT livros.nome_livro, descricao, nome_ed
FROM livros
JOIN genero ON genero.id_genero = livros.id_genero
FULL OUTER JOIN editora ON editora.id_editora = livros.id_editora
GROUP BY livros.nome_livro, descricao, nome_ed


–1 comando SELECT usando o LIMIT 




SELECT nome_livro
FROM livros
ORDER BY nome_livro ASC
LIMIT 2


–1 comando SELECT usando o OFFSET 


SELECT nome_livro
FROM livros
ORDER BY nome_livro ASC
OFFSET 1


–1 comando SELECT substituindo os valores nulos no retorno 


SELECT id_livro, COALESCE(nome_livro,'NÃO ESPECIFICADO')
FROM livros


–1 comando SELECT buscando dados diferentes de algo 


SELECT nome_livro
FROM livros
WHERE nome_livro!='Joyland'


–1 comando SELECT com LIKE 


SELECT * FROM autor
WHERE nome_autor LIKE '%ol%'


–1 comando SELECT com NOT LIKE 


SELECT * FROM autor
WHERE nome_autor NOT LIKE '%ol%'


–1 comando SELECT com CASE 


SELECT nome_livro, CASE WHEN publicado='true' THEN 'LIVRO PUBLICADO'
                         WHEN publicado='false' THEN 'LIVRO NÃO PUBLICADO'
                                                 END
FROM livros


–1 comando SELECT com round


SELECT ROUND(preco)
from livros


–1 comando SELECT com trunc 


SELECT TRUNC(preco)
from livros


–1 comando SELECT com UPPER


SELECT UPPER(nome_livro)
FROM livros


–1 comando SELECT com LOWER


SELECT LOWER(nome_livro)
FROM livros


–1 comando SELECT com substring


SELECT SUBSTRING(nome_livro, 1, 1) AS inicial_livro
FROM livros




–1 comando SELECT com concatenação de string


SELECT CONCAT(id_autor,'-',nome_autor)
FROM autor
ORDER BY id_autor ASC


–1 comando SELECT com a função “age”


SELECT nome_autor, date_part('year', age(data_nasc))
FROM autor;
