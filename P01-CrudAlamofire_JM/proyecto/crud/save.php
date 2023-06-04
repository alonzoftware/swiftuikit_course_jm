<?php 
include 'conexion.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

	$respuesta = array();
	
	$titulo = $_POST['titulo'];
	$contenido = $_POST['contenido'];

	if (isset($_FILES['imagen']['tmp_name'])) {
		$tmp_name = $_FILES['imagen']['tmp_name'];
		$nombre_imagen = $_FILES['imagen']['name'];
		$carpeta = 'imagenes/'.$nombre_imagen;
		move_uploaded_file($tmp_name, $carpeta);
		$ruta = 'http://localhost/proyecto/crud/'.$carpeta;
	} else {
		$ruta = 'http://localhost/proyecto/crud/imagenes/defecto.png';
	    $nombre_imagen = '';
	}
	

    $ins = $con ->query("INSERT INTO posts VALUES(DEFAULT,'$titulo','$contenido','$ruta','$nombre_imagen') ");

    if ($ins) {
    	$respuesta['respuesta'] = 'success';
    } else {
    	$respuesta['respuesta'] = 'fail';
    }

    echo json_encode($respuesta);
    
    $ins->close();
    $con->close();

} else {
	echo 'error';
}


 ?>