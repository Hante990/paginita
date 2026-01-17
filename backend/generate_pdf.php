<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

// Para pruebas, devolver URL de ejemplo
$id = $_GET['id'] ?? 0;

if ($id) {
    echo json_encode([
        "success" => true,
        "message" => "PDF simulado para reporte #$id",
        "url" => "#",
        "test" => true
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "ID no proporcionado"
    ]);
}
?>