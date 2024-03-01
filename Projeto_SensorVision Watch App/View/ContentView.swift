//
//  ContentView.swift
//  Projeto_SensorVision Watch App
//
//  Created by Fábrica de Inovacao on 29/02/24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Property
    @State private var settings: [Setting] = [Setting]()
    
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
    
    // MARK: - Body
    var body: some View {
        NavigationStack{
            VStack {
                List {
                    ForEach(0..<settings.count, id: \.self) { i in
                        HStack {
                            Capsule()
                                .frame(width: 8)
                                .foregroundColor(.accentColor)
                            Text(settings[i].name)
                                .lineLimit(1)
                                .padding(.leading, 5)
                        }
                    }
                }//: List
                
                HStack{
                    Button {
                        // Ação ao pressionar o botão
                    } label: {
                        Image(systemName: "arrow.down.circle.fill")
                            .font(.system(size: 55, weight: .semibold))
                            .foregroundColor(.accentColor)
                    }//: Button
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    
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
