<?php
include 'functions.php';
$pdo = pdo_connect_pgsql();
$msg = '';
// Verifica se o ID do contato existe, por exemplo, update.php?id=1 irá obter o contato com o id 1
if (isset($_GET['id'])) {
    if (!empty($_POST)) {
        // Esta parte é semelhante ao create.php, mas aqui estamos atualizando um registro e não inserindo
        $id_contato = isset($_POST['id']) ? $_POST['id'] : NULL;
        $nome = isset($_POST['nome']) ? $_POST['nome'] : '';
        $email = isset($_POST['email']) ? $_POST['email'] : '';
        $cel = isset($_POST['cel']) ? $_POST['cel'] : '';
        $pizza = isset($_POST['pizza']) ? $_POST['pizza'] : '';
        $situacao = isset($_POST['situacao']) ? $_POST['situacao'] : '';
        // Atualiza o registro
        $stmt = $pdo->prepare('UPDATE entregas SET id_entrega = ?, nome = ?, email = ?, cel = ?, pizza = ?, situacao = ? WHERE id_entrega = ?');
        $stmt->execute([$id_entrega, $nome, $email, $cel, $pizza, $situacao, $_GET['id']]);
        $msg = 'Atualização Realizada com Sucesso!';
    }
    // Obter o contato da tabela entregas
    $stmt = $pdo->prepare('SELECT * FROM entregas WHERE id_entrega = ?');
    $stmt->execute([$_GET['id']]);
    $entregas = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$entregas) {
        exit('Pedido Não Localizado!');
    }
} else {
    exit('Nenhum Pedido Especificada!');
}
?>


<?= template_header('Atualizar/Alterar Pedidos') ?>

<div class="content update">
    <h2>Atualizar Pedido ---- <?= $entregas['nome'] ?></h2>
    <form action="update.php?id=<?= $entregas['id_entrega'] ?>" method="post">
        <label for="id_entrega">ID</label>
        <label for="nome">Nome</label>
        <input type="text" name="id" placeholder="" value="<?= $entregas['id_entrega'] ?>" id="id_entrega">
        <input type="text" name="nome" placeholder="Seu Nome" value="<?= $entregas['nome'] ?>" id="nome">
        <label for="email">Email</label>
        <label for="cel">Celular</label>
        <input type="text" name="email" placeholder="seuemail@seuprovedor.com.br" value="<?= $entregas['email'] ?>" id="email">
        <input type="text" name="cel" placeholder="(XX) X.XXXX-XXXX" value="<?= $entregas['cel'] ?>" id="cel">
        <label for="pizza">Pizza</label>
        <label for="created">Situação</label>
        <select name="pizza" id="pizza">
            <option value="em andamento" <?php if ($entregas['pizza'] == "em andamento") echo "selected"; ?>>Em andamento</option>
            <option value="finalizado" <?php if ($entregas['pizza'] == "finalizado") echo "selected"; ?>>Finalizado</option>
            <option value="cancelado" <?php if ($entregas['pizza'] == "cancelado") echo "selected"; ?>>Cancelado</option>
        </select>

        <input type="submit" value="Atualizar">
    </form>
    <?php if ($msg) : ?>
        <p><?= $msg ?></p>
    <?php endif; ?>
</div>

<?= template_footer() ?>