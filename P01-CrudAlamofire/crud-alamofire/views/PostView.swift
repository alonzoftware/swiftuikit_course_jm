//
//  PostView.swift
//  crud-alamofire
//
//  Created by Rene Alonzo Choque Saire on 31/5/23.
//

import SwiftUI

struct PostView: View {
    
    @StateObject var crud = Crud()
    var body: some View {
        Button{
            crud.save(title: "TitleDemoSwift", content: "ContentDemoSwift")
        }label : {
            Text("Save POST")
        }
    }
}
