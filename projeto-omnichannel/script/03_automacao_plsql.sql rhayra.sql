-- 1. Mude para a base de dados interna do sistema do MySQL
USE mysql;

-- 2. Repare a tabela corrompida informada no erro
REPAIR TABLE tables_priv;

-- 3. (Opcional, por precaução) Repare também as outras tabelas de privilégios para evitar erros futuros
REPAIR TABLE db;
REPAIR TABLE columns_priv;
REPAIR TABLE procs_priv;
REPAIR TABLE proxies_priv;
REPAIR TABLE user;