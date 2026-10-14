-- GRUPO 6 - BANCO DE DADOS - CIn UFPE

-- CÁSSIO DINIZ ROCHA LEITE <cdrl>
-- ISABELA POSSÍDIO AMORIM <ipa>
-- LUIZ MIGUEL FREITAS DA SILVA <lmfs3>
-- JOÃO VICTOR DE LIMA FREITAS <jvlf>

-- Instituicao de Caridade - AV4
-- para o script funcionar, tem que executar o script de criacao (script_criacao_av3.sql) e povoamento (povoamento.sql) antes
-- se quiser exectuar de novo, roda o script de reset (script_reset_db.sql), depois o de criacao e povoamento novamente

-- vai ser necessário quando usar dbms output
SET SERVEROUTPUT ON

-- parte 1: sql

-- sql 1 - alter table
-- campanha passa a ter uma situacao (ativa ou encerrada)
ALTER TABLE Campanha ADD (situacao VARCHAR2(15) DEFAULT 'ATIVA' NOT NULL);

-- adiciona constraint pra aceitar somente os valores validos
ALTER TABLE Campanha ADD CONSTRAINT chk_campanha_situacao CHECK (situacao IN ('ATIVA', 'ENCERRADA'));

-- pessoa passa a ter email pra contato (pode ficar vazio)
ALTER TABLE Pessoa ADD (email VARCHAR2(100));


-- sql 2 - create index
-- fk nao cria indice sozinha, entao indexa as colunas mais consultadas
CREATE INDEX idx_doacao_campanha ON Doacao (campanha);

CREATE INDEX idx_entregar_beneficiario ON Entregar (beneficiario);

-- ajuda nas buscas de pessoa pelo nome
CREATE INDEX idx_pessoa_nome ON Pessoa (nome);


-- sql 3 - insert into
-- nova campanha de pascoa (a situacao entra como ATIVA por padrao)
INSERT INTO Campanha (id_campanha, nome_campanha, meta_arrecadacao) VALUES (seq_campanha.NEXTVAL, 'Pascoa Solidaria', 15000.00);

-- doacao financeira do joao pedro pra campanha de inverno
INSERT INTO Doacao (id_doacao, doador, campanha, data, tipo, valor) VALUES (seq_doacao.NEXTVAL, '11111111104', 3, DATE '2026-10-08', 'FINANCEIRA', 950.00);

-- a mesma doacao foi lancada duas vezes por engano, o delete la embaixo corrige isso
INSERT INTO Doacao (id_doacao, doador, campanha, data, tipo, valor) VALUES (seq_doacao.NEXTVAL, '11111111104', 3, DATE '2026-10-08', 'FINANCEIRA', 950.00);


-- sql 4 - update
-- a campanha de volta as aulas acabou
UPDATE Campanha SET situacao = 'ENCERRADA' WHERE nome_campanha = 'Volta as Aulas Solidaria';

-- natal e a campanha mais forte do ano, entao a meta sobe 10%
UPDATE Campanha SET meta_arrecadacao = meta_arrecadacao * 1.10 WHERE nome_campanha = 'Natal Sem Fome';

-- cadastra o email de algumas pessoas
UPDATE Pessoa SET email = 'ana.silva@gmail.com' WHERE cpf = '11111111101';
UPDATE Pessoa SET email = 'carlos.lima@outlook.com' WHERE cpf = '11111111102';
UPDATE Pessoa SET email = 'mariana.alves@gmail.com' WHERE cpf = '11111111103';
UPDATE Pessoa SET email = 'joao.santos@gmail.com' WHERE cpf = '11111111104';
UPDATE Pessoa SET email = 'lucas.rocha@gmail.com' WHERE cpf = '11111111106';
UPDATE Pessoa SET email = 'beatriz.ferreira@yahoo.com' WHERE cpf = '11111111107';


