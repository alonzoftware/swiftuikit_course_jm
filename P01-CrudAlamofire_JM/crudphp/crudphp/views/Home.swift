//
//  Home.swift
//  crudphp
//
//  Created by Jorge Maldonado Borbón on 07/02/22.
//

import SwiftUI

struct Home: View {
    
    @StateObject var crud = Crud()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(crud.posts, id:\.id){ item in
                    NavigationLink(destination: DetailView(crudItem: item)){
                        CeldaView(imagen: item.imagen, titulo: item.titulo, contenido: item.contenido)
                    }
                }
            }
            .navigationTitle("CRUD")
            .listStyle(.plain)
            .toolbar{
                NavigationLink(destination: PostView()){
                    Image(systemName: "plus")
                }
            }.onAppear{
                crud.getData()
            }
        }
    }
}

struct CeldaView: View {
    
    var imagen: String
    var titulo : String
    var contenido : String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(titulo).font(.largeTitle).bold()
            AsyncImage(url: URL(string: imagen)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.red
            }
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(radius: 10)
            Text(contenido).font(.body)
        }
    }
}


