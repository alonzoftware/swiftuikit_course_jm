//
//  Crud.swift
//  crudphp
//
//  Created by Jorge Maldonado Borbón on 07/02/22.
//

import Foundation
import Alamofire
import UIKit

class Crud : ObservableObject {
    
    @Published var mensaje = ""
    @Published var show = false
    @Published var posts = [Posts]()
    var urlString = ""
    
    func save(titulo: String, contenido: String, id: String, editar: Bool){
        
        let parametros : Parameters = [
            "titulo": titulo,
            "contenido": contenido,
            "id":id
        ]
        
        if editar {
            urlString = "http://localhost/proyecto/crud/edit.php"
        }else{
            urlString = "http://localhost/proyecto/crud/save.php"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.main.async {
            AF.request(url, method: .post, parameters: parametros).responseData { response in
                switch response.result {
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data)
                        let resultadojson = json as! NSDictionary
                        guard let res = resultadojson.value(forKey: "respuesta") else { return }
                        if res as! String == "success"{
                            self.mensaje = "Post guardado con exito"
                            self.show = true
                        }else{
                            self.mensaje = "El post no se pudo guardar"
                            self.show = true
                        }
                    }catch let error as NSError {
                        print("Error en el json", error.localizedDescription)
                        self.mensaje = "El post no se pudo guardar"
                        self.show = true
                    }
                case .failure(let error):
                    print(error)
                    self.mensaje = "El post no se pudo guardar"
                    self.show = true
                }
            }
        }
        
    }
    
    
    func save2(titulo: String, contenido: String, imagen: UIImage){
        let parametros : Parameters = [
            "titulo": titulo,
            "contenido": contenido
        ]
        
        guard let url = URL(string: "http://localhost/proyecto/crud/save.php") else { return }
        
        guard let imgData = imagen.jpegData(compressionQuality: 1.0) else { return }
        let nombreImagen = UUID().uuidString
        
        DispatchQueue.main.async {
            AF.upload(multipartFormData: { MultipartFormData in
                
                MultipartFormData.append(imgData, withName: "imagen", fileName: "\(nombreImagen).png", mimeType: "image/png")
                
                for (key, val) in parametros {
                    MultipartFormData.append((val as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                
            }, to: url, method: .post).uploadProgress { Progress in
                print(Progress.fractionCompleted * 100)
            }.response { response in
                self.mensaje = "Post guardado con exito"
                self.show = true
            }
        }
        
    }
    
    
    func getData(){
        AF.request("http://localhost/proyecto/crud/select.php")
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do{
                        let json = try JSONDecoder().decode([Posts].self, from: data)
                        DispatchQueue.main.async {
                            print(json)
                            self.posts = json
                        }
                    }catch let error as NSError {
                        print("error al mostrar json", error.localizedDescription)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    func delete(id: String, nombre_imagen: String){
        
        let parametros : Parameters = [
            "id": id,
            "nombre_imagen": nombre_imagen
        ]
        
        guard let url = URL(string: "http://localhost/proyecto/crud/delete.php") else { return }
        
        DispatchQueue.main.async {
            AF.request(url, method: .post, parameters: parametros).responseData { response in
                switch response.result {
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data)
                        let resultadojson = json as! NSDictionary
                        guard let res = resultadojson.value(forKey: "respuesta") else { return }
                        if res as! String == "success"{
                            self.mensaje = "Post eliminado con exito"
                            self.show = true
                        }else{
                            self.mensaje = "El post no se pudo eliminar"
                            self.show = true
                        }
                    }catch let error as NSError {
                        print("Error en el json", error.localizedDescription)
                        self.mensaje = "El post no se pudo eliminar"
                        self.show = true
                    }
                case .failure(let error):
                    print(error)
                    self.mensaje = "El post no se pudo eliminar"
                    self.show = true
                }
            }
        }
        
    }
    
    
}