-- sql 5 - delete
-- apaga a doacao duplicada e mantem so a de menor id
DELETE FROM Doacao
WHERE doador = '11111111104' AND campanha = 3 AND data = DATE '2026-10-08'
  AND id_doacao > (SELECT MIN(id_doacao) FROM Doacao WHERE doador = '11111111104' AND campanha = 3 AND data = DATE '2026-10-08');

COMMIT;


-- sql 6 - select from where
-- campanhas grandes, com meta acima de 30 mil
SELECT nome_campanha, meta_arrecadacao FROM Campanha WHERE meta_arrecadacao > 30000;


-- sql 7 - between
-- doacoes recebidas na primeira quinzena de setembro
SELECT id_doacao, doador, data, tipo, valor FROM Doacao WHERE data BETWEEN DATE '2026-09-01' AND DATE '2026-09-15';


-- sql 8 - in
-- projetos de alimentacao, saude ou educacao
SELECT id_projeto, nome_projeto, area_atuacao FROM Projeto_social WHERE area_atuacao IN ('Alimentacao', 'Saude', 'Educacao');


-- sql 9 - like
-- pessoas que se chamam joao
SELECT cpf, nome FROM Pessoa WHERE nome LIKE 'Joao%';

-- pessoas com email do gmail
SELECT nome, email FROM Pessoa WHERE email LIKE '%@gmail.com';


-- sql 10 - is null / is not null
-- atuacoes ainda em andamento (sem data de termino)
SELECT voluntario, projeto, data_inicio FROM Atuacao WHERE data_termino IS NULL;

-- pessoas sem email cadastrado, pra pedir atualizacao depois
SELECT cpf, nome FROM Pessoa WHERE email IS NULL;


-- sql 11 - inner join
-- quem esta atuando em qual projeto agora
SELECT p.nome AS voluntario, ps.nome_projeto, a.data_inicio
FROM Atuacao a
INNER JOIN Voluntario v ON v.cpf_voluntario = a.voluntario
INNER JOIN Pessoa p ON p.cpf = v.cpf_voluntario
INNER JOIN Projeto_social ps ON ps.id_projeto = a.projeto
WHERE a.data_termino IS NULL
ORDER BY p.nome;


-- sql 12 - max
-- maior doacao financeira ja recebida
SELECT MAX(valor) AS maior_doacao FROM Doacao WHERE tipo = 'FINANCEIRA';


-- sql 13 - min
-- data da primeira doacao da instituicao
SELECT MIN(data) AS primeira_doacao FROM Doacao;


-- sql 14 - avg
-- valor medio das doacoes financeiras
SELECT ROUND(AVG(valor), 2) AS media_doacoes_financeiras FROM Doacao WHERE tipo = 'FINANCEIRA';


-- sql 15 - count
-- total de doacoes registradas
SELECT COUNT(*) AS total_doacoes FROM Doacao;

-- quantas pessoas diferentes ja doaram
SELECT COUNT(DISTINCT doador) AS qtd_doadores FROM Doacao;


-- sql 16 - left join
-- campanhas que ainda nao receberam nenhuma doacao
SELECT c.id_campanha, c.nome_campanha
FROM Campanha c
LEFT JOIN Doacao d ON d.campanha = c.id_campanha
WHERE d.id_doacao IS NULL;


-- sql 17 - subconsulta com operador relacional
-- doacoes financeiras acima da media
SELECT id_doacao, doador, valor
FROM Doacao
WHERE tipo = 'FINANCEIRA'
  AND valor > (SELECT AVG(valor) FROM Doacao WHERE tipo = 'FINANCEIRA')
ORDER BY valor DESC;


-- sql 18 - subconsulta com in
-- pessoas que ja fizeram alguma doacao material
SELECT cpf, nome FROM Pessoa WHERE cpf IN (SELECT doador FROM Doacao WHERE tipo = 'MATERIAL');


