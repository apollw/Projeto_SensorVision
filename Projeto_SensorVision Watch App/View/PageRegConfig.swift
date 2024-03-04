//
//  PageRegConfig.swift
//  Projeto_SensorVision Watch App
//
//  Created by Fábrica de Inovacao on 29/02/24.
//

import SwiftUI

struct PageRegConfig: View {
    // MARK: - PROPERTY
    @State private var text1: String = ""
    @State private var text2: String = ""
    @State private var text3: String = ""
    @State var settings: [Setting]
    @State private var showAlert1: Bool = false
    @State private var showAlert2: Bool = false
    @State private var showAlert3: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    VStack{
                        TextField("Nome", text: $text1)
                            .font(.system(size: 15))
                            .cornerRadius(2)
                            .foregroundColor(.white)
                            .onTapGesture {showAlert1 = true}
                            .alert(isPresented: $showAlert1) {
                                Alert(
                                    title: Text("Informação"),
                                    message: Text("Defina um nome para sua Configuração de Local"),
                                    dismissButton: .default(Text("OK")) {
                                        showAlert1 = false;
                                    }
                                )
                            }
                        
                        TextField("Localizacao",text: $text2)
                            .font(.system(size: 15))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .onTapGesture {showAlert2 = true}
                            .alert(isPresented: $showAlert2) {
                                Alert(
                                    title: Text("Informação"),
                                    message: Text("Defina a Localização do novo Sensor"),
                                    dismissButton: .default(Text("OK")) {
                                        showAlert2 = false;
                                    }
                                )
                            }
                        
                        TextField("Descricao",text: $text3)
                            .font(.system(size: 15))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .onTapGesture {showAlert3 = true}
                            .alert(isPresented: $showAlert3) {
                                Alert(
                                    title: Text("Informação"),
                                    message: Text("Defina uma Descrição para seu novo Sensor"),
                                    dismissButton: .default(Text("OK")) {
                                        showAlert3 = false;
                                    }
                                )
                            }
                    }//: VStack

                    
                    // Criando uma instância de Setting fora do NavigationLink
                    let newSetting = Setting(
                        name: text1,
                        location: text2,
                        description: text3
                    )
                                        
//                    NavigationLink(destination: PageRegDisp(setting: newSetting)) {
//                        Image(systemName: "arrow.right.circle.fill")
//                            .font(.system(size: 55, weight: .semibold))
//                            .foregroundColor(.cyan)
//                    }
//                    .buttonStyle(PlainButtonStyle())
                    
//                    NavigationLink(destination: PageRegDisp(setting: newSetting)) {
//                        Image(systemName: "arrow.right.circle.fill")
//                            .font(.system(size: 55, weight: .semibold))
//                            .foregroundColor(.cyan)
//                    }
//                    .buttonStyle(PlainButtonStyle())
//                    .onAppear {
//                        // Salvar a nova configuração
//                        settings.append(newSetting)
//                    }
                    
                    // No NavigationLink, passe a lista settings em vez de apenas a newSetting
                    NavigationLink(destination: PageRegDisp(settings: settings)) {
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 55, weight: .semibold))
                            .foregroundColor(.cyan)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .onAppear {
                        // Salvar a nova configuração
                        settings.append(newSetting)
                    }
                    
                }//: HStack
                .navigationTitle("Novo Local")
            }//: VStack
        }//: NavigationStack
    }
}

//#Preview {
//    PageRegConfig()
//}

struct PageRegConfig_Previews: PreviewProvider {
    static var previews: some View {
        let sampleSettings: [Setting] = [
            Setting(name: "Setting 1",location: "Location 1", description: "Description 1"),
            Setting(name: "Setting 2", location: "Location 2", description: "Description 2"),
            Setting(name: "Setting 3", location: "Location 3", description: "Description 3")
        ]
        
        return PageRegConfig(settings: sampleSettings)
    }
}


