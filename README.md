# Projeto-SGBD-Grupo-6-2026.2
Projeto para a disciplina de Banco de Dados do semestre 2026.2 - CIn UFPE

**Grupo**:  
CÁSSIO DINIZ ROCHA LEITE [cdrl]  
ISABELA POSSÍDIO AMORIM [ipa]  
LUIZ MIGUEL FREITAS DA SILVA [lmfs3]  
JOÃO VICTOR DE LIMA FREITAS [jvlf]  

**AV3**: script_criacao_av3.sql || povoamento.sql || testes.sql

**AV4**: av4-checklist.sql || script_reset_db.sql    

# Como testar o projeto localmente com Docker e VSCode:

- 1. install docker - enable the service

- 2. test if it is installed and running correctly

```bash
docker run --rm hello-world
```

-  3. get the oracle image

we use the slim image since we don't need the regular one, it's about 1GB

```bash
docker pull gvenzl/oracle-free:slim
```

- 4. create the container

```bash
docker run -d --name oracle-free \
  -p 127.0.0.1:1521:1521 \
  -e ORACLE_PASSWORD=admin123 \
  -e APP_USER=projeto \
  -e APP_USER_PASSWORD=projeto123 \
  -v oracle-data:/opt/oracle/oradata \
  gvenzl/oracle-free:slim
```

wait however long it takes and check the logs to see if it's working correctly

```bash
docker logs -f oracle-free
```

when you see `DATABASE IS READY TO USE!`, you can start working with it

- 5. install the vscode extension "sql developer extension for vscode"

the extension might need java, so make sure to have it installed

- 6. add the connection

click the oracle icon, then the **+** next to connections. fill in:

- connection name: `local-projeto`
- authentication type: default
- username: `projeto`
- password: `projeto123` 
- connection type: basic
- hostname: `localhost`
- port: `1521`
- type: service name
- service name: `FREEPDB1`

click test, and if it works, save.

- 7. run the files

1. `script_criacao_av3.sql`
2. `povoamento.sql`

for each file: open it, pick the `local-projeto` connection for that file (you have to do this for every file), then run it.

- **run script** (f5): runs the whole file. use for creation and povoamento
- **run statement** (ctrl+enter): runs only the one under your cursor. use for the tests so each result shows separately

check if it worked:

```sql
SELECT table_name FROM user_tables;
SELECT COUNT(*) FROM Pessoa;
```

you should see 13 tables and a count of 15, you can also check the tables and the contents on the extension interface

___

- if you want to run any of the scripts again

run the "script_reset_db.sql" file, it will erase all of the tables and registered data inserted into the databasae

- if you want to delete everything:

```bash
docker rm -f oracle-free
docker volume rm oracle-data
```
- commands for daily use after initial setup:

(these commands are specific for my system, your setup might be different)

```bash
docker start oracle-free   # wait for 30 secs and check if it's running
docker stop oracle-free    # when you're done
docker ps                  # check if it's running
```