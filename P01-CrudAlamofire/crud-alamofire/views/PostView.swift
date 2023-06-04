//
//  PostView.swift
//  crud-alamofire
//
//  Created by Rene Alonzo Choque Saire on 31/5/23.
//

import SwiftUI

//struct PostView: View {
//
//    @StateObject var crud = Crud()
//    var body: some View {
//        Button{
//            crud.save(title: "TitleDemoSwift", content: "ContentDemoSwift")
//        }label : {
//            Text("Save POST")
//        }
//    }
//}

struct PostView: View {
    
    @StateObject var crud = Crud()
    @State private var title = ""
    @State private var content = ""
    
    @State private var showImagePIcker = false
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    func loadImage(){
        guard let inputImage = inputImage else { return  }
        image = Image(uiImage: inputImage)
    }
    
    var body: some View {
        Form {
            TextField("Titulo", text: $title)
            TextEditor(text: $content)
            Button {
                if image == nil {
                    crud.save(title: title, content: content, id: "", edit: false)
                }else{
                    //crud.save2(titulo: titulo, contenido: contenido, imagen: inputImage!)
                }
                title = ""
                content = ""
                image = nil
            } label: {
                Text("Save Post")
            }
            .alert(crud.mensaje, isPresented: $crud.show) {
                Button("OK", role: .none) {}
            }
            image?
                .resizable()
                .scaledToFit()
        }.navigationTitle("Alta post")
            .toolbar{
                Button {
                    showImagePIcker = true
                } label: {
                    Image(systemName: "camera")
                }
            }
            .onChange(of: inputImage) { _ in
                loadImage()
            }.sheet(isPresented: $showImagePIcker) {
                //ImagePicker(image: $inputImage)
            }


    }
}

