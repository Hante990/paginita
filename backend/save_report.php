<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Manejar preflight
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

// Para pruebas, simular éxito sin base de datos
$input = json_decode(file_get_contents('php://input'), true);

// Si no hay datos POST, mostrar mensaje de prueba
if (!$input && empty($_POST)) {
    echo json_encode([
        "success" => false,
        "message" => "Servidor funcionando. Envía datos POST para guardar reportes.",
        "test" => true
    ]);
    exit();
}

// Si hay datos, procesarlos (modo simulación)
if ($input) {
    // Validar campos requeridos
    $required = ['color', 'description', 'location_lat', 'location_lng'];
    $missing = [];
    
    foreach ($required as $field) {
        if (!isset($input[$field]) || empty($input[$field])) {
            $missing[] = $field;
        }
    }
    
    if (!empty($missing)) {
        echo json_encode([
            "success" => false,
            "message" => "Campos faltantes: " . implode(', ', $missing)
        ]);
        exit();
    }
    
    // Simular guardado exitoso
    $id = rand(1000, 9999);
    
    echo json_encode([
        "success" => true,
        "id" => $id,
        "data" => [
            'id' => $id,
            'color' => $input['color'],
            'description' => $input['description'],
            'address' => $input['address'] ?? 'Ubicación en mapa',
            'lat' => $input['location_lat'],
            'lng' => $input['location_lng'],
            'wordCount' => str_word_count($input['description']),
            'created_at' => date('Y-m-d H:i:s')
        ],
        "message" => "Reporte guardado exitosamente (modo simulación)"
    ]);
    exit();
}

// Si llega aquí, hay un error
echo json_encode([
    "success" => false,
    "message" => "Error desconocido"
]);
?>