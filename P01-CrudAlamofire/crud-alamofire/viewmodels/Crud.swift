//
//  Crud.swift
//  crud-alamofire
//
//  Created by Rene Alonzo Choque Saire on 31/5/23.
//

import Foundation
import Alamofire

class Crud : ObservableObject {
    @Published var mensaje = ""
    @Published var show = false
    
    func save (title : String , content : String){
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
                        print (ok)
                        guard let res = resultJSON.value(forKey: "msg") else {return}
                        print(res)
                    }catch let error as NSError{
                        print ("Error in JSON", error.localizedDescription)
                    }
                case .failure(let error):
                    print (error)
                }
                
            }
        }
    }
}
