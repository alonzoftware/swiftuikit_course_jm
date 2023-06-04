<?php 
include 'conexion.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

	$respuesta = array();
	
	$id = $_POST['id'];
	$nombre_archivo = $_POST['nombre_imagen'];
	unlink('imagenes/'.$nombre_archivo);

    $del = $con->query("DELETE FROM posts WHERE id = '$id' ");

    if ($del) {
    	$respuesta['respuesta'] = 'success';
    } else {
    	$respuesta['respuesta'] = 'fail';
    }

    echo json_encode($respuesta);
    
    $del->close();
    $con->close();

} else {
	echo 'error';
}


 ?>