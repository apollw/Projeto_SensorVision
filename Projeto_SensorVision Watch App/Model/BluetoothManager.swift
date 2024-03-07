//
//  BluetoothManager.swift
//  Projeto_SensorVision Watch App
//
//  Created by Fábrica de Inovacao on 07/03/24.
//

import Foundation
import UIKit
import CoreBluetooth

class BluetoothManager: NSObject, CBCentralManagerDelegate, ObservableObject{
    var centralManager: CBCentralManager!
    var peripheralName: String?
    @Published var bluetoothMessage = ""
    @Published var detectedDevices = [CBPeripheral]()

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScanning() {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func getDetectedDevices() -> [CBPeripheral] {
        return detectedDevices
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            // Inicia o escaneamento quando o Bluetooth está ligado
            startScanning()
        } else {
            // Lida com outros estados do Bluetooth
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // Extrai o nome do dispositivo Bluetooth e atualiza a mensagem
        if let name = peripheral.name {
            bluetoothMessage = "Dispositivo Bluetooth encontrado: \(name)"
            print("Nome do dispositivo Bluetooth encontrado: \(name)")
        }
    }
    
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        // Conecta-se ao dispositivo quando encontrado
//        self.peripheral = peripheral
//        self.peripheral?.delegate = self
//        centralManager.connect(peripheral, options: nil)
//    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // Uma vez conectado, inicia a descoberta de serviços
        peripheral.discoverServices(nil)
    }
    
    //Novas funcs

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                // Descobertas de Características Específicas
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                // Verifica se a característica é a que contém os dados do sensor de proximidade
                if characteristic.uuid == CBUUID(string: "UUID_DA_CARACTERISTICA") {
                    // Assina para notificações quando os dados são atualizados
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        // Processar os dados recebidos do sensor de proximidade
        if let value = characteristic.value {
            // Decodificando o valor recebido
            let distance = String(data: value, encoding: .utf8) // Exemplo de decodificação de string UTF-8
            print("Distância do sensor de proximidade: \(distance)")
        }
    }
    
}

// Uso:
let bluetoothManager = BluetoothManager()


