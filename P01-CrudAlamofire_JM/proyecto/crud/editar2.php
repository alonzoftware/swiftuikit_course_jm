<?php 
include 'conexion.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

	$respuesta = array();
	
	$titulo = $_POST['titulo'];
	$contenido = $_POST['contenido'];
	$id = $_POST['id'];
	$nombre_imagen_original = $_POST['nombre_imagen'];

	if (isset($_FILES['imagen']['tmp_name'])) {
		$tmp_name = $_FILES['imagen']['tmp_name'];
		$nombre_imagen = $_FILES['imagen']['name'];
		$carpeta = 'imagenes/'.$nombre_imagen;
		move_uploaded_file($tmp_name, $carpeta);
		$ruta = 'http://localhost/proyecto/crud/'.$carpeta;

		unlink('imagenes/'.$nombre_imagen_original);
		$up = $con ->query("UPDATE posts SET titulo='$titulo', contenido = '$contenido', imagen = '$ruta', nombre_imagen = '$nombre_imagen' WHERE id = '$id' ");
	} else {
		$up = $con ->query("UPDATE posts SET titulo='$titulo', contenido = '$contenido' WHERE id = '$id' ");
	}
	

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