-- sql 19 - subconsulta com any
-- campanhas com meta maior que a meta de pelo menos uma das campanhas pequenas
SELECT nome_campanha, meta_arrecadacao
FROM Campanha
WHERE meta_arrecadacao > ANY (SELECT meta_arrecadacao FROM Campanha WHERE nome_campanha IN ('Volta as Aulas Solidaria', 'Conexao Solidaria'));


-- sql 20 - subconsulta com all
-- campanhas com meta maior que a de todas as campanhas ja encerradas
SELECT nome_campanha, meta_arrecadacao
FROM Campanha
WHERE meta_arrecadacao > ALL (SELECT meta_arrecadacao FROM Campanha WHERE situacao = 'ENCERRADA');


-- sql 21 - order by
-- doacoes financeiras da maior pra menor
SELECT id_doacao, doador, data, valor FROM Doacao WHERE tipo = 'FINANCEIRA' ORDER BY valor DESC;


-- sql 22 - group by
-- quanto cada campanha arrecadou em dinheiro
SELECT c.nome_campanha, COUNT(d.id_doacao) AS qtd_doacoes, SUM(d.valor) AS total_arrecadado
FROM Doacao d
INNER JOIN Campanha c ON c.id_campanha = d.campanha
WHERE d.tipo = 'FINANCEIRA'
GROUP BY c.nome_campanha
ORDER BY total_arrecadado DESC;


-- sql 23 - having
-- doadores destaque: quem doou mais de 1500 no total
SELECT p.nome, SUM(d.valor) AS total_doado
FROM Doacao d
INNER JOIN Pessoa p ON p.cpf = d.doador
WHERE d.tipo = 'FINANCEIRA'
GROUP BY p.nome
HAVING SUM(d.valor) > 1500;


-- sql 24 - union / intersect / minus
-- todas as pessoas que ajudam a instituicao, como doador ou como voluntario
SELECT cpf_doador AS cpf FROM Doador
UNION
SELECT cpf_voluntario FROM Voluntario;

-- pessoas que sao doadoras e voluntarias ao mesmo tempo
SELECT cpf_doador AS cpf FROM Doador
INTERSECT
SELECT cpf_voluntario FROM Voluntario;

-- doadores que nao sao beneficiarios
SELECT cpf_doador AS cpf FROM Doador
MINUS
SELECT cpf_beneficiario FROM Beneficiario;


-- sql 25 - create view
-- resumo de cada campanha: meta, quanto arrecadou e o percentual
CREATE OR REPLACE VIEW vw_resumo_campanha AS
SELECT c.id_campanha, c.nome_campanha, c.meta_arrecadacao,
       NVL(SUM(d.valor), 0) AS total_arrecadado,
       ROUND(NVL(SUM(d.valor), 0) / c.meta_arrecadacao * 100, 2) AS percentual_meta
FROM Campanha c
LEFT JOIN Doacao d ON d.campanha = c.id_campanha AND d.tipo = 'FINANCEIRA'
GROUP BY c.id_campanha, c.nome_campanha, c.meta_arrecadacao;

SELECT * FROM vw_resumo_campanha ORDER BY percentual_meta DESC;


-- sql 26 - grant / revoke
-- comentado pois o comando não funciona corretamente no ambiente da oracle, rodar isso vai dar o erro ORA-01917
-- caso de uso: o pessoal da transparencia pode consultar o resumo das campanhas pela view, sem enxergar os dados pessoais dos doadores. depois o acesso e retirado.
/*
GRANT SELECT ON vw_resumo_campanha TO auditor_transparencia;

REVOKE SELECT ON vw_resumo_campanha FROM auditor_transparencia;
*/


-- parte 2: pl/sql

