//
//  HomeView.swift
//  crud-alamofire
//
//  Created by Rene Alonzo Choque Saire on 24/5/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            Text("Holafo the Bear")
                .toolbar{
                    NavigationLink(destination: PostView()){
                        Image(systemName: "plus")
                    }
                }
        }
    }
}
