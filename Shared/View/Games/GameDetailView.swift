//
//  TESTGameDetailView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 22/08/2020.
//

import SwiftUI

struct GameDetailView: View {
    
    //È un array poichè RichiesteByGameID è un typealias di [RichiesteByGameIDElement]
    @State private var richiestePS4 = RichiesteByGameID()
    @State private var richiesteXBOX = RichiesteByGameID()
    @State private var richiestePC = RichiesteByGameID()
    
    @Binding var selected : Game
    @Binding var show : Bool
    var animation : Namespace.ID
    
    @ObservedObject var model : ModelData
    
    var body: some View {
        
        ZStack {
                
                // VSTACK
            ScrollView(.vertical) {
                
                
                VStack{
                    
                    // ZSTACK PER L'HEADER
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        
                        
                        // IMMAGINE
                        Image(selected.image)
                            .resizable()
                            .frame(height: 250)
                            .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
                            .matchedGeometryEffect(id: selected.image, in: animation)
                        
                        
                        // HSTACK PER I BOTTONI (CUORE E CHIUDI)
                        HStack {
                            
                            
                            //BOTTONE CUORE
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "suit.heart.fill")
                                    .foregroundColor(.red)
                                    .padding()
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            }) //: BUTTON
                            
                            Spacer()
                            
                            //BOTTONE PER CHIUDERE
                            Button(action: {
                                withAnimation(.spring()) {
                                    show.toggle()
                                }
                            }, label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            }) //: BUTTON
                            
                        } //: HSTACK
                        .padding()
                        // since all edges are ignored....
                        .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                        
                    } //: ZSTACK
                    
                    // HSTACK per prendere tutta la larghezza della pagina
                    HStack(alignment: .top){
                        
                        
                        //VSTACK PER LE INFO DEL GIOCO
                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text(selected.name)
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            
                            // VSTACK TEMPORANEO PER VEDERE I DATI PRESI DAL DB
                            VStack(alignment: .leading) {
                                Text("PS4")
                                    .font(.title)
                                
                                if(richiestePS4.isEmpty) {
                                    Text("Non ci sono richieste per PS4")
                                        .padding(.bottom, 15)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 15) {
                                            ForEach(richiestePS4, id: \.id) { richiesta in
                                                VStack(alignment: .leading) {
                                                    Text("\(richiesta.id)")
                                                    Text(richiesta.console)
                                                    Text(richiesta.gioco.name)
                                                    Text(richiesta.utente.nickname)
                                                }
                                            }
                                        }
                                    }
                                    .padding(.bottom, 15)
                                }


                                
                                Text("XBOX")
                                    .font(.title)
                                
                                if(richiesteXBOX.isEmpty) {
                                    Text("Non ci sono richieste per XBOX")
                                        .padding(.bottom, 15)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 8) {
                                            ForEach(richiesteXBOX, id: \.id) { richiesta in
                                                VStack(alignment: .leading) {
                                                    Text("\(richiesta.id)")
                                                    Text(richiesta.console)
                                                    Text(richiesta.gioco.name)
                                                    Text(richiesta.utente.nickname)
                                                }
                                            }
                                        }
                                    }
                                    .padding(.bottom, 15)
                                }
                                
                                
                                Text("PC")
                                    .font(.title)
                                
                                if(richiestePC.isEmpty) {
                                    Text("Non ci sono richieste per PC")
                                        .padding(.bottom, 15)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 8) {
                                            ForEach(richiestePS4, id: \.id) { richiesta in
                                                VStack(alignment: .leading) {
                                                    Text("\(richiesta.id)")
                                                    Text(richiesta.console)
                                                    Text(richiesta.gioco.name)
                                                    Text(richiesta.utente.nickname)
                                                }
                                            }
                                        }
                                    }
                                    .padding(.bottom, 15)
                                }
                            } //: VSTACK
                            
                        } //:VSTACK
                        
                        Spacer(minLength: 0)
                    } //: HSTACK
                    .padding()
                    .padding(.bottom)
                    
                } //: VSTACK
            }
                
            
            if model.isLoading{
                LoadingView()
            }
            
        } // :ZSTACK
        .background(Color.white)
        .onAppear(perform: {
            withAnimation {
                self.model.isLoading.toggle()
                loadGameStats(game: selected)
            }
        })
    }
    
    
    
    func loadGameStats(game: Game) {
        
        let mac_ip = "192.168.178.103"
        
        guard let url = URL(string: "http://\(mac_ip):8080/api/richieste/getByGameId?gameID=\(game.id)") else {
            print("Invalid URL")
            return
        }
        
        let headers = [
            "accept" : "application/json",
            "accept-encoding": "gzip deflate"
        ]
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = headers
        
        var richiestePS4 = [RichiesteByGameIDElement]()
        var richiesteXBOX = [RichiesteByGameIDElement]()
        var richiestePC = [RichiesteByGameIDElement]()
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                                        
                    guard let json = try? JSONDecoder().decode(RichiesteByGameID.self, from: data) else {
                        print("Error during decoding")
                        return
                    } //: guard let json
                    
                    for richiesta in json {
                        switch richiesta.console {
                        case "PS4":
                            richiestePS4.append(richiesta)
                        case "XBOX":
                            richiesteXBOX.append(richiesta)
                        case "PC":
                            richiestePC.append(richiesta)
                        default:
                            print("Error")
                        }
                    }
                    
                    self.richiestePC = richiestePC
                    self.richiestePS4 = richiestePS4
                    self.richiesteXBOX = richiesteXBOX
                    
                    self.model.isLoading.toggle()
                }//: Async
                
            }//: IfData
            
            else { print("eh no") }
        }//: DataTask
        .resume()
    }
}
