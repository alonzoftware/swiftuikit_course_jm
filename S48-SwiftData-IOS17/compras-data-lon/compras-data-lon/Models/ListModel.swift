//
//  ListModel.swift
//  compras-data-lon
//
//  Created by Rene Alonzo Choque Saire on 29/5/24.
//

import Foundation
import SwiftData

@Model
final class ListModel {
    @Attribute(.unique) var id : String
    var titulo : String
    var fecha : Date
    var completado : Bool
    var presupuesto : String
    var total : Float
    
    @Relationship(deleteRule: .cascade)
    var relationArticulos: [ArticulosModel]
    
    init(id: String = UUID().uuidString, titulo: String = "" , fecha: Date = .now, completado: Bool = false, presupuesto: String = "", total: Float = 0) {
        self.id = id
        self.titulo = titulo
        self.fecha = fecha
        self.completado = completado
        self.presupuesto = presupuesto
        self.total = total
    }
}
