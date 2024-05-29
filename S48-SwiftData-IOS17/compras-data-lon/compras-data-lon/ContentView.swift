//
//  ContentView.swift
//  compras-data-lon
//
//  Created by Rene Alonzo Choque Saire on 29/5/24.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    
    //@Query private var items: [ListModel]
    //@Query (sort: \ListModel.titulo, order: .forward) private var items: [ListModel]
    @Query (filter: #Predicate<ListModel> { $0.completado == false }, sort: \ListModel.titulo, order: .forward) private var items: [ListModel]
    
    @Query (filter: #Predicate<ListModel> { $0.completado == true }, sort: \ListModel.titulo, order: .forward) private var itemsComplete: [ListModel]
    
    
    
    @Environment(\.modelContext) var context
    @State private var show = false
    var body: some View {
        NavigationStack{
            List{
                Section("Activos"){
                    ForEach(items){ item in
                        NavigationLink(value: item) {
                            CardView(item: item)
                                .swipeActions{
                                    Button (role: .destructive) {
                                        withAnimation{
                                            context.delete(item)
                                        }
                                    } label: {
                                        Image(systemName: "trash")
                                    }

                                }
                        }
                    }
                }
                Section("Completadas"){
                    ForEach(itemsComplete){ item in
                            CardComplete(item: item)
                            .swipeActions{
                                Button (role: .destructive) {
                                    withAnimation{
                                        context.delete(item)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                    }
                }
            }
            .navigationTitle("Mis Compras")
            .toolbar{
                ToolbarItem{
                    Button {
                        show.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .sheet(isPresented: $show, content: {
                NavigationStack{
                    AddView()
                }.presentationDetents([.medium])
            })
            .navigationDestination(for: ListModel.self) {
                ComprasView(itemList: $0)
            }
        }
    }
}

struct CardView: View {
    var item : ListModel
    var body: some View {
        HStack{
            Circle()
                .foregroundStyle(item.completado ? .green : .red )
                .frame(width: 10, height: 10)
            VStack(alignment: .leading){
                Text(item.titulo)
                    .bold()
                Text("\(item.fecha, format: Date.FormatStyle(date: .numeric, time: .shortened) )")
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
        }
    }
}

struct CardComplete: View {
    var item : ListModel
    var body: some View {
        HStack{
            Circle()
                .foregroundStyle(.green)
                .frame(width: 10, height: 10)
            VStack(alignment: .leading){
                Text(item.titulo)
                    .bold()
                Text("Resto: $\(item.prespuesto) Total Compra: $\(item.total.formatted())")
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
        }
    }
}


//#Preview {
//    ContentView()
//}
