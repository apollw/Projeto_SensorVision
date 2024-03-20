//
//  ContentView.swift
//  Projeto_SensorVision Watch App
//
//  Created by Fábrica de Inovacao on 29/02/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    // MARK: - Property
    @State private var settings: [Setting] = [Setting]()
    @State private var showAlert = false
    @State private var showAlert2 = false

    
    @State private var counter  = 0
    @State private var mensagem = ""
    @State private var info     = ""
    
    @State private var downloadButton = "Aqui você poderá baixar configurações de diferentes locais"
    @State private var infoButton     = "Informação"
        
    // MARK: - Function
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
                let url = getDocumentDirectory().appendingPathComponent("settings")
                let data = try Data(contentsOf: url)
                 settings = try JSONDecoder().decode([Setting].self, from: data)
                
            } catch {
                print("Erro ao carregar os dados: \(error.localizedDescription)")
            }
        }
    }
    
    //Feedback Vocalizado
    func speakMessage(_ message: String) {
        // Configuração e reprodução da mensagem de voz
            let utterance = AVSpeechUtterance(string: message)
            utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR") // Idioma Português do Brasil
            let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack{
            VStack {
                
                Spacer()
                
                // Imagem para Teste
                Image(.sensor)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 65, height: 65)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.blue), lineWidth: 3)
                    )
                .onTapGesture {
                    // Incrementa o contador ao tocar na imagem
                    self.counter += 1
                    
                    if(self.counter==1){
                        showAlert = true
                        info = "Tour Geral"
                        mensagem = "Simulação de Funcionamento do Aplicativo. Pressione o botão para mais informações."
                    }
                    
                    if(self.counter==2){
                        showAlert = true
                        info = "Alertas de perigo"
                        mensagem = "À medida que o usuário se aproxima do perigo, o sistema lançará alertas ao usuário."
                    }
                    
                    if(self.counter==3){
                        showAlert = true
                        info = "Feedback Tátil e Sonoro"
                        mensagem = "Esses alertas poderão vir em forma de vibração ou em forma de mensagem falada."
                    }
                    
                    if(self.counter==4){
                        showAlert = true
                        info = "Cálculo da Distância"
                        mensagem = "O oposto é real. Quanto mais distante do objeto perigoso, menor será a intensidade da vibração."
                    }
                    
                    if(self.counter==5){
                        showAlert = true
                        info = "SensorVision"
                        mensagem = "Projeto desenvolvido para o projeto de extensão IFMA-SOFTEX, pelos alunos Leanderson Silva (8º Período de Sistemas de Inf.) e Felipe Moura (3º Período de Sistemas de Inf.), com a supervisão do professor Mauro Lopes, do DECOM do IFMA."
                        self.counter=0
                    }
                }
                // Modificadora para feedback tátil no toque da imagem
                .sensoryFeedback(.increase, trigger: counter)
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(info),
                        message: Text(mensagem),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                Spacer()
                
                HStack{
                    
                    Button {
                        // Ação ao pressionar o botão
                        showAlert2 = true
                    } label: {
                        Image(systemName: "arrow.down.circle.fill")
                            .font(.system(size: 55, weight: .semibold))
                            .foregroundColor(.accentColor)
                    }//: Button
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .alert(isPresented: $showAlert2) {
                        Alert(
                            title: Text(infoButton),
                            message: Text(downloadButton),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
//                    NavigationLink(destination: PageRegConfig()) {
//                        Image(systemName: "plus.circle")
//                            .font(.system(size: 55, weight: .semibold))
//                            .foregroundColor(.accentColor)
//                    }//: NavigationLink
//                    .buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(destination: PageRegConfig(settings: settings)) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 55, weight: .semibold))
                            .foregroundColor(.accentColor)
                    }//: NavigationLink
                    .buttonStyle(PlainButtonStyle())
                    
                    
                }//: HStack
                
                .navigationTitle("SensorVision")
//                .onAppear(perform: {
//                    load()})
            }//: VStack
        }//: NavigationStack
    }//: View
    //Commit final
}

#Preview {
    ContentView()
}
    

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
