//
//  ComprasView.swift
//  compras-data-lon
//
//  Created by Rene Alonzo Choque Saire on 29/5/24.
//

import SwiftUI
import SwiftData

struct ComprasView: View {
    
    @Bindable var itemList : ListModel
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var articulo = ""
    @State private var precio = ""
    @State private var cantidad = 1
    
    @FocusState private var isFocus : Bool
    @Query private var articulos : [ArticulosModel]
    /*
    init(itemList: ListModel){
        self.itemList = itemList
        _articulos = Query(filter: #Predicate<ArticulosModel> { $0.idList.contains(itemList.id) } )
    }
    */
    
    var precioFinal : Float {
        articulos.filter { $0.idList.contains(itemList.id) }.reduce(0.0){ $0 + $1.precio }
    }
    
    var body: some View {
        VStack{
            VStack{
                TextField("Articulo", text: $articulo)
                    .textFieldStyle(.roundedBorder)
                    .focused($isFocus)
                HStack{
                    TextField("Precio", text: $precio)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                    Spacer()
                    ContadorView(contador: $cantidad)
                }
                HStack{
                    Button {
                        let precioTotal = (Float(precio) ?? 0) * Float(cantidad)
                        let newArticulo = ArticulosModel(articulo: articulo, precio: precioTotal, idList: itemList.id)
                        itemList.relationArticulos.append(newArticulo)
                        isFocus = true
                        articulo = ""
                        precio = ""
                        cantidad = 1
                        
                        let updatePresupuesto = (Float(itemList.presupuesto) ?? 0 ) - precioTotal
                        
                        itemList.presupuesto = String(updatePresupuesto)
                        
                    } label: {
                        Text("Agregar")
                    }
                    Spacer()
                    Text("Presupuesto: $\(itemList.presupuesto)").bold()

                }
                
            }.padding(.all)
            
            List{
                Section("Carrito"){
                    ForEach(articulos.filter { $0.idList.contains(itemList.id) } ){ item in
                        HStack{
                            Text(item.articulo)
                            Spacer()
                            Text("$\(item.precio.formatted())")
                                .swipeActions {
                                    Button(role: .destructive) {
                                        let sumaPre = (Float(itemList.prespuesto) ?? 0) + item.precio
                                        itemList.prespuesto = String(sumaPre)
                                        context.delete(item)
                                    } label: {
                                        Image(systemName: "trash")
                                    }

                                }
                        }
                    }
                    HStack{
                        Text("Total:").bold()
                        Spacer()
                        Text("$\(precioFinal.formatted())").bold()
                    }
                }
            }
            
        }.navigationTitle(itemList.titulo)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem{
                    Button {
                        itemList.completado = true
                        itemList.total = precioFinal
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                    }

                }
            }
    }
}


struct ContadorView: View {
    @Binding var contador : Int
    var body: some View {
        HStack{
            Button {
                contador -= 1
                if contador <= 1{
                    contador = 1
                }
            } label: {
                Image(systemName: "minus")
            }
            Text("\(contador)")
            Button {
                contador += 1
            } label: {
                Image(systemName: "plus")
            }

        }
    }
}


//#Preview {
//    ComprasView()
//}
