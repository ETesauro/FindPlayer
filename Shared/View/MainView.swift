//
//  MainView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 22/08/2020.
//

import SwiftUI

struct MainView: View {
    //MARK: - PROPERTIES
    @State var tab = 1
    @Namespace var animation
    @State var show = false
    @State var selected : Game = games[0]
    
    
    @AppStorage("log_Status") var userIsLogged = false
    @StateObject var model = ModelData()
    
    
    //MARK: - BODY
    var body: some View{
        
        ZStack{
            
            // IF USERISLOGGED = TRUE -> VAI ALLA PAGINA PRINCIPALE
            if userIsLogged {
                
                TabView(selection: $tab) {
                    ExploreView(animation: animation, show: $show, selected: $selected)
                        .edgesIgnoringSafeArea(.top)
                        .tabItem {
                            Image(systemName: tab == 1 ? "safari.fill" : "safari")
                            Text("Explore")
                        }
                        .tag(1)
                    
                    SearchView()
                        .edgesIgnoringSafeArea(.top)
                        .tabItem {
                            Image(systemName: tab == 2 ? "magnifyingglass.circle.fill" : "magnifyingglass.circle")
                            Text("Search")
                        }
                        .tag(2)
                    
                    ProfileView(model: model)
                        .edgesIgnoringSafeArea(.top)
                        .tabItem {
                            Image(systemName: tab == 3 ? "person.fill" : "person")
                            Text("Profile")
                        }
                        .tag(3)
                } // :TABVIEW
                
            } //: IF
            
            //IF USERISLOGGED = FALSE -> DEVI FARE IL LOGIN
            else {
                
                LoginView(model: model)
                
            } //: ELSE
            
            
            // Detail View...
            if show{
                GameDetailView(selected: $selected, show: $show, animation: animation, model: model)
            }//: IF SHOW
            
        } // :ZSTACK
        .background(Color("GrayWhite"))
        .edgesIgnoringSafeArea(.all)
    }
}
