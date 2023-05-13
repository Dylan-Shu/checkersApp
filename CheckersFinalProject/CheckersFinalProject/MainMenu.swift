//
//  MainMenu.swift
//  CheckersFinalProject
//
//  Created by Dylan Shu on 5/10/23.
//

import SwiftUI
import Foundation


struct mainmenu: View {
    @State private var main_screen = false
    @State private var current_game:gamemode = .pvp
    @State private var move_distance: Double = 50
    @State private var transparent: Double = 1
   
    var body: some View {
        ZStack {
            Image("checker")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .offset(x: -24.9, y: 0)
                
        VStack(spacing: 10){
            
            Image("checkers")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 300)
            
            VStack(){
            Button(action: {main_screen = true;
                current_game = .pvp
                               
                                }, label: {
                      Image("VS PLAYER")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 100)
                                        
                                        
                                }) .fullScreenCover(isPresented: $main_screen, content:{ContentView(main_screen: $main_screen, current_game: $current_game )})
            }
                   
        }
    
    }
}
}

struct mainmenuview: PreviewProvider {
    static var previews: some View {
        mainmenu()
    }
}
