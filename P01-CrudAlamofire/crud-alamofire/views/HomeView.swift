//
//  HomeView.swift
//  crud-alamofire
//
//  Created by Rene Alonzo Choque Saire on 24/5/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var crud = Crud()
    var body: some View {
        NavigationView{
//                        Text("Holafo the Bear")
//                            .toolbar{
//                                NavigationLink(destination: PostView()){
//                                    Image(systemName: "plus")
//                                }
//                            }.onAppear{
//                                crud.getData()
//                            }.alert(crud.mensaje, isPresented: $crud.show) {
//                                Button("OK", role: .none) {}
//                            }
            
            List{
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
//                        ForEach(0..<self.crud.posts.count, id: \.self){ index in
                        ForEach(self.crud.posts, id: \.id){ item in
                            CeldaView(imagen: item.image_url, titulo: item.title, contenido: item.content)
//                            NavigationLink(destination: DetailView(crudItem: item)){
//                                CeldaView(imagen: item.imagen, titulo: item.titulo, contenido: item.contenido)
//                            }
                        }
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
            Text(titulo)
                .font(.largeTitle).bold()
                .padding()
            HStack{
                Spacer()
                AsyncImage(url: URL(string: imagen)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100, alignment: .center)
                } placeholder: {
                    Color.red
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .shadow(radius: 10)
                
                Spacer()
            }.padding()
            
            Text(contenido).font(.body)
                .padding()
        }
//        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(red: 130/255, green: 130/255, blue: 130/255, opacity: 0.2), lineWidth: 5))
        .background(Color.gray)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 2))
        .padding([.top, .horizontal])
    }
}
//EXTENSION FOR PADDING LEFT AND RIGHT
enum NoFlipEdge {
    case left, right
}

struct NoFlipPadding: ViewModifier {
    let edge: NoFlipEdge
    let length: CGFloat?
    @Environment(\.layoutDirection) var layoutDirection
    
    private var computedEdge: Edge.Set {
        if layoutDirection == .rightToLeft {
            return edge == .left ? .trailing : .leading
        } else {
            return edge == .left ? .leading : .trailing
        }
    }
    
    func body(content: Content) -> some View {
        content
            .padding(computedEdge, length)
    }
}

extension View {
    func padding(_ edge: NoFlipEdge, _ length: CGFloat? = nil) -> some View {
        self.modifier(NoFlipPadding(edge: edge, length: length))
    }
}
