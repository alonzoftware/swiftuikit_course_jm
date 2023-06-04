<?php 
include 'conexion.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

	$respuesta = array();
	
	$titulo = $_POST['titulo'];
	$contenido = $_POST['contenido'];
	$id = $_POST['id'];

    $up = $con ->query("UPDATE posts SET titulo='$titulo', contenido = '$contenido' WHERE id = '$id' ");

    if ($up) {
    	$respuesta['respuesta'] = 'success';
    } else {
    	$respuesta['respuesta'] = 'fail';
    }

    echo json_encode($respuesta);
    
    $up->close();
    $con->close();

} else {
	echo 'error';
}


 ?>