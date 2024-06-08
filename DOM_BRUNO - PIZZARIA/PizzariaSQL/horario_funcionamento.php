<?php
include 'functions.php';
// Conectar ao banco de dados PostgreSQL
$pdo = pdo_connect_pgsql();
// Obter a página via solicitação GET (parâmetro URL: page), se não existir, defina a página como 1 por padrão
$page = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;
// Número de registros para mostrar em cada página
$records_per_page = 7;

// Preparar a instrução SQL e obter registros da tabela contacts, LIMIT irá determinar a página
$stmt = $pdo->prepare('SELECT 
    dia_semana,
    hora_abertura,
    hora_fechamento
FROM 
    horarios_funcionamento OFFSET :offset LIMIT :limit');
$stmt->bindValue(':offset', ($page - 1) * $records_per_page, PDO::PARAM_INT);
$stmt->bindValue(':limit', $records_per_page, PDO::PARAM_INT);
$stmt->execute();
// Buscar os registros para exibi-los em nosso modelo.
$contacts = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Obter o número total de contatos, isso é para determinar se deve haver um botão de próxima e anterior
$num_contacts = $pdo->query('SELECT COUNT(*) FROM horarios_funcionamento')->fetchColumn();
?>


<?=template_header('Visualizar Pedidos')?>

<div class="content read">
	<h2>Horario de Funcionamento</h2>
	<table>
        <thead>
            <tr>
                <td>Dia</td>
                <td>Horario abertura</td>
                <td>Horario fechamento</td>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($contacts as $contact): ?>
            <tr>
                <td><?=$contact['dia_semana']?></td>
                <td><?=$contact['hora_abertura']?></td>
                <td><?=$contact['hora_fechamento']?></td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    
    

</div>

<?=template_footer()?>