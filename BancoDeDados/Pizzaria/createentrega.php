<?php
include 'functions.php';
$pdo = pdo_connect_pgsql();
$msg = '';
// Verifica se os dados POST não estão vazios
if (!empty($_POST)) {
    // Se os dados POST não estiverem vazios, insere um novo registro
    // Configura as variáveis que serão inserid_contatoas. Devemos verificar se as variáveis POST existem e, se não existirem, podemos atribuir um valor padrão a elas.
    $id_entrega = isset($_POST['id_entrega']) && !empty($_POST['id_entrega']) && $_POST['id_entrega'] != 'auto' ? $_POST['id_entrega'] : NULL;
    // Verifica se a variável POST "nome" existe, se não existir, atribui o valor padrão para vazio, basicamente o mesmo para todas as variáveis
    $nome = isset($_POST['nome']) ? $_POST['nome'] : '';
    $email = isset($_POST['email']) ? $_POST['email'] : '';
    $cel = isset($_POST['cel']) ? $_POST['cel'] : '';
    $pizza = isset($_POST['pizza']) ? $_POST['pizza'] : '';
    $situacao = isset($_POST['situacao']) ? $_POST['situacao'] : date('Y-m-d H:i:s');
    // Insere um novo registro na tabela contacts
    $stmt = $pdo->prepare('INSERT INTO contatos (id_entrega, nome, email, cel, pizza, situacao) VALUES (?, ?, ?, ?, ?, ?)');
    $stmt->execute([$id_entrega, $nome, $email, $cel, $pizza, $situacao]);
    // Mensagem de saída
    $msg = 'Pedido Realizado com Sucesso!';
}
?>


<?= template_header('situacao de Pedidos') ?>

<div class="content update">
    <h2>Registrar Pedido</h2>
    <form action="createentrega.php" method="post">
        <label for="id_entrega">ID</label>
        <label for="nome">Nome</label>
        <input type="text" name="id_entrega" placeholder="" value="" id_entrega="id_entrega">
        <input type="text" name="nome" placeholder="Seu Nome" id_entrega="nome">
        <label for="email">Email</label>
        <label for="cel">Celular</label>
        <input type="text" name="email" placeholder="seuemail@seuprovedor.com.br" id_entrega="email">
        <input type="text" name="cel" placeholder="(XX) X.XXXX-XXXX" id_entrega="cel">
        <label for="pizza">Sabor Pizza</label>
        <label for="situacao">Situação da Entrega</label>
        <select name="pizza" id="pizza">
            <option value="em andamento">Em andamento</option>
            <option value="finalizado">Finalizado</option>
            <option value="cancelado">Cancelado</option>
        </select>

        <input type="submit" value="Realizar Pedido">
    </form>
    <?php if ($msg) : ?>
        <p><?= $msg ?></p>
    <?php endif; ?>
</div>

<?= template_footer() ?>