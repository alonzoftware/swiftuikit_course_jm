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
            Text("Holafo the Bear")
                .toolbar{
                    NavigationLink(destination: PostView()){
                        Image(systemName: "plus")
                    }
                }.onAppear{
                    crud.getData()
                }.alert(crud.mensaje, isPresented: $crud.show) {
                    Button("OK", role: .none) {}
                }
        }
    }
}
