//
//  Device.swift
//  Projeto_SensorVision Watch App
//
//  Created by Fábrica de Inovacao on 29/02/24.
//

import Foundation

//struct Device: Identifiable, Codable{
//    let id  : UUID
//    let text: String
//}

class Device : Identifiable, Codable{
    var id: UUID
    var name: String
    var nickname: String?
    var macAddress: String
    var isAnchor: Bool
    
    init(id: UUID, name: String, nickname: String? = nil, macAddress: String,  isAnchor: Bool = false) {
        self.id = id
        self.name = name
        self.nickname = nickname
        self.macAddress = macAddress
        self.isAnchor = isAnchor
    }
}
