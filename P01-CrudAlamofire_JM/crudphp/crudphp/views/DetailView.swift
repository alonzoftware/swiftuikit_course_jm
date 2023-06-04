//
//  DetailView.swift
//  crudphp
//
//  Created by Jorge Maldonado Borbón on 07/02/22.
//

import SwiftUI

struct DetailView: View {
    
    var crudItem : Posts
    @StateObject var crud = Crud()
    @State private var show = false
    
    var body: some View {
        VStack(alignment: .center){
            CeldaView(imagen: crudItem.imagen, titulo: "", contenido: crudItem.contenido)
            HStack(alignment: .center){
                Button {
                    show.toggle()
                } label: {
                    Text("Editar")
                }.buttonStyle(.bordered)
                    .sheet(isPresented: $show) {
                        EditView(crudItem: crudItem)
                    }

                
                Button {
                    crud.delete(id: crudItem.id, nombre_imagen: crudItem.nombre_imagen)
                } label: {
                    Text("Eliminar")
                }.buttonStyle(.bordered)
                    .tint(.red)

            }
            Spacer()
        }.padding(.all)
            .navigationTitle(crudItem.titulo)
            .alert(crud.mensaje, isPresented: $crud.show) {
                Button("Aceptar", role: .none) {}
            }
    }
}

