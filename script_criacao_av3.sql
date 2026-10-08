-- GRUPO 6 - BANCO DE DADOS - CIn UFPE

-- CÁSSIO DINIZ ROCHA LEITE <cdrl>
-- ISABELA POSSÍDIO AMORIM <ipa>
-- LUIZ MIGUEL FREITAS DA SILVA <lmfs3>
-- JOÃO VICTOR DE LIMA FREITAS <jvlf>

-- Sequências
CREATE SEQUENCE seq_projeto START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_atuacao START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_campanha START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_doacao START WITH 1 INCREMENT BY 1;

CREATE TABLE Pessoa (
    cpf VARCHAR2(11),
    nome VARCHAR2(100) NOT NULL,
    cep VARCHAR2(8) NOT NULL,
    numero NUMBER NOT NULL,
    CONSTRAINT pk_pessoa PRIMARY KEY (cpf),
    CONSTRAINT chk_pessoa_cpf CHECK (LENGTH(cpf) = 11)
);

CREATE TABLE Projeto_social (
    id_projeto NUMBER,
    nome_projeto VARCHAR2(100) NOT NULL,
    area_atuacao VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_projeto_social PRIMARY KEY (id_projeto)
);

CREATE TABLE Campanha (
    id_campanha NUMBER,
    nome_campanha VARCHAR2(100) NOT NULL,
    meta_arrecadacao NUMBER(12,2) NOT NULL,
    CONSTRAINT pk_campanha PRIMARY KEY (id_campanha),
    CONSTRAINT chk_campanha_meta CHECK (meta_arrecadacao > 0)
);

CREATE TABLE Telefone_pessoa (
    pessoa VARCHAR2(11),
    telefone VARCHAR2(11),
    CONSTRAINT pk_telefone_pessoa PRIMARY KEY (pessoa, telefone),
    CONSTRAINT fk_telefone_pessoa_pessoa FOREIGN KEY (pessoa) REFERENCES Pessoa(cpf)
);

CREATE TABLE Doador (
    cpf_doador VARCHAR2(11),
    CONSTRAINT pk_doador PRIMARY KEY (cpf_doador),
    CONSTRAINT fk_doador_pessoa FOREIGN KEY (cpf_doador) REFERENCES Pessoa(cpf)
);

CREATE TABLE Voluntario (
    cpf_voluntario VARCHAR2(11),
    supervisor VARCHAR2(11),
    CONSTRAINT pk_voluntario PRIMARY KEY (cpf_voluntario),
    CONSTRAINT fk_voluntario_pessoa FOREIGN KEY (cpf_voluntario) REFERENCES Pessoa(cpf),
    CONSTRAINT fk_voluntario_supervisor FOREIGN KEY (supervisor) REFERENCES Voluntario(cpf_voluntario)
);

CREATE TABLE Beneficiario (
    cpf_beneficiario VARCHAR2(11),
    CONSTRAINT pk_beneficiario PRIMARY KEY (cpf_beneficiario),
    CONSTRAINT fk_beneficiario_pessoa FOREIGN KEY (cpf_beneficiario) REFERENCES Pessoa(cpf)
);

CREATE TABLE Atuacao (
    id_atuacao NUMBER,
    voluntario VARCHAR2(11) NOT NULL,
    projeto NUMBER NOT NULL,
    data_inicio DATE NOT NULL,
    data_termino DATE,
    CONSTRAINT pk_atuacao PRIMARY KEY (id_atuacao),
    CONSTRAINT fk_atuacao_voluntario FOREIGN KEY (voluntario) REFERENCES Voluntario(cpf_voluntario),
    CONSTRAINT fk_atuacao_projeto FOREIGN KEY (projeto) REFERENCES Projeto_social(id_projeto),
    CONSTRAINT chk_atuacao_datas CHECK (data_termino IS NULL OR data_termino >= data_inicio)
);

CREATE TABLE Atender (
    beneficiario VARCHAR2(11),
    projeto NUMBER,
    CONSTRAINT pk_atender PRIMARY KEY (beneficiario, projeto),
    CONSTRAINT fk_atender_beneficiario FOREIGN KEY (beneficiario) REFERENCES Beneficiario(cpf_beneficiario),
    CONSTRAINT fk_atender_projeto FOREIGN KEY (projeto) REFERENCES Projeto_social(id_projeto)
);

CREATE TABLE Apoiar (
    campanha NUMBER,
    projeto NUMBER,
    CONSTRAINT pk_apoiar PRIMARY KEY (campanha, projeto),
    CONSTRAINT fk_apoiar_campanha FOREIGN KEY (campanha) REFERENCES Campanha(id_campanha),
    CONSTRAINT fk_apoiar_projeto FOREIGN KEY (projeto) REFERENCES Projeto_social(id_projeto)
);

CREATE TABLE Doacao (
    id_doacao NUMBER,
    doador VARCHAR2(11) NOT NULL,
    campanha NUMBER NOT NULL,
    data DATE DEFAULT SYSDATE NOT NULL,
    tipo VARCHAR2(20) NOT NULL,
    valor NUMBER(10,2),
    CONSTRAINT pk_doacao PRIMARY KEY (id_doacao),
    CONSTRAINT fk_doacao_doador FOREIGN KEY (doador) REFERENCES Doador(cpf_doador),
    CONSTRAINT fk_doacao_campanha FOREIGN KEY (campanha) REFERENCES Campanha(id_campanha),
    CONSTRAINT chk_doacao_tipo CHECK (tipo IN ('FINANCEIRA', 'MATERIAL')),
    CONSTRAINT chk_doacao_valor CHECK ((tipo = 'FINANCEIRA' AND valor > 0) OR (tipo = 'MATERIAL' AND valor IS NULL))
);

CREATE TABLE Item_doacao (
    doacao NUMBER,
    id_item NUMBER,
    descricao VARCHAR2(200) NOT NULL,
    quantidade NUMBER NOT NULL,
    CONSTRAINT pk_item_doacao PRIMARY KEY (doacao, id_item),
    CONSTRAINT fk_item_doacao_doacao FOREIGN KEY (doacao) REFERENCES Doacao(id_doacao),
    CONSTRAINT chk_item_qtd CHECK (quantidade > 0)
);

CREATE TABLE Entregar (
    voluntario VARCHAR2(11),
    beneficiario VARCHAR2(11),
    doacao NUMBER,
    item NUMBER,
    data_entrega DATE DEFAULT SYSDATE,
    qtd_entrega NUMBER NOT NULL,
    CONSTRAINT pk_entregar PRIMARY KEY (voluntario, beneficiario, doacao, item, data_entrega),
    CONSTRAINT fk_entregar_voluntario FOREIGN KEY (voluntario) REFERENCES Voluntario(cpf_voluntario),
    CONSTRAINT fk_entregar_beneficiario FOREIGN KEY (beneficiario) REFERENCES Beneficiario(cpf_beneficiario),
    CONSTRAINT fk_entregar_item FOREIGN KEY (doacao, item) REFERENCES Item_doacao(doacao, id_item),
    CONSTRAINT chk_entregar_qtd CHECK (qtd_entrega > 0)
);