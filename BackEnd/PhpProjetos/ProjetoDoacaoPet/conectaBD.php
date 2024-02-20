<?php
// endereco
// nome do BD
// admin
// senha
$endereco = 'localhost';
$banco = 'luisnoite';
$admin = 'postgres';
$senha = 'postgres';
try {
    // sgbd:host;port;dbname
    // admin
    // senha
    // errmode
    $pdo = new PDO(//pdo vem da extenção do composer
        "pgsql:host=$endereco;port=5432;dbname=$banco",
        $admin,
        $senha,
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION] //linha que vai chamar os elementos para fazer a conexao com o banco
    );
    echo "Conectado no banco de dados!!!";
    $sql = "CREATE TABLE IF NOT EXISTS usuarios(ID SERIAL,
    NOME VARCHAR(255), DATA_NASCIMENTO VARCHAR(255), TELEFONE VARCHAR(255),
     EMAIL VARCHAR(255) PRIMARY KEY, SENHA VARCHAR(255))";
     $stmt = $pdo->prepare($sql);
     $stmt ->execute();
     
} catch (PDOException $e) {
    echo "Falha ao conectar ao banco de dados. <br/>";
    die($e->getMessage());
}
