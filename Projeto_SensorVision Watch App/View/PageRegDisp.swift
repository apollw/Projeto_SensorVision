//
//  PageRegDisp.swift
//  Projeto_SensorVision Watch App
//
//  Created by Fábrica de Inovacao on 29/02/24.
//

import SwiftUI

struct PageRegDisp: View {
    
    //MARK: - PROPERTY
//    @State private var text: String = ""
//    //@State private var devices: [Device] = [Device]()
//    @State private var setting: Setting
//    @State private var newSettingList: [Setting] = [] // Lista para armazenar novas configurações
    
    @State private var settings: [Setting]
    @State private var newSetting: Setting? // Opcional para armazenar a nova configuração
    @State private var showAlert1: Bool = false
    @State private var value: Int = 0 // Inicializa a variável value

        
    init(settings: [Setting], newSetting: Setting? = nil) {
        self._settings = State(initialValue: settings)
        self._newSetting = State(initialValue: newSetting)
    }
    
//    init(setting: Setting) {
//        self._setting = State(initialValue: setting)
//        //self._devices = State(initialValue: setting.deviceList)
//    }
    
//    init(settings: [Setting]) {
//        self.settings = settings
//    }
    
    init(settings: [Setting]) {
        _settings = State(initialValue: settings) // Inicialize settings com o valor recebido como parâmetro
    }
    
    //MARK: - FUNCTION
                
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
        
    // Seu botão "Adicionar Sensor" para adicionar um novo dispositivo à lista
//    func addDevice(_value: Int) {
//        let newDevice = Device(id: UUID(), name: "Novo Sensor", nickname: "Apelido", macAddress: "Endereço MAC")
//        //setting.deviceList.append(newDevice)
//        
//        let myString = String(value)
//        
//        newDevice.name = newDevice.name + myString
//        settings[0].deviceList.append(newDevice)
//    }
    
    func addDevice(_ value: Int) {
        let newDevice = Device(id: UUID(), name: "Novo Sensor", nickname: "Apelido", macAddress: "Endereço MAC")
        
        // Modifica o nome do dispositivo para incluir o valor passado como parâmetro
        newDevice.name += " \(value)"
        settings[0].deviceList.append(newDevice)
    }
    
    // Adiciona uma nova configuração à lista
    func addNewSetting() {
        //newSettingList.append(setting)
    }
    
    // Função para salvar a lista completa de configurações
//    func saveSettings() {
//        do {
//            let data = try JSONEncoder().encode(newSettingList)
//            let url = getDocumentDirectory().appendingPathComponent("settings")
//            try data.write(to: url)
//        } catch {
//            print("Falha ao salvar as configurações. Tente novamente.")
//        }
//    }
    
    func delete(offsets: IndexSet){
        withAnimation{
            settings[0].deviceList.remove(atOffsets: offsets)
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                if settings[0].deviceList.count >= 1{
                    List{
                        ForEach(0..<settings[0].deviceList.count,id: \.self){ i in
                            HStack{
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                Text(settings[0].deviceList[i].name)
                                    .lineLimit(1)
                                    .padding(.leading,5)
                            }//: HSTACK
                        }//: ForEach
                        .onDelete(perform: delete)
                    }//: List
                } else {
                    Spacer()
                    Image(systemName: "globe")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.accentColor)
                        .opacity(0.25)
                        .padding(10)
                    Spacer()
                }
                
                HStack(alignment: .center, spacing: 3) {
                    Text("Adicionar Sensor")
                        .font(.caption) // Define o tamanho da fonte para título
                        .foregroundColor(.blue) // Define a cor do texto para azul
                    
                    Button{
                        value += 1 // Incrementa o valor ao pressionar o botão
                        addDevice(value)
                    }label:{
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42,weight: .semibold))
                    }
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
                    
                }//: HSTACK
                
                //Salvar Setting
                Button{
                    addNewSetting()
                    showAlert1 = true
                    //saveSettings()
                }label:{
                    Text("Salvar")
                        .font(.system(size: 15,weight: .semibold))
                }
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.white)
                .alert(isPresented: $showAlert1) {
                    Alert(
                        title: Text("Informação"),
                        message: Text("A nova configuracao é registrada com seus respectivos sensores"),
                        dismissButton: .default(Text("OK")) {
                            showAlert1 = false;
                        }
                    )
                }
                
                .navigationTitle(settings[0].name)
            }//: VStack
        }//: NavigationStack
    }
}

//#Preview {
//    PageRegDisp()
//}

//struct PageRegDisp_Previews: PreviewProvider {
//   static var previews: some View {
//        let setting = Setting(id: UUID(), name: "Nome da Configuração", location: "Localização", description: "Descrição", deviceList: [])
//    return PageRegDisp(setting: setting)
//    }
//}//: Previews

struct PageRegDisp_Previews: PreviewProvider {
    static var previews: some View {
        let sampleSettings: [Setting] = [
            Setting(name: "Local Novo", location: "Location 1", description: "Description 1"),
            Setting(name: "Setting 2", location: "Location 2", description: "Description 2"),
            Setting(name: "Setting 3", location: "Location 3", description: "Description 3")
        ]
        
        return PageRegDisp(settings: sampleSettings)
    }
}