-- pl 1, 2, 3, 6, 12 - record, table, bloco anonimo, %type, for in loop
-- monta um relatorio das campanhas na memoria (tabela de records) e depois imprime
DECLARE
  TYPE t_reg_campanha IS RECORD (
    nome       Campanha.nome_campanha%TYPE,
    meta       Campanha.meta_arrecadacao%TYPE,
    arrecadado NUMBER(12,2),
    percentual NUMBER(6,2)
  );
  TYPE t_tab_campanha IS TABLE OF t_reg_campanha INDEX BY PLS_INTEGER;
  v_campanhas t_tab_campanha;
  v_total     NUMBER(12,2);
  v_idx       PLS_INTEGER := 0;
BEGIN
  FOR c IN (SELECT id_campanha, nome_campanha, meta_arrecadacao FROM Campanha ORDER BY id_campanha) LOOP
    SELECT NVL(SUM(valor), 0) INTO v_total FROM Doacao WHERE campanha = c.id_campanha AND tipo = 'FINANCEIRA';
    v_idx := v_idx + 1;
    v_campanhas(v_idx).nome := c.nome_campanha;
    v_campanhas(v_idx).meta := c.meta_arrecadacao;
    v_campanhas(v_idx).arrecadado := v_total;
    v_campanhas(v_idx).percentual := ROUND(v_total / c.meta_arrecadacao * 100, 2);
  END LOOP;
  FOR i IN 1 .. v_campanhas.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(RPAD(v_campanhas(i).nome, 28) || ' arrecadado: ' || TO_CHAR(v_campanhas(i).arrecadado, 'FM9999990.00') || ' (' || TO_CHAR(v_campanhas(i).percentual, 'FM990.00') || '% da meta)');
  END LOOP;
END;
/


-- pl 6, 7, 13, 15 - %rowtype, select into, exception when
-- busca uma pessoa pelo cpf. na segunda busca o cpf nao existe e cai na excecao
DECLARE
  v_cpf    Pessoa.cpf%TYPE;
  v_pessoa Pessoa%ROWTYPE;
BEGIN
  v_cpf := '11111111101';
  SELECT * INTO v_pessoa FROM Pessoa WHERE cpf = v_cpf;
  DBMS_OUTPUT.PUT_LINE('encontrada: ' || v_pessoa.nome || ' (cep ' || v_pessoa.cep || ')');
  v_cpf := '00000000000';
  SELECT * INTO v_pessoa FROM Pessoa WHERE cpf = v_cpf;
  DBMS_OUTPUT.PUT_LINE('essa linha nao deve aparecer');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('cpf ' || v_cpf || ' nao esta cadastrado');
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('existe mais de uma pessoa com esse cpf');
END;
/


-- pl 10, 14 - cursor (open, fetch, close) e loop exit when
-- soma as doacoes financeiras em ordem de data e para assim que chegar em 3000
DECLARE
  CURSOR c_doacoes (p_tipo Doacao.tipo%TYPE) IS
    SELECT id_doacao, valor FROM Doacao WHERE tipo = p_tipo ORDER BY data, id_doacao;
  v_id           Doacao.id_doacao%TYPE;
  v_valor        Doacao.valor%TYPE;
  v_soma         NUMBER(12,2) := 0;
  v_qtd          PLS_INTEGER := 0;
  v_meta_parcial CONSTANT NUMBER := 3000;
BEGIN
  OPEN c_doacoes('FINANCEIRA');
  LOOP
    FETCH c_doacoes INTO v_id, v_valor;
    EXIT WHEN c_doacoes%NOTFOUND;
    v_qtd := v_qtd + 1;
    v_soma := v_soma + v_valor;
    DBMS_OUTPUT.PUT_LINE('doacao ' || v_id || ' somada, total parcial: ' || v_soma);
    EXIT WHEN v_soma >= v_meta_parcial;
  END LOOP;
  CLOSE c_doacoes;
  DBMS_OUTPUT.PUT_LINE('foram necessarias ' || v_qtd || ' doacoes pra passar de ' || v_meta_parcial);
END;
/


