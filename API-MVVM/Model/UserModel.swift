//
//  Usuario.swift
//  API-MVVM
//
//  Created by Filipi Romão on 30/06/25.
//

import Foundation


struct Position: Codable {
    var idPosition: String
    var namePosition: String
}

struct User: Codable, Identifiable{
    var idUser: String
    var userName: String
    var kit: Int
    var position: Position
    
    var id: String { idUser }
}
