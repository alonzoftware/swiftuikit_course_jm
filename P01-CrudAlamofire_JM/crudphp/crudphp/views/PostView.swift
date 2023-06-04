//
//  PostView.swift
//  crudphp
//
//  Created by Jorge Maldonado Borbón on 07/02/22.
//

import SwiftUI

struct PostView: View {
    
    @StateObject var crud = Crud()
    @State private var titulo = ""
    @State private var contenido = ""
    
    @State private var showImagePIcker = false
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    func loadImage(){
        guard let inputImage = inputImage else { return  }
        image = Image(uiImage: inputImage)
    }
    
    var body: some View {
        Form {
            TextField("Titulo", text: $titulo)
            TextEditor(text: $contenido)
            Button {
                if image == nil {
                    crud.save(titulo: titulo, contenido: contenido, id: "", editar: false)
                }else{
                    crud.save2(titulo: titulo, contenido: contenido, imagen: inputImage!)
                }
                titulo = ""
                contenido = ""
                image = nil
            } label: {
                Text("Guardar post")
            }
            .alert(crud.mensaje, isPresented: $crud.show) {
                Button("Aceptar", role: .none) {}
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
                ImagePicker(image: $inputImage)
            }


    }
}


