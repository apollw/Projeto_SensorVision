//
//  Setting.swift
//  Projeto_SensorVision Watch App
//
//  Created by Fábrica de Inovacao on 29/02/24.
//

import Foundation

struct Setting : Identifiable, Codable{
    let id: UUID
    let name: String
    let location: String
    let description: String
    var deviceList: [Device]
    
    init(id: UUID = UUID(), name: String, location: String, description: String, deviceList: [Device] = []) {
        self.id = id
        self.name = name
        self.location = location
        self.description = description
        self.deviceList = deviceList
    }
}
