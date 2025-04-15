CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

DROP TABLE IF EXISTS faz_uma;
DROP TABLE IF EXISTS vai_para;
DROP TABLE IF EXISTS local;
DROP TABLE IF EXISTS e;
DROP TABLE IF EXISTS escolha;
DROP TABLE IF EXISTS compra_aluguel;
DROP TABLE IF EXISTS historico;
DROP TABLE IF EXISTS avaliacao;
DROP TABLE IF EXISTS registro;
DROP TABLE IF EXISTS armazenamento;
DROP TABLE IF EXISTS obra;
DROP TABLE IF EXISTS cliente;

CREATE TABLE cliente (
  IDCliente INT PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(100) NOT NULL,
  Endereco VARCHAR(225),
  Email VARCHAR(100) UNIQUE,
  Senha VARCHAR(225) NOT NULL
);
CREATE TABLE obra (
  IDObra INT PRIMARY KEY AUTO_INCREMENT,
  Titulo VARCHAR(225) NOT NULL,
  DatPubli DATE,
  Autor VARCHAR(100),
  Tema VARCHAR(100)
);

CREATE TABLE armazenamento (
  LocalArmaz INT PRIMARY KEY AUTO_INCREMENT,
  NomeArmaz VARCHAR(100),
  NomeLocal VARCHAR(100),
  ItemArmaz VARCHAR(225)
);

CREATE TABLE compra_aluguel (
  IDCompAlg INT PRIMARY KEY AUTO_INCREMENT,
  IDCliente INT,
  DatCompAlg DATE NOT NULL,
  Preco DECIMAL(10,2),
  TipoCompAlg ENUM('Compra', 'Aluguel') NOT NULL,
  MetPag VARCHAR(50) NOT NULL,
  FOREIGN KEY (IDCliente) REFERENCES cliente(IDCliente) ON DELETE CASCADE
);

CREATE TABLE registro (
  IDResg INT PRIMARY KEY AUTO_INCREMENT,
  LocalArmaz INT,
  DatResg DATE NOT NULL,
  DescResg TEXT,
  Status ENUM('Ativo', 'Inativo'),
  Titulo VARCHAR(225),
  FOREIGN KEY (LocalArmaz) REFERENCES armazenamento(LocalArmaz) ON DELETE SET NULL
);

CREATE TABLE escolha (
  IDCliente INT,
  IDObra INT,
  DatEscolha DATE NOT NULL,
  PRIMARY KEY (IDCliente, IDObra),
  FOREIGN KEY (IDCliente) REFERENCES cliente(IDCliente) ON DELETE CASCADE,
  FOREIGN KEY (IDObra) REFERENCES obra(IDObra) ON DELETE CASCADE
);

CREATE TABLE e (
  IDCompAlg INT,
  IDResg INT NOT NULL,
  DatResg DATE NOT NULL,
  PRIMARY KEY (IDCompAlg, IDResg),
  FOREIGN KEY (IDCompAlg) REFERENCES compra_aluguel(IDCompAlg) ON DELETE CASCADE,
  FOREIGN KEY (IDResg) REFERENCES registro(IDResg) ON DELETE CASCADE
);

CREATE TABLE local (
  IDResg INT NOT NULL,
  LocalArmaz INT,
  DatAssociacao DATE NOT NULL,
  PRIMARY KEY (IDResg, LocalArmaz),
  FOREIGN KEY (IDResg) REFERENCES registro(IDResg) ON DELETE CASCADE,
  FOREIGN KEY (LocalArmaz) REFERENCES armazenamento(LocalArmaz) ON DELETE CASCADE
);

CREATE TABLE historico (
  IDHist INT PRIMARY KEY AUTO_INCREMENT,
  TipoAlt VARCHAR(100),
  DatAlt DATE NOT NULL,
  DescriAlt TEXT,
  ItemAdd VARCHAR(225)
);

CREATE TABLE vai_para (
  IDResg INT,
  IDHist INT,
  PRIMARY KEY (IDResg, IDHist),
  FOREIGN KEY (IDResg) REFERENCES registro(IDResg) ON DELETE CASCADE,
  FOREIGN KEY (IDHist) REFERENCES historico(IDHist) ON DELETE CASCADE
);

CREATE TABLE avaliacao (
  IDAval INT PRIMARY KEY AUTO_INCREMENT,
  Nota INT CHECK (Nota BETWEEN 1 AND 5),
  Comentario TEXT,
  DatAval DATE NOT NULL,
  Recomendacao BOOLEAN
);

CREATE TABLE faz_uma (
  IDHist INT,
  IDAval INT,
  PRIMARY KEY (IDHist, IDAval),
  FOREIGN KEY (IDHist) REFERENCES historico(IDHist) ON DELETE CASCADE,
  FOREIGN KEY (IDAval) REFERENCES avaliacao(IDAval) ON DELETE CASCADE
);

INSERT INTO cliente (Nome, Endereco, Email, Senha) VALUES
('João Silva', 'Rua A, 123', 'joao@email.com', 'senha123'),
('Maria Souza', 'Rua B, 456', 'maria@email.com', 'senha456');

INSERT INTO obra (Titulo, DatPubli, Autor, Tema) VALUES
('Aventuras no Espaço', '2020-05-10', 'Carlos Lima', 'Ficção'),
('Culinária Brasileira', '2018-08-15', 'Ana Paula', 'Gastronomia');

INSERT INTO armazenamento (NomeArmaz, NomeLocal, ItemArmaz) VALUES
('Estante A', 'Sala 1', 'Livros Ficção'),
('Prateleira B', 'Sala 2', 'Livros Culinária');

INSERT INTO compra_aluguel (IDCliente, DatCompAlg, Preco, TipoCompAlg, MetPag) VALUES
(1, '2024-04-01', 35.90, 'Compra', 'Cartão'),
(2, '2024-04-02', 15.00, 'Aluguel', 'Dinheiro');

INSERT INTO registro (LocalArmaz, DatResg, DescResg, Status, Titulo) VALUES
(1, '2024-04-01', 'Livro em bom estado', 'Ativo', 'Aventuras no Espaço'),
(2, '2024-04-02', 'Livro com marcas de uso', 'Ativo', 'Culinária Brasileira');

INSERT INTO escolha (IDCliente, IDObra, DatEscolha) VALUES
(1, 1, '2024-04-01'),
(2, 2, '2024-04-02');

INSERT INTO e (IDCompAlg, IDResg, DatResg) VALUES
(1, 1, '2024-04-01'),
(2, 2, '2024-04-02');

INSERT INTO local (IDResg, LocalArmaz, DatAssociacao) VALUES
(1, 1, '2024-04-01'),
(2, 2, '2024-04-02');

INSERT INTO historico (TipoAlt, DatAlt, DescriAlt, ItemAdd) VALUES
('Atualização', '2024-04-03', 'Atualização de status', 'Capa nova'),
('Movimentação', '2024-04-04', 'Livro transferido', 'Sala nova');

INSERT INTO vai_para (IDResg, IDHist) VALUES
(1, 1),
(2, 2);

INSERT INTO avaliacao (Nota, Comentario, DatAval, Recomendacao) VALUES
(5, 'Excelente leitura!', '2024-04-05', TRUE),
(3, 'Receita difícil de seguir', '2024-04-06', FALSE);

INSERT INTO faz_uma (IDHist, IDAval) VALUES
(1, 1),
(2, 2);