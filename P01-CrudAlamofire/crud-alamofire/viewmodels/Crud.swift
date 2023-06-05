//
//  Crud.swift
//  crud-alamofire
//
//  Created by Rene Alonzo Choque Saire on 31/5/23.
//


import Foundation
import SwiftUI
import Alamofire


class Crud : ObservableObject {
    @Published var mensaje = ""
    @Published var show = false
    @Published var posts = [Posts]()
    var urlString = ""
    
    func save (title : String , content : String , id: String, edit: Bool){
        let params : Parameters = [
            "title" : title,
            "content" : content
        ]
        guard let url = URL(string : "https://alonzochoque.net/enews/api/swiftcrud/save.php") else {return}
        
        DispatchQueue.main.async{
            AF.request(url, method: .post,parameters: params).responseData{response in
                switch response.result {
                case .success(let data):
                    do {
                        let json = try JSONSerialization.jsonObject(with: data)
                        let resultJSON = json as! NSDictionary
                        guard let ok  = resultJSON.value(forKey: "ok")else {return}
                        guard let res = resultJSON.value(forKey: "msg") else {return}
                        if ok as! Bool == true {
                            self.mensaje = res as! String
                            self.show = true
                        }else{
                            self.mensaje = res as! String
                            self.show = true
                        }
                        
                    }catch let error as NSError{
                        print ("Error in JSON", error.localizedDescription)
                        self.mensaje = "Problem to save POST"
                        self.show = true
                    }
                case .failure(let error):
                    print (error)
                    self.mensaje = "Problem to save POST"
                    self.show = true
                }
                
            }
        }
    }
    
    func save2(title: String, content: String, imagen: UIImage){
        let params : Parameters = [
            "title": title,
            "content": content
        ]
        
        guard let url = URL(string: "http://localhost/proyecto/crud/save.php") else { return }
        
        guard let imgData = imagen.jpegData(compressionQuality: 1.0) else { return }
        let nombreImagen = UUID().uuidString
        
        DispatchQueue.main.async {
            AF.upload(multipartFormData: { MultipartFormData in
                
                MultipartFormData.append(imgData, withName: "imagen", fileName: "\(nombreImagen).png", mimeType: "image/png")
                
                for (key, val) in params {
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
        
        let params : Parameters = [
            "id": id,
            "nombre_imagen": nombre_imagen
        ]
        
        guard let url = URL(string: "http://localhost/proyecto/crud/delete.php") else { return }
        
        DispatchQueue.main.async {
            AF.request(url, method: .post, parameters: params).responseData { response in
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
