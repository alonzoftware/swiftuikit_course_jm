<?php 
include 'conexion.php';

$resultado = array();
$temporal = array();

$sel = $con->query("SELECT * FROM posts ORDER BY id DESC ");

while($f = $sel -> fetch_assoc() ){
	$temporal = $f;
	array_push($resultado, $temporal);
}

echo json_encode($resultado);

$sel->close();
$con->close();

 ?>