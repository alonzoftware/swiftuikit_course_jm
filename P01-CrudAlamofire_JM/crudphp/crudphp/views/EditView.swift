//
//  EditView.swift
//  crudphp
//
//  Created by Jorge Maldonado Borbón on 07/02/22.
//

import SwiftUI

struct EditView: View {
    
    var crudItem : Posts
    @StateObject var crud = Crud()
    @State private var titulo = ""
    @State private var contenido = ""
    
    var body: some View {
        Form{
            TextField("Titulo", text: $titulo)
                .onAppear{
                    titulo = crudItem.titulo
                }
            TextEditor(text: $contenido)
                .onAppear{
                    contenido = crudItem.contenido
                }
            Button {
                crud.save(titulo: titulo, contenido: contenido, id: crudItem.id, editar: true)
            } label: {
                Text("Editar post")
            }

        }
    }
}