-- pl 11 - while loop
-- calcula quantas viagens sao necessarias pra entregar todos os cadernos da doacao 6,
-- sabendo que cada viagem leva 8 unidades
DECLARE
  v_inicial    Item_doacao.quantidade%TYPE;
  v_restante   Item_doacao.quantidade%TYPE;
  v_capacidade CONSTANT NUMBER := 8;
  v_viagens    PLS_INTEGER := 0;
BEGIN
  SELECT quantidade INTO v_inicial FROM Item_doacao WHERE doacao = 6 AND id_item = 1;
  v_restante := v_inicial;
  WHILE v_restante > 0 LOOP
    v_viagens := v_viagens + 1;
    v_restante := v_restante - v_capacidade;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(v_inicial || ' itens, ' || v_capacidade || ' por viagem: ' || v_viagens || ' viagens');
END;
/


-- pl 5, 6, 13 - create function
-- total em dinheiro que uma pessoa ja doou
CREATE OR REPLACE FUNCTION fn_total_doado (p_cpf IN Doador.cpf_doador%TYPE)
RETURN NUMBER IS
  v_total Doacao.valor%TYPE;
BEGIN
  SELECT NVL(SUM(valor), 0) INTO v_total FROM Doacao WHERE doador = p_cpf AND tipo = 'FINANCEIRA';
  RETURN v_total;
END fn_total_doado;
/


-- pl 5, 8 - create function com if elsif
-- classifica o doador pelo total doado
CREATE OR REPLACE FUNCTION fn_nivel_doador (p_cpf IN Doador.cpf_doador%TYPE)
RETURN VARCHAR2 IS
  v_total NUMBER;
BEGIN
  v_total := fn_total_doado(p_cpf);
  IF v_total >= 2000 THEN
    RETURN 'OURO';
  ELSIF v_total >= 1000 THEN
    RETURN 'PRATA';
  ELSIF v_total > 0 THEN
    RETURN 'BRONZE';
  ELSE
    RETURN 'SEM DOACAO FINANCEIRA';
  END IF;
END fn_nivel_doador;
/


-- pl 4, 15, 16 - create procedure com parametros in e out
-- devolve quanto de um item foi recebido, quanto ja foi entregue e o saldo
CREATE OR REPLACE PROCEDURE pr_saldo_item (
  p_doacao   IN  Item_doacao.doacao%TYPE,
  p_item     IN  Item_doacao.id_item%TYPE,
  p_recebido OUT NUMBER,
  p_entregue OUT NUMBER,
  p_saldo    OUT NUMBER
) IS
BEGIN
  SELECT quantidade INTO p_recebido FROM Item_doacao WHERE doacao = p_doacao AND id_item = p_item;
  SELECT NVL(SUM(qtd_entrega), 0) INTO p_entregue FROM Entregar WHERE doacao = p_doacao AND item = p_item;
  p_saldo := p_recebido - p_entregue;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'o item ' || p_item || ' nao existe na doacao ' || p_doacao);
END pr_saldo_item;
/


-- pl 4, 16 - create procedure com parametro in out
-- recebe o cpf so com numeros e devolve ele formatado (000.000.000-00)
CREATE OR REPLACE PROCEDURE pr_formatar_cpf (p_cpf IN OUT VARCHAR2) IS
BEGIN
  IF LENGTH(p_cpf) = 11 THEN
    p_cpf := SUBSTR(p_cpf, 1, 3) || '.' || SUBSTR(p_cpf, 4, 3) || '.' || SUBSTR(p_cpf, 7, 3) || '-' || SUBSTR(p_cpf, 10, 2);
  END IF;
END pr_formatar_cpf;
/


