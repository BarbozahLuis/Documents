<?php
    include 'functions.php';
  
    // Verificar se foi feita uma pesquisa
    if(isset($_GET['search'])) {
        // Conectar ao banco de dados PostgreSQL
        $pdo = pdo_connect_pgsql();

        // Preparar a consulta SQL para buscar as pizzas com o sabor selecionado
        $search = '%' . $_GET['search'] . '%';
        $stmt = $pdo->prepare('SELECT * FROM promocoes WHERE descricao LIKE :search');
        $stmt->bindValue(':search', $search, PDO::PARAM_STR);
        $stmt->execute();

        // Obter os resultados da consulta
        $contacts = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Verificar se foram encontrados resultados
        if(empty($contacts)) {
            $error = 'Nenhuma promoção encontrada para o sabor de pizza especificado.';
        }
    }
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resultados da Pesquisa</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        form {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 300px;
            margin-bottom: 10px;
        }
        button[type="submit"], button[type="button"] {
            padding: 8px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button[type="submit"]:hover, button[type="button"]:hover {
            background-color: #45a049;
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        .error {
            color: red;
        }
    </style>
</head>

<body>
    <?=template_header('Pizzaria Lebron James')?><br><br>
    <div class="content read">
        <form class="" id="searchForm" action="" method="get">
            <label for="search">Pesquisar por promoção de pizza:</label>
            <select id="search" name="search">
                <option value="">Selecione a promoção...</option>
                <?php
                    // Conectar ao banco de dados PostgreSQL
                    $pdo = pdo_connect_pgsql();

                    // Preparar a consulta SQL para obter os sabores de pizza
                    $stmt = $pdo->query('SELECT DISTINCT descricao FROM promocoes');
                    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                        $selected = ($_GET['search'] ?? '') === $row['descricao'] ? 'selected' : '';
                        echo '<option value="' . htmlspecialchars($row['descricao'], ENT_QUOTES) . '" ' . $selected . '>' . htmlspecialchars($row['descricao'], ENT_QUOTES) . '</option>';
                    }
                ?>
            </select>
            <button class="create-contact" type="submit" id="searchButton">Pesquisar</button>
            <button type="button" id="clearButton">Limpar</button>
        </form>
    </div>

    <div class="content read">
        <?php if (isset($error)): ?>
            <p class="error"><?=htmlspecialchars($error, ENT_QUOTES)?></p>
        <?php elseif (isset($contacts)): ?>
            <h3>Resultados da Pesquisa</h3>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Descrição</th>
                        <th>Desconto</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($contacts as $contact): ?>
                        <tr>
                            <td><?=$contact['id_promocao']?></td>
                            <td><?=$contact['descricao']?></td>
                            <td><?=$contact['desconto']?></td>
                            <td class="actions">
                    <a href="alterar_entrega.php?id=<?=$contact['id_promocao']?>" class="edit"><i class="fas fa-pen fa-xs"></i></a>
                    <a href="apagar_entrega.php?id=<?=$contact['id_promocao']?>" class="trash"><i class="fas fa-trash fa-xs"></i></a>
                </td>
            </tr>
            <?php endforeach; ?>
                </tbody>
            </table>
            
        <?php endif; ?>
    </div>

    <script>
        document.getElementById('clearButton').addEventListener('click', function() {
            document.getElementById('search').selectedIndex = 0;
        });
    </script>
</body>
</html>
