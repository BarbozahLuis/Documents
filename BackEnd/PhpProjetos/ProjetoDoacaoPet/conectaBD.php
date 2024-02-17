<?php
// endereco
// nome do BD
// usuario
// senha
$endereco = 'localhost';
$banco = 'postgres';
$usuario = 'postgres';
$senha = 'postgres';
try {
    // sgbd:host;port;dbname
    // usuario
    // senha
    // errmode
    $pdo = new PDO(
        "pgsql:host=$endereco;port=5432;dbname=$banco",
        $usuario,
        $senha,
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION] //linha que vai chamar os elementos para fazer a conexao com o banco
    );
    echo "Conectado no banco de dados!!!";
    $sql = "CREATE TABLE IF NOT EXISTS usuarios
    (nome VARCHAR(255), data_nascimento VARCHAR(255), telefone VARCHAR(255),
     email VARCHAR(255) PRIMERY KEY, senha VARCHAR(255))";
     $stmt = $pdo->prepare($sql);
     
} catch (PDOException $e) {
    echo "Falha ao conectar ao banco de dados. <br/>";
    die($e->getMessage());
}
