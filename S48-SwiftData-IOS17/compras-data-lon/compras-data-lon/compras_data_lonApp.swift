//
//  compras_data_lonApp.swift
//  compras-data-lon
//
//  Created by Rene Alonzo Choque Saire on 29/5/24.
//

import SwiftUI
import SwiftData
@main
struct ComprasDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [ListModel.self, ArticulosModel.self])
        }
    }
}
