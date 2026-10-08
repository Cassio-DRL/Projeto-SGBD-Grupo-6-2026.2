--! teste 1
--* pessoas que sao doador e beneficiario
SELECT p.cpf, p.nome FROM Pessoa p JOIN Doador d ON d.cpf_doador = p.cpf JOIN Beneficiario b ON b.cpf_beneficiario = p.cpf;

--! teste 2
-- voluntarrios que tiveram atuacao em mais de um periodo no mesmo projeto
SELECT voluntario, projeto, COUNT(*) AS qtd_atuacoes FROM Atuacao  GROUP BY voluntario, projeto HAVING COUNT(*) > 1;

--! teste 3
-- mesmo doador realizando varias doacoes para a mesma campanha
SELECT doador, campanha, COUNT(*) AS qtd_doacoes FROM Doacao GROUP BY doador, campanha HAVING COUNT(*) >1;

--! teste 4
-- mesma combinacao voluntario/beneficiario/item registrada em diferentes datas
SELECT voluntario, beneficiario, doacao, item, COUNT(*) AS qtd_entregas FROM Entregar GROUP BY voluntario, beneficiario, doacao, item HAVING COUNT(*) > 1;

--! teste 5
-- fluxo completo = doador -> doacao -> item_doacao -> entrega -> beneficiario
SELECT 
    pd.nome AS doador, 
    d.id_doacao, 
    c.nome_campanha, 
    i.descricao AS item, 
    i.quantidade AS qtd_recebida, 
    pv.nome AS voluntario_entrega, 
    pb.nome AS beneficiario, 
    e.qtd_entrega, 
    e.data_entrega 
FROM Doacao d 
JOIN Doador doa 
    ON doa.cpf_doador = d.doador 
JOIN Pessoa pd 
    ON pd.cpf = doa.cpf_doador 
JOIN Campanha c 
    ON c.id_campanha = d.campanha
JOIN Item_doacao i 
    ON i.doacao = d.id_doacao 
JOIN Entregar e 
    ON e.doacao = i.doacao AND e.item = i.id_item 
JOIN Voluntario v 
    ON v.cpf_voluntario = e.voluntario 
JOIN Pessoa pv 
    ON pv.cpf = v.cpf_voluntario 
JOIN Beneficiario b 
    ON b.cpf_beneficiario = e.beneficiario 
JOIN Pessoa pb 
    ON pb.cpf = b.cpf_beneficiario 
ORDER BY d.id_doacao, i.id_item, e.data_entrega;

--! teste 6 
-- quantidade rrecebida, entregue e saldo de cada item
SELECT 
    i.doacao,
    i.id_item,
    i.descricao,
    i.quantidade AS qtd_recebida,
    NVL(SUM(e.qtd_entrega), 0) AS qtd_entregue,
    i.quantidade - NVL(SUM(e.qtd_entrega), 0) AS saldo
FROM Item_doacao i
LEFT JOIN Entregar e
    ON e.doacao = i.doacao
    AND e.item = i.id_item
GROUP BY
    i.doacao,
    i.id_item,
    i.descricao,
    i.quantidade
ORDER BY i.doacao, i.id_item;

--? testes negativos de constraints (melhor executar um por vez)

--! teste 7
-- deve falhar: meta de campanha negativa
/*
INSERT INTO Campanha (
    id_campanha,
    nome_campanha,
    meta_arrecadacao
)
VALUES (
    999,
    'Campanha Invalida',
    -100
);
*/


--! teste 8
-- deve falhar: data de termino anterior a data de inicio
/*
INSERT INTO Atuacao (
    id_atuacao,
    voluntario,
    projeto,
    data_inicio,
    data_termino
)
VALUES (
    999,
    '11111111106',
    1,
    DATE '2026-10-10',
    DATE '2026-01-01'
);
*/


--! teste 9
-- deve falhar: doacao financeira sem valor positivo
/*
INSERT INTO Doacao (
    id_doacao,
    doador,
    campanha,
    data,
    tipo,
    valor
)
VALUES (
    999,
    '11111111101',
    1,
    DATE '2026-10-07',
    'FINANCEIRA',
    NULL
);
*/


--! teste 10
-- deve falhar: beneficiario inexistente viola chave estrangeira
/*
INSERT INTO Beneficiario (
    cpf_beneficiario
)
VALUES (
    '99999999999'
);
*/

--! teste 11
-- deve falhar: entrega com item inexistente para a doacao
-- testa chave estrangeira composta de Entregar -> Item_doacao

/*
INSERT INTO Entregar (
    voluntario,
    beneficiario,
    doacao,
    item,
    data_entrega,
    qtd_entrega
)
VALUES (
    '11111111106',   -- voluntario existente
    '11111111111',   -- beneficiario existente
    5,               -- doacao existente
    99,              -- item inexistente dentro da doacao 5
    DATE '2026-10-08',
    2
);
*/