-- pl 3, 15 - testando as funcoes e procedures
DECLARE
  v_cpf      VARCHAR2(14) := '11111111104';
  v_recebido NUMBER;
  v_entregue NUMBER;
  v_saldo    NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('total doado: ' || fn_total_doado(v_cpf));
  DBMS_OUTPUT.PUT_LINE('nivel do doador: ' || fn_nivel_doador(v_cpf));
  pr_formatar_cpf(v_cpf);
  DBMS_OUTPUT.PUT_LINE('cpf formatado: ' || v_cpf);
  pr_saldo_item(5, 1, v_recebido, v_entregue, v_saldo);
  DBMS_OUTPUT.PUT_LINE('cestas basicas: recebidas ' || v_recebido || ', entregues ' || v_entregue || ', saldo ' || v_saldo);
  -- item que nao existe, o erro e esperado
  BEGIN
    pr_saldo_item(99, 1, v_recebido, v_entregue, v_saldo);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('erro esperado: ' || SQLERRM);
  END;
END;
/


-- pl 17 - create or replace package (especificacao)
-- agrupa as rotinas de campanha em um pacote so
CREATE OR REPLACE PACKAGE pkg_campanha AS
  FUNCTION total_arrecadado (p_campanha IN Campanha.id_campanha%TYPE) RETURN NUMBER;
  FUNCTION situacao_meta (p_campanha IN Campanha.id_campanha%TYPE) RETURN VARCHAR2;
  PROCEDURE encerrar (p_campanha IN Campanha.id_campanha%TYPE);
END pkg_campanha;
/


-- pl 18, 9 - create or replace package body (com case when)
CREATE OR REPLACE PACKAGE BODY pkg_campanha AS

  FUNCTION total_arrecadado (p_campanha IN Campanha.id_campanha%TYPE) RETURN NUMBER IS
    v_total NUMBER;
  BEGIN
    SELECT NVL(SUM(valor), 0) INTO v_total FROM Doacao WHERE campanha = p_campanha AND tipo = 'FINANCEIRA';
    RETURN v_total;
  END total_arrecadado;

  -- diz em que pe esta a campanha de acordo com o percentual da meta atingido
  FUNCTION situacao_meta (p_campanha IN Campanha.id_campanha%TYPE) RETURN VARCHAR2 IS
    v_meta       Campanha.meta_arrecadacao%TYPE;
    v_percentual NUMBER;
  BEGIN
    SELECT meta_arrecadacao INTO v_meta FROM Campanha WHERE id_campanha = p_campanha;
    v_percentual := total_arrecadado(p_campanha) / v_meta * 100;
    RETURN CASE
      WHEN v_percentual >= 100 THEN 'META ATINGIDA'
      WHEN v_percentual >= 50 THEN 'MAIS DA METADE'
      WHEN v_percentual >= 5 THEN 'EM ANDAMENTO'
      WHEN v_percentual > 0 THEN 'INICIO'
      ELSE 'SEM DOACOES'
    END;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 'CAMPANHA NAO ENCONTRADA';
  END situacao_meta;

  PROCEDURE encerrar (p_campanha IN Campanha.id_campanha%TYPE) IS
  BEGIN
    UPDATE Campanha SET situacao = 'ENCERRADA' WHERE id_campanha = p_campanha;
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20002, 'campanha ' || p_campanha || ' nao encontrada');
    END IF;
  END encerrar;

END pkg_campanha;
/


-- pl 3, 15 - testando o pacote
-- mostra a situacao de cada campanha, encerra a de pascoa e tenta encerrar uma que nao existe
BEGIN
  FOR c IN (SELECT id_campanha, nome_campanha FROM Campanha ORDER BY id_campanha) LOOP
    DBMS_OUTPUT.PUT_LINE(RPAD(c.nome_campanha, 28) || RPAD(TO_CHAR(pkg_campanha.total_arrecadado(c.id_campanha), 'FM9999990.00'), 10) || pkg_campanha.situacao_meta(c.id_campanha));
  END LOOP;
  pkg_campanha.encerrar(6);
  DBMS_OUTPUT.PUT_LINE('campanha 6 encerrada');
  BEGIN
    pkg_campanha.encerrar(999);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('erro esperado: ' || SQLERRM);
  END;
