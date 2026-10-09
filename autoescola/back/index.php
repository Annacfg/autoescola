<?php

header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . '/config.php';

$method = $_SERVER['REQUEST_METHOD'];

if (isset($_GET['rota'])) {
    $path = '/' . trim($_GET['rota'], '/');
} else {
    $path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    $path = rtrim($path, '/');

    $path = preg_replace(
        '#^.*/(alunos|instrutores)(?=/|$)#',
        '/$1',
        $path
    );
}

function responder($dados, $status = 200) {
    http_response_code($status);

    echo json_encode(
        $dados,
        JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES
    );

    exit;
}

function receberJson() {
    $dados = json_decode(file_get_contents('php://input'), true);

    if (!is_array($dados)) {
        responder(['erro' => 'Envie um JSON válido.'], 400);
    }

    return $dados;
}

if ($method === 'GET' && $path === '/alunos') {
    $stmt = $pdo->query(
        'SELECT * FROM Alunos ORDER BY id DESC'
    );

    responder($stmt->fetchAll());
}

if ($method === 'POST' && $path === '/alunos/create') {
    $dados = receberJson();

    $nome = trim($dados['nome'] ?? '');
    $email = trim($dados['email'] ?? '');
    $telefone = trim($dados['telefone'] ?? '');
    $dataNascimento = $dados['data_nascimento'] ?? '';

    if (
        $nome === '' ||
        $email === '' ||
        $telefone === '' ||
        $dataNascimento === ''
    ) {
        responder([
            'erro' => 'Informe nome, email, telefone e data_nascimento.'
        ], 400);
    }

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        responder(['erro' => 'Informe um e-mail válido.'], 400);
    }

    $data = DateTime::createFromFormat('!Y-m-d', $dataNascimento);

    if (!$data || $data->format('Y-m-d') !== $dataNascimento) {
        responder([
            'erro' => 'A data deve estar no formato AAAA-MM-DD.'
        ], 400);
    }

    try {
        $sql = 'INSERT INTO Alunos
                (nome, email, telefone, data_nascimento)
                VALUES (:nome, :email, :telefone, :data_nascimento)';

        $stmt = $pdo->prepare($sql);

        $stmt->execute([
            ':nome' => $nome,
            ':email' => $email,
            ':telefone' => $telefone,
            ':data_nascimento' => $dataNascimento
        ]);

        responder([
            'mensagem' => 'Aluno cadastrado com sucesso!',
            'id' => (int) $pdo->lastInsertId()
        ], 201);

    } catch (PDOException $e) {
        if ($e->getCode() === '23000') {
            responder([
                'erro' => 'E-mail já cadastrado ou dados duplicados.'
            ], 409);
        }

        responder(['erro' => 'Erro ao cadastrar aluno.'], 500);
    }
}

if ($method === 'GET' && $path === '/instrutores') {
    $stmt = $pdo->query(
        'SELECT * FROM Instrutores ORDER BY id DESC'
    );

    responder($stmt->fetchAll());
}

if ($method === 'POST' && $path === '/instrutores/create') {
    $dados = receberJson();

    $nome = trim($dados['nome'] ?? '');
    $email = trim($dados['email'] ?? '');
    $telefone = trim($dados['telefone'] ?? '');
    $categoriaCnh = trim($dados['categoria_cnh'] ?? '');

    if (
        $nome === '' ||
        $email === '' ||
        $telefone === '' ||
        $categoriaCnh === ''
    ) {
        responder([
            'erro' => 'Informe nome, email, telefone e categoria_cnh.'
        ], 400);
    }

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        responder(['erro' => 'Informe um e-mail válido.'], 400);
    }

    try {
        $sql = 'INSERT INTO Instrutores
                (nome, email, telefone, categoria_cnh)
                VALUES (:nome, :email, :telefone, :categoria_cnh)';

        $stmt = $pdo->prepare($sql);

        $stmt->execute([
            ':nome' => $nome,
            ':email' => $email,
            ':telefone' => $telefone,
            ':categoria_cnh' => $categoriaCnh
        ]);

        responder([
            'mensagem' => 'Instrutor cadastrado com sucesso!',
            'id' => (int) $pdo->lastInsertId()
        ], 201);

    } catch (PDOException $e) {
        if ($e->getCode() === '23000') {
            responder([
                'erro' => 'E-mail já cadastrado ou dados duplicados.'
            ], 409);
        }

        responder(['erro' => 'Erro ao cadastrar instrutor.'], 500);
    }
}

responder(['erro' => 'Rota não encontrada.'], 404);