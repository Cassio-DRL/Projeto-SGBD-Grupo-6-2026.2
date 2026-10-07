-- Script: povoamento
-- Instituicao de Caridade - AV3

-- PESSOAS
INSERT INTO Pessoa (cpf, nome, cep, numero) VALUES ('11111111101', 'Ana Beatriz Silva', '52050010', 120);
INSERT INTO Pessoa (cpf, nome, cep, numero) VALUES ('11111111102', 'Carlos Eduardo Lima', '52060020', 315);
INSERT INTO Pessoa (cpf, nome, cep, numero) VALUES ('11111111103', 'Mariana Souza Alves', '50030040', 87);
INSERT INTO Pessoa (cpf, nome, cep, numero) VALUES ('11111111104', 'Joao Pedro Santos', '51020030', 450);
INSERT INTO Pessoa (cpf, nome, cep, numero) VALUES ('11111111105', 'Fernanda Oliveira Costa', '52070050', 210);
INSERT INTO Pessoa (cpf, nome, cep, numero) VALUES ('11111111106', 'Lucas Henrique Rocha', '50040060', 98);
INSERT INTO Pessoa (cpf, nome, cep, numero) VALUES ('11111111107', 'Beatriz Almeida Ferreira', '51030070', 620);
INSERT INTO Pessoa (cpf, nome, cep, numero) VALUES ('11111111108', 'Rafael Gomes Pereira', '52080080', 155);
INSERT INTO Pessoa (cpf, nome, cep, numero) VALUES ('11111111109', 'Juliana Martins Melo', '50050090', 340);
INSERT INTO Pessoa (cpf, nome, cep, numero) VALUES ('11111111110', 'Gabriel Rodrigues Silva', '51060100', 75);
INSERT INTO Pessoa (cpf, nome, cep, numero) VALUES ('11111111111', 'Joao Guilherme Lemos Duarte', '52070110', 500);
INSERT INTO Pessoa (cpf, nome, cep, numero) VALUES ('11111111112', 'Arthur Sean Cerqueira Campos', '50080120', 230);
INSERT INTO Pessoa (cpf, nome, cep, numero) VALUES ('11111111113', 'Larissa Freitas Souza', '51090130', 180);
INSERT INTO Pessoa (cpf, nome, cep, numero) VALUES ('11111111114', 'Roberto Alves Costa', '52100140', 410);
INSERT INTO Pessoa (cpf, nome, cep, numero) VALUES ('11111111115', 'Camila Mendes Rocha', '50110150', 65);

-- TELEFONES
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111101', '81999990001');
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111101', '81988880001');
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111102', '81999990002');
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111103', '81999990003');
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111104', '81999990004');
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111105', '81999990005');
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111106', '81999990006');
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111107', '81999990007');
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111108', '81999990008');
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111109', '81999990009');
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111110', '81999990010');
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111111', '81999990011');
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111112', '81999990012');
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111113', '81999990013');
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111114', '81999990014');
INSERT INTO Telefone_pessoa (pessoa, telefone) VALUES ('11111111115', '81999990015');

-- DOADORES
INSERT INTO Doador (cpf_doador) VALUES ('11111111101');
INSERT INTO Doador (cpf_doador) VALUES ('11111111102');
INSERT INTO Doador (cpf_doador) VALUES ('11111111103');
INSERT INTO Doador (cpf_doador) VALUES ('11111111104');
INSERT INTO Doador (cpf_doador) VALUES ('11111111105');

-- VOLUNTARIOS
INSERT INTO Voluntario (cpf_voluntario, supervisor) VALUES ('11111111106', NULL);
INSERT INTO Voluntario (cpf_voluntario, supervisor) VALUES ('11111111107', NULL);
INSERT INTO Voluntario (cpf_voluntario, supervisor) VALUES ('11111111108', '11111111106');
INSERT INTO Voluntario (cpf_voluntario, supervisor) VALUES ('11111111109', '11111111106');
INSERT INTO Voluntario (cpf_voluntario, supervisor) VALUES ('11111111110', '11111111107');

-- BENEFICIARIOS
INSERT INTO Beneficiario (cpf_beneficiario) VALUES ('11111111111');
INSERT INTO Beneficiario (cpf_beneficiario) VALUES ('11111111112');
INSERT INTO Beneficiario (cpf_beneficiario) VALUES ('11111111113');
INSERT INTO Beneficiario (cpf_beneficiario) VALUES ('11111111114');
INSERT INTO Beneficiario (cpf_beneficiario) VALUES ('11111111115');

