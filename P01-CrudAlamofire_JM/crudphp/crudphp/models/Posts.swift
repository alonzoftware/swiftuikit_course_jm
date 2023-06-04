//
//  Posts.swift
//  crudphp
//
//  Created by Jorge Maldonado Borbón on 07/02/22.
//

import Foundation

struct Posts: Codable {
    let id : String
    let titulo : String
    let contenido : String
    let imagen : String
    let nombre_imagen : String
}
