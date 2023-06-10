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
    //    @Published var posts : [[String : AnyObject]] = []
    @Published var posts : [Post] = []
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
        
        guard let url = URL(string: "https://alonzochoque.net/enews/api/swiftcrud/save.php") else { return }
        
        //        guard let imgData = imagen.pngData() else { return }
        guard let imgData = imagen.jpegData(compressionQuality: 1.0) else { return }
        let nombreImagen = UUID().uuidString
        
        DispatchQueue.main.async {
            AF.upload(multipartFormData: { MultipartFormData in
                
                MultipartFormData.append(imgData, withName: "image", fileName: "\(nombreImagen).png", mimeType: "image/png")
                
                for (key, val) in params {
                    MultipartFormData.append((val as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                
            }, to: url, method: .post).uploadProgress { Progress in
                print(Progress.fractionCompleted * 100)
            }.responseData { response in
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
    
    
    func getData(){
        AF.request("https://alonzochoque.net/enews/api/swiftcrud/select.php")
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : AnyObject]{
                            
                            if let total = json["total"] as? Int{
                                if total > 0 {
                                    if let postsReq = json["posts"] as? [[String : AnyObject]]{
                                        for index in 0...postsReq.count - 1 {
                                            let postObj = postsReq[index]
                                            print(postObj["content"]!)
                                            self.posts.append(
                                                Post(id: postObj["id"] as! String,
                                                     title: postObj["title"] as! String,
                                                     content: postObj["content"] as! String,
                                                     image_url: postObj["image_url"] as! String,
                                                     image_name: postObj["image_name"] as! String
                                                )
                                            );
                                        }
                                    }
                                }
                            }
                            
                            
                        }
                        
                        
                        //let resultJSON = json as! NSDictionary
                        //                        guard let postsDecoded  = resultJSON.value(forKey: "posts") else {return}
                        //print(type(of: postsDecoded))
                        //                        for object in postsDecoded {
                        // do something with object
                        //                            print(object)
                        //                        }
                        //                        let jsonDecode = try JSONDecoder().decode([Post].self, from: postsDecoded as! Data)
                        //                        DispatchQueue.main.async {
                        //                            print(jsonDecode)
                        //                            //self.posts = json
                        //                        }
                    }catch let error as NSError {
                        print ("Error in JSON", error.localizedDescription)
                        self.mensaje = "Problem to show POSTs :: JSON"
                        self.show = true
                    }
                case .failure(let error):
                    print (error)
                    self.mensaje = "Problem to show POSTs :: HTTP Request"
                    self.show = true
                }
            }
    }
    
    
    func delete(id: String, nombre_imagen: String){
        
        let params : Parameters = [
            "id": id,
            "nombre_imagen": nombre_imagen
        ]
        
        guard let url = URL(string: "https://alonzochoque.net/enews/api/swiftcrud/delete.php") else { return }
        
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