-- PROJETOS SOCIAIS
INSERT INTO Projeto_social (id_projeto, nome_projeto, area_atuacao) VALUES (seq_projeto.NEXTVAL, 'Alimentar Recife', 'Alimentacao');
INSERT INTO Projeto_social (id_projeto, nome_projeto, area_atuacao) VALUES (seq_projeto.NEXTVAL, 'Educacao para Todos', 'Educacao');
INSERT INTO Projeto_social (id_projeto, nome_projeto, area_atuacao) VALUES (seq_projeto.NEXTVAL, 'Saude Solidaria', 'Saude');
INSERT INTO Projeto_social (id_projeto, nome_projeto, area_atuacao) VALUES (seq_projeto.NEXTVAL, 'Roupa que Abraca', 'Assistencia Social');
INSERT INTO Projeto_social (id_projeto, nome_projeto, area_atuacao) VALUES (seq_projeto.NEXTVAL, 'Futuro Digital', 'Tecnologia');

-- ATUACOES
INSERT INTO Atuacao (id_atuacao, voluntario, projeto, data_inicio, data_termino) VALUES (seq_atuacao.NEXTVAL, '11111111106', 1, DATE '2026-01-10', NULL);
INSERT INTO Atuacao (id_atuacao, voluntario, projeto, data_inicio, data_termino) VALUES (seq_atuacao.NEXTVAL, '11111111107', 2, DATE '2026-02-01', NULL);
INSERT INTO Atuacao (id_atuacao, voluntario, projeto, data_inicio, data_termino) VALUES (seq_atuacao.NEXTVAL, '11111111108', 1, DATE '2026-03-15', NULL);
INSERT INTO Atuacao (id_atuacao, voluntario, projeto, data_inicio, data_termino) VALUES (seq_atuacao.NEXTVAL, '11111111109', 3, DATE '2026-04-05', NULL);
INSERT INTO Atuacao (id_atuacao, voluntario, projeto, data_inicio, data_termino) VALUES (seq_atuacao.NEXTVAL, '11111111110', 4, DATE '2026-05-20', NULL);
INSERT INTO Atuacao (id_atuacao, voluntario, projeto, data_inicio, data_termino) VALUES (seq_atuacao.NEXTVAL, '11111111106', 5, DATE '2026-06-01', NULL);
INSERT INTO Atuacao (id_atuacao, voluntario, projeto, data_inicio, data_termino) VALUES (seq_atuacao.NEXTVAL, '11111111108', 2, DATE '2026-01-15', DATE '2026-06-30');

-- ATENDIMENTOS
INSERT INTO Atender (beneficiario, projeto) VALUES ('11111111111', 1);
INSERT INTO Atender (beneficiario, projeto) VALUES ('11111111111', 3);
INSERT INTO Atender (beneficiario, projeto) VALUES ('11111111112', 2);
INSERT INTO Atender (beneficiario, projeto) VALUES ('11111111113', 1);
INSERT INTO Atender (beneficiario, projeto) VALUES ('11111111113', 4);
INSERT INTO Atender (beneficiario, projeto) VALUES ('11111111114', 3);
INSERT INTO Atender (beneficiario, projeto) VALUES ('11111111115', 2);
INSERT INTO Atender (beneficiario, projeto) VALUES ('11111111115', 5);

-- CAMPANHAS
INSERT INTO Campanha (id_campanha, nome_campanha, meta_arrecadacao) VALUES (seq_campanha.NEXTVAL, 'Natal Sem Fome', 50000.00);
INSERT INTO Campanha (id_campanha, nome_campanha, meta_arrecadacao) VALUES (seq_campanha.NEXTVAL, 'Volta as Aulas Solidaria', 20000.00);
INSERT INTO Campanha (id_campanha, nome_campanha, meta_arrecadacao) VALUES (seq_campanha.NEXTVAL, 'Inverno Solidario', 30000.00);
INSERT INTO Campanha (id_campanha, nome_campanha, meta_arrecadacao) VALUES (seq_campanha.NEXTVAL, 'Saude para Todos', 40000.00);
INSERT INTO Campanha (id_campanha, nome_campanha, meta_arrecadacao) VALUES (seq_campanha.NEXTVAL, 'Conexao Solidaria', 25000.00);

-- APOIO DAS CAMPANHAS AOS PROJETOS
INSERT INTO Apoiar (campanha, projeto) VALUES (1, 1);
INSERT INTO Apoiar (campanha, projeto) VALUES (1, 4);
INSERT INTO Apoiar (campanha, projeto) VALUES (2, 2);
INSERT INTO Apoiar (campanha, projeto) VALUES (2, 5);
INSERT INTO Apoiar (campanha, projeto) VALUES (3, 4);
INSERT INTO Apoiar (campanha, projeto) VALUES (4, 3);
INSERT INTO Apoiar (campanha, projeto) VALUES (5, 5);

