//
//  TESTGameDetailView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 22/08/2020.
//

import SwiftUI

struct GameDetailView: View {
    
    //È un array poichè RichiesteByGameID è un typealias di [RichiesteByGameIDElement]
    @State private var richieste = RichiesteByGameID()
    
    @Binding var selected : Game
    @Binding var show : Bool
    var animation : Namespace.ID
    
    @ObservedObject var model : ModelData
    
    var body: some View {
//        VStack {
//            Text("ciao")
//
//            ForEach(richieste, id: \.id) { richiesta in
//                Text("\(richiesta.id)")
//                Text(richiesta.console)
//                Text(richiesta.gioco.name)
//            }
//        }
//        .onAppear {
//            loadGameStats(game: selected)
//        }
        
        ZStack {
            
            // MAIN VSTACK
            VStack{
                
                // VSTACK
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
                    
                    // Details View...
                    HStack(alignment: .top){
                        
                        
                        //VSTACK PER LE INFO DEL GIOCO
                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text(selected.name)
                                .font(.title)
                            
                            //                            Image(systemName: "heart.fill")
                            //
                            //                            Image(systemName: "star.fill")
                            //                                .foregroundColor(.yellow)
                            
                            
                            // HSTACK PER IL BOTTONE PER FARE RICHIESTA
                            HStack {
                                Spacer(minLength: 0)
                                
//                                AddToDBButtonView(selected: $selected)
                                
                                Spacer(minLength: 0)
                            } //: HSTACK
                            
                            
                            // VSTACK TEMPORANEO PER VEDERE I DATI PRESI DAL DB
                            VStack {
                                ForEach(richieste, id: \.id) { richiesta in
                                    Text("\(richiesta.id)")
                                    Text(richiesta.console)
                                    Text(richiesta.gioco.name)
                                }
                            } //: VSTACK
                        } //:VSTACK
                        
                        Spacer(minLength: 0)
                    } //: HSTACK
                    .padding()
                    .padding(.bottom)
                    
                } //: VSTACK
                .background(Color.white)
                .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
                
                Spacer(minLength: 0)
                
            } //: MAIN VSTACK
            
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
        guard let url = URL(string: "http://localhost:8080/api/richieste/getByGameId?gameID=\(game.id)") else {
            print("Invalid URL")
            return
        }
        
        let headers = [
            "accept" : "application/json",
            "accept-encoding": "gzip deflate"
        ]
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    
                    guard let json = try? JSONDecoder().decode(RichiesteByGameID.self, from: data) else {
                        print("Error during decoding")
                        return
                    } //: guard let json
                    
                    self.richieste = json
                    
                    self.model.isLoading.toggle()
                }//: Async
                
            }//: IfData
            
            else { print("eh no") }
        }//: DataTask
        .resume()
    }
}