END;
/

COMMIT;


-- tabela de auditoria que os triggers abaixo vao preencher
CREATE SEQUENCE seq_auditoria START WITH 1 INCREMENT BY 1;

CREATE TABLE Auditoria (
    id_log NUMBER,
    tabela VARCHAR2(30) NOT NULL,
    operacao VARCHAR2(10) NOT NULL,
    detalhe VARCHAR2(200),
    usuario VARCHAR2(30) DEFAULT USER NOT NULL,
    data_log DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_auditoria PRIMARY KEY (id_log)
);


-- pl 19 - trigger de comando
-- dispara uma vez por comando em Entregar, nao importa quantas linhas ele mexa
CREATE OR REPLACE TRIGGER trg_entregar_comando
AFTER INSERT OR UPDATE OR DELETE ON Entregar
DECLARE
  v_operacao Auditoria.operacao%TYPE;
BEGIN
  IF INSERTING THEN
    v_operacao := 'INSERT';
  ELSIF UPDATING THEN
    v_operacao := 'UPDATE';
  ELSE
    v_operacao := 'DELETE';
  END IF;
  INSERT INTO Auditoria (id_log, tabela, operacao, detalhe)
  VALUES (seq_auditoria.NEXTVAL, 'ENTREGAR', v_operacao, 'comando executado na tabela de entregas');
END;
/


-- pl 20 - trigger de linha
-- dispara uma vez por doacao afetada e guarda o que mudou
CREATE OR REPLACE TRIGGER trg_doacao_linha
AFTER INSERT OR UPDATE OR DELETE ON Doacao
FOR EACH ROW
DECLARE
  v_operacao Auditoria.operacao%TYPE;
  v_detalhe  Auditoria.detalhe%TYPE;
BEGIN
  IF INSERTING THEN
    v_operacao := 'INSERT';
    v_detalhe := 'doacao ' || :NEW.id_doacao || ' (' || :NEW.tipo || ') registrada';
  ELSIF UPDATING THEN
    v_operacao := 'UPDATE';
    v_detalhe := 'doacao ' || :OLD.id_doacao || ' alterada, valor de ' || NVL(TO_CHAR(:OLD.valor), 'nulo') || ' para ' || NVL(TO_CHAR(:NEW.valor), 'nulo');
  ELSE
    v_operacao := 'DELETE';
    v_detalhe := 'doacao ' || :OLD.id_doacao || ' removida';
  END IF;
  INSERT INTO Auditoria (id_log, tabela, operacao, detalhe)
  VALUES (seq_auditoria.NEXTVAL, 'DOACAO', v_operacao, v_detalhe);
END;
/


-- teste dos triggers
-- doacao: insere, altera e apaga (o trigger de linha registra as tres operacoes)
INSERT INTO Doacao (id_doacao, doador, campanha, data, tipo, valor) VALUES (seq_doacao.NEXTVAL, '11111111105', 3, DATE '2026-10-09', 'FINANCEIRA', 300.00);
UPDATE Doacao SET valor = 350.00 WHERE doador = '11111111105' AND data = DATE '2026-10-09';
DELETE FROM Doacao WHERE doador = '11111111105' AND data = DATE '2026-10-09';

-- entrega: insere e apaga (o trigger de comando registra os dois comandos)
INSERT INTO Entregar (voluntario, beneficiario, doacao, item, data_entrega, qtd_entrega) VALUES ('11111111107', '11111111112', 6, 2, DATE '2026-10-09', 5);
DELETE FROM Entregar WHERE voluntario = '11111111107' AND beneficiario = '11111111112' AND doacao = 6 AND item = 2 AND data_entrega = DATE '2026-10-09';

COMMIT;

SELECT id_log, tabela, operacao, detalhe, usuario, data_log FROM Auditoria ORDER BY id_log;