-- DOACOES
INSERT INTO Doacao (id_doacao, doador, campanha, data, tipo, valor) VALUES (seq_doacao.NEXTVAL, '11111111101', 1, DATE '2026-09-01', 'FINANCEIRA', 1500.00);
INSERT INTO Doacao (id_doacao, doador, campanha, data, tipo, valor) VALUES (seq_doacao.NEXTVAL, '11111111102', 2, DATE '2026-09-05', 'FINANCEIRA', 800.00);
INSERT INTO Doacao (id_doacao, doador, campanha, data, tipo, valor) VALUES (seq_doacao.NEXTVAL, '11111111103', 4, DATE '2026-09-10', 'FINANCEIRA', 2000.00);
INSERT INTO Doacao (id_doacao, doador, campanha, data, tipo, valor) VALUES (seq_doacao.NEXTVAL, '11111111104', 5, DATE '2026-09-15', 'FINANCEIRA', 1200.00);
INSERT INTO Doacao (id_doacao, doador, campanha, data, tipo, valor) VALUES (seq_doacao.NEXTVAL, '11111111101', 1, DATE '2026-09-20', 'MATERIAL', NULL);
INSERT INTO Doacao (id_doacao, doador, campanha, data, tipo, valor) VALUES (seq_doacao.NEXTVAL, '11111111102', 2, DATE '2026-09-22', 'MATERIAL', NULL);
INSERT INTO Doacao (id_doacao, doador, campanha, data, tipo, valor) VALUES (seq_doacao.NEXTVAL, '11111111103', 3, DATE '2026-09-25', 'MATERIAL', NULL);
INSERT INTO Doacao (id_doacao, doador, campanha, data, tipo, valor) VALUES (seq_doacao.NEXTVAL, '11111111105', 4, DATE '2026-09-28', 'MATERIAL', NULL);

-- ITENS DE DOACAO
INSERT INTO Item_doacao (doacao, id_item, descricao, quantidade) VALUES (5, 1, 'Cesta basica', 20);
INSERT INTO Item_doacao (doacao, id_item, descricao, quantidade) VALUES (5, 2, 'Pacote de arroz 5kg', 30);
INSERT INTO Item_doacao (doacao, id_item, descricao, quantidade) VALUES (5, 3, 'Pacote de feijao 1kg', 30);
INSERT INTO Item_doacao (doacao, id_item, descricao, quantidade) VALUES (6, 1, 'Caderno universitario', 50);
INSERT INTO Item_doacao (doacao, id_item, descricao, quantidade) VALUES (6, 2, 'Caixa de lapis de cor', 25);
INSERT INTO Item_doacao (doacao, id_item, descricao, quantidade) VALUES (6, 3, 'Mochila escolar', 15);
INSERT INTO Item_doacao (doacao, id_item, descricao, quantidade) VALUES (7, 1, 'Cobertor', 40);
INSERT INTO Item_doacao (doacao, id_item, descricao, quantidade) VALUES (7, 2, 'Casaco', 30);
INSERT INTO Item_doacao (doacao, id_item, descricao, quantidade) VALUES (8, 1, 'Kit de higiene', 35);
INSERT INTO Item_doacao (doacao, id_item, descricao, quantidade) VALUES (8, 2, 'Caixa de sabonete', 20);

-- ENTREGAS
INSERT INTO Entregar (voluntario, beneficiario, doacao, item, data_entrega, qtd_entrega) VALUES ('11111111106', '11111111111', 5, 1, DATE '2026-10-01', 2);
INSERT INTO Entregar (voluntario, beneficiario, doacao, item, data_entrega, qtd_entrega) VALUES ('11111111108', '11111111113', 5, 1, DATE '2026-10-01', 1);
INSERT INTO Entregar (voluntario, beneficiario, doacao, item, data_entrega, qtd_entrega) VALUES ('11111111107', '11111111112', 6, 1, DATE '2026-10-02', 3);
INSERT INTO Entregar (voluntario, beneficiario, doacao, item, data_entrega, qtd_entrega) VALUES ('11111111107', '11111111115', 6, 3, DATE '2026-10-02', 1);
INSERT INTO Entregar (voluntario, beneficiario, doacao, item, data_entrega, qtd_entrega) VALUES ('11111111110', '11111111113', 7, 1, DATE '2026-10-03', 2);
INSERT INTO Entregar (voluntario, beneficiario, doacao, item, data_entrega, qtd_entrega) VALUES ('11111111109', '11111111114', 8, 1, DATE '2026-10-04', 2);
INSERT INTO Entregar (voluntario, beneficiario, doacao, item, data_entrega, qtd_entrega) VALUES ('11111111106', '11111111111', 5, 2, DATE '2026-10-05', 3);

COMMIT;