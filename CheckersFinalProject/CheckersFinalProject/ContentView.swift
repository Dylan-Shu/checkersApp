//
//  ContentView.swift
//  CheckersFinalProject
//
//  Created by Dylan Shu on 5/3/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    enum turn{
        case orange, blue
    }
    @Binding var main_screen:Bool
    @Binding var current_game:gamemode
    @State var piece:[[pieces]] = Array(repeating: Array(repeating: pieces(), count: 8), count: 8)
    @State var player_turn:turn = .blue
    @State var player_coord = [coordinate]()
    @State var opponent = [coordinate]()
    @State var move = coordinate(x: 0, y: 0)
    @State var takePiece = [coordinate]()
    @State var valid_move: Bool = false
    @State var white_tile: Int = 12
    @State var black_tile: Int = 12
    @State var win: String = ""
    
    var body: some View {
        ZStack{
            Image("checker")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .offset(x: -24.9, y: 0)
        ScrollView {
            VStack{
                HStack {
                    Image("P1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                    
                    VStack {
                        HStack {
                            
                            Image("VS")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .padding(30)
                        
                        }
                    }
                    Image("P2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                }.padding(.leading, 10)
                .padding(.trailing, 10)
                  
         
                
               ZStack{
                   VStack(alignment: .center, spacing: 0.0) {
                       ForEach(0..<8) { i in
                           HStack(spacing: 0.0) {
                               ForEach(0..<8) { j in
                                   Rectangle()
                                       .frame(width: 50, height: 50)
                                       .foregroundColor(map_color(i: i, j: j))
                               }
                           }
                       }
                   }
                   ZStack{
                       VStack(alignment: .center) {
                           ForEach(0..<8) { i in
                               HStack {
                                   ForEach(0..<8) { j in
                                       Circle()
                                           .stroke(pick_color(x: i, y: j),lineWidth:8)
                                           .frame(width: 42, height: 42)
                                           .opacity(choice(x: i, y: j))
                                   }
                               }
                           }
                       }
                       VStack(alignment: .center) {
                           ForEach(0..<8) { i in
                               HStack {
                                   ForEach(0..<8) { j in
                                       Circle()
                                           .frame(width: 42, height: 42)
                                           .foregroundColor(piece[i][j].color)
                                           .opacity(piece[i][j].transparent)
                                           .onTapGesture {
                                               checkselect(i: i, j: j)
                                           }
                                   }
                               }
                           }
                       }
                       VStack(alignment: .center) {
                           ForEach(0..<8) { i in
                               HStack {
                                   ForEach(0..<8) { j in
                                       Image("crown")
                                           .resizable()
                                           .padding(.all, 13.0)
                                           .scaledToFill()
                                           .frame(width: 42, height: 42)
                                           .opacity(king(i: i, j: j))
                                   }
                               }
                           }
                       }
                       VStack{
                           if win != ""{
                               if win == "P2 Win"{
                                   Button {
                                   main_screen = false
                                   } label: {
                                       Image("P1WIN")
                                           .resizable()
                                           .scaledToFill()
                                           .frame(width: 200, height: 100)
                                   }
                           }
                               else{
                                   Button {
                                   main_screen = false
                                   } label: {
                                       Image("P2WIN")
                                           .resizable()
                                           .scaledToFill()
                                           .frame(width: 200, height: 100)
                                   }
                               }
                       }
                       
                   }
                   }
                   
               }
                HStack{
                    Button(action: {main_screen = false}, label: {
                        
                        Image("HOME")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90,height:70)
                            .padding(60)
                        
                    })
                Button {
                       start()
                   } label: {
                       Image("STARTS")
                           .resizable()
                           .scaledToFill()
                           .frame(width: 90, height: 70)
                           .padding(60)
                   }
            }
           }
        
        }
    }
    }

    func map_color(i:Int, j:Int)->Color{
            if i % 2 == 0{
                if j % 2 == 0{
                    return Color.gray
                }
                else{
                    return Color.black
                }
            }
            else{
                if j % 2 == 0{
                    return Color.black
                }
                else{
                    return Color.gray
                }
            }
        }
        
        func start(){
            piece = Array(repeating: Array(repeating: pieces(), count: 8), count: 8)
            player_turn = .blue
            player_coord = [coordinate]()
            opponent = [coordinate]()
            move = coordinate(x: 0, y: 0)
            takePiece = [coordinate]()
            valid_move = false
            white_tile = 12
            black_tile = 12
            win = ""
            for i in 0...7{
                for j in 0...7{
                        if i < 3{
                            if i % 2 == 0{
                                if j % 2 == 0{
                                    piece[i][j].color = Color.orange
                                    piece[i][j].transparent = 1
                                }
                            }
                            else{
                                if j % 2 == 1{
                                    piece[i][j].color = Color.orange
                                    piece[i][j].transparent = 1
                                }
                            }
                        }
                        else if i > 4{
                            if i % 2 == 0{
                                if j % 2 == 0{
                                    piece[i][j].color = Color.blue
                                    piece[i][j].transparent = 1
                                }
                            }
                            else{
                                if j % 2 == 1{
                                    piece[i][j].color = Color.blue
                                    piece[i][j].transparent = 1
                                }
                            }
                        }
                    }
                }
        }
        
        func pick_color(x:Int, y:Int) -> Color{
            if piece[x][y].select == true{
                return Color.red
            }
            else{
                return piece[x][y].color
            }
        }
        func choice(x:Int, y:Int) -> Double{
            if piece[x][y].select == true{
                return 1
            }
            else{
                return 0
            }
        }
        func position(){
            for player in player_coord{
                if piece[player.x][player.y].transparent == 0.3{
                    piece[player.x][player.y].transparent = 0
                    piece[player.x][player.y].color = Color.red
                }
            }
            player_coord = [coordinate]()
        }
        func position(i:Int, j:Int, turn_color:Color, enemycolor: Color){
            if piece[i][j].color == Color.orange{
                if piece[i][j].king == false{
                    if i + 2 < 8 && j - 2 >= 0 && piece[i+1][j-1].color == enemycolor && piece[i+2][j-2].transparent == 0{
                        piece[i+2][j-2].color = turn_color
                        piece[i+2][j-2].transparent = 0.3
                        opponent.append(coordinate(x: i+2, y: j-2))
                    }
                    if i + 2 < 8 && j + 2 < 8 && piece[i+1][j+1].color == enemycolor && piece[i+2][j+2].transparent == 0{
                        piece[i+2][j+2].color = turn_color
                        piece[i+2][j+2].transparent = 0.3
                        opponent.append(coordinate(x: i+2, y: j+2))
                    }
                }
                else{
                    if i - 2 >= 0 && j - 2 >= 0 && piece[i-1][j-1].color == enemycolor && piece[i-2][j-2].transparent == 0{
                        piece[i-2][j-2].color = turn_color
                        piece[i-2][j-2].transparent = 0.3
                        opponent.append(coordinate(x: i-2, y: j-2))
                    }
                    if i - 2 >= 0 && j + 2 < 8 && piece[i-1][j+1].color == enemycolor && piece[i-2][j+2].transparent == 0{
                        piece[i-2][j+2].color = turn_color
                        piece[i-2][j+2].transparent = 0.3
                        opponent.append(coordinate(x: i-2, y: j+2))
                    }
                    if i + 2 < 8 && j - 2 >= 0 && piece[i+1][j-1].color == enemycolor && piece[i+2][j-2].transparent == 0{
                        piece[i+2][j-2].color = turn_color
                        piece[i+2][j-2].transparent = 0.3
                        opponent.append(coordinate(x: i+2, y: j-2))
                    }
                    if i + 2 < 8 && j + 2 < 8 && piece[i+1][j+1].color == enemycolor && piece[i+2][j+2].transparent == 0{
                        piece[i+2][j+2].color = turn_color
                        piece[i+2][j+2].transparent = 0.3
                        opponent.append(coordinate(x: i+2, y: j+2))
                    }
                }
            }
            else if piece[i][j].color == Color.blue{
                if piece[i][j].king == false{
                    if i - 2 >= 0 && j - 2 >= 0 && piece[i-1][j-1].color == enemycolor && piece[i-2][j-2].transparent == 0{
                        piece[i-2][j-2].color = turn_color
                        piece[i-2][j-2].transparent = 0.3
                        opponent.append(coordinate(x: i-2, y: j-2))
                    }
                    if i - 2 >= 0 && j + 2 < 8 && piece[i-1][j+1].color == enemycolor && piece[i-2][j+2].transparent == 0{
                        piece[i-2][j+2].color = turn_color
                        piece[i-2][j+2].transparent = 0.3
                        opponent.append(coordinate(x: i-2, y: j+2))
                    }
                }
                else{
                    if i - 2 >= 0 && j - 2 >= 0 && piece[i-1][j-1].color == enemycolor && piece[i-2][j-2].transparent == 0{
                        piece[i-2][j-2].color = turn_color
                        piece[i-2][j-2].transparent = 0.3
                        opponent.append(coordinate(x: i-2, y: j-2))
                    }
                    if i - 2 >= 0 && j + 2 < 8 && piece[i-1][j+1].color == enemycolor && piece[i-2][j+2].transparent == 0{
                        piece[i-2][j+2].color = turn_color
                        piece[i-2][j+2].transparent = 0.3
                        opponent.append(coordinate(x: i-2, y: j+2))
                    }
                    if i + 2 < 8 && j - 2 >= 0 && piece[i+1][j-1].color == enemycolor && piece[i+2][j-2].transparent == 0{
                        piece[i+2][j-2].color = turn_color
                        piece[i+2][j-2].transparent = 0.3
                        opponent.append(coordinate(x: i+2, y: j-2))
                    }
                    if i + 2 < 8 && j + 2 < 8 && piece[i+1][j+1].color == enemycolor && piece[i+2][j+2].transparent == 0{
                        piece[i+2][j+2].color = turn_color
                        piece[i+2][j+2].transparent = 0.3
                        opponent.append(coordinate(x: i+2, y: j+2))
                    }
                }
            }
        }
    
        func highlight(){
            for highlight in opponent{
                piece[highlight.x][highlight.y].transparent = 0
                piece[highlight.x][highlight.y].color = Color.red
            }
            opponent = [coordinate]()
        }
        func opponent_choice(x:Int, y:Int){
            for i in 0...7{
                for j in 0...7{
                    if i == x && j == y{
                        piece[i][j].select = true
                    }
                    else{
                        piece[i][j].select = false
                    }
                }
            }
        }
        func takePieceEmpty(){
            takePiece = [coordinate]()
        }
        
        func checktakePiece(mycolor:Color,opponent_color:Color){
            for i in 0...7{
                for j in 0...7{
                    if mycolor == Color.orange && piece[i][j].color == mycolor{
                        var tmp_index = 0
                        if piece[i][j].king == false{
                            if i + 2 < 8 && j - 2 >= 0 && piece[i+1][j-1].color == opponent_color && piece[i+1][j-1].transparent == 1 && piece[i+2][j-2].transparent == 0{
                                tmp_index = 1
                            }
                            if i + 2 < 8 && j + 2 < 8 && piece[i+1][j+1].color == opponent_color && piece[i+1][j+1].transparent == 1 && piece[i+2][j+2].transparent == 0{
                                tmp_index = 1
                            }
                            if tmp_index == 1{
                                takePiece.append(coordinate(x: i, y: j))
                            }
                        }
                        else{
                            if i + 2 < 8 && j - 2 >= 0 && piece[i+1][j-1].color == opponent_color && piece[i+1][j-1].transparent == 1  && piece[i+2][j-2].transparent == 0{
                                tmp_index = 1
                            }
                            if i + 2 < 8 && j + 2 < 8 && piece[i+1][j+1].color == opponent_color && piece[i+1][j+1].transparent == 1  && piece[i+2][j+2].transparent == 0{
                                tmp_index = 1
                            }
                            if i - 2 >= 0 && j - 2 >= 0 && piece[i-1][j-1].color == opponent_color && piece[i-1][j-1].transparent == 1  && piece[i-2][j-2].transparent == 0{
                                tmp_index = 1
                            }
                            if i - 2 >= 0 && j + 2 < 8 && piece[i-1][j+1].color == opponent_color && piece[i-1][j+1].transparent == 1  && piece[i-2][j+2].transparent == 0{
                                tmp_index = 1
                            }
                            if tmp_index == 1{
                                takePiece.append(coordinate(x: i, y: j))
                            }
                        }
                    }
                    else if mycolor == Color.blue && piece[i][j].color == mycolor{
                        var tmp_index = 0
                        if piece[i][j].king == false{
                            if i - 2 >= 0 && j - 2 >= 0 && piece[i-1][j-1].color == opponent_color && piece[i-1][j-1].transparent == 1  && piece[i-2][j-2].transparent == 0{
                                tmp_index = 1
                            }
                            if i - 2 >= 0 && j + 2 < 8 && piece[i-1][j+1].color == opponent_color && piece[i-1][j+1].transparent == 1  && piece[i-2][j+2].transparent == 0{
                                tmp_index = 1
                            }
                            if tmp_index == 1{
                                takePiece.append(coordinate(x: i, y: j))
                            }
                        }
                        else{
                            if i + 2 < 8 && j - 2 >= 0 && piece[i+1][j-1].color == opponent_color && piece[i+1][j-1].transparent == 1  && piece[i+2][j-2].transparent == 0{
                                tmp_index = 1
                            }
                            if i + 2 < 8 && j + 2 < 8 && piece[i+1][j+1].color == opponent_color && piece[i+1][j+1].transparent == 1  && piece[i+2][j+2].transparent == 0{
                                tmp_index = 1
                            }
                            if i - 2 >= 0 && j - 2 >= 0 && piece[i-1][j-1].color == opponent_color && piece[i-1][j-1].transparent == 1  && piece[i-2][j-2].transparent == 0{
                                tmp_index = 1
                            }
                            if i - 2 >= 0 && j + 2 < 8 && piece[i-1][j+1].color == opponent_color && piece[i-1][j+1].transparent == 1  && piece[i-2][j+2].transparent == 0{
                                tmp_index = 1
                            }
                            if tmp_index == 1{
                                takePiece.append(coordinate(x: i, y: j))
                            }
                        }
                    }
                }
            }
        }
        func player_color(color:Color)->turn{
            if color == Color.orange{
                return .orange
            }
            else{
                return .blue
            }
        }
        
        func win_message(){
            if black_tile == 0{
                win = "P2 Win"
            }
            if white_tile == 0{
                win = "P1 Win"
            }
        }
        func checkmove(color:Color)->Bool{
            for i in 0...7{
                for j in 0...7{
                    if color == Color.orange{
                        if piece[i][j].king == false{
                            if i + 1 < 8 && (j - 1 >= 0 || j + 1 < 8){
                                if j - 1 >= 0 && piece[i + 1][j - 1].transparent == 0{
                                    return true
                                }
                                 if j + 1 < 8 && piece[i + 1][j + 1].transparent == 0{
                                    return true
                                }
                            }
                        }
                        else{
                            if (i + 1 < 8 || i - 1 >= 0) && (j - 1 >= 0 || j + 1 < 8 ){
                                if j - 1 >= 0 && i + 1 < 8 && piece[i + 1][j - 1].transparent == 0{
                                    return true
                                }
                                 if j + 1 < 8 && i + 1 < 8 && piece[i + 1][j + 1].transparent == 0{
                                    return true
                                 }
                                if j - 1 >= 0 && i - 1 >= 0 && piece[i - 1][j - 1].transparent == 0{
                                    return true
                                }
                                if j + 1 < 8 && i - 1 >= 0 && piece[i - 1][j + 1].transparent == 0{
                                   return true
                                }
                            }
                        }
                    }
                    else{
                        if piece[i][j].king == false{
                            if i - 1 >= 0 && (j - 1 >= 0 || j + 1 < 8){
                                if j - 1 >= 0 && piece[i - 1][j - 1].transparent == 0{
                                    return true
                                }
                                 if j + 1 < 8 && piece[i - 1][j + 1].transparent == 0{
                                    return true
                                }
                            }
                        }
                        else{
                            if (i + 1 < 8 || i - 1 >= 0) && (j - 1 >= 0 || j + 1 < 8 ){
                                if j - 1 >= 0 && i + 1 < 8 && piece[i + 1][j - 1].transparent == 0{
                                    return true
                                }
                                 if j + 1 < 8 && i + 1 < 8 && piece[i + 1][j + 1].transparent == 0{
                                    return true
                                 }
                                if j - 1 >= 0 && i - 1 >= 0 && piece[i - 1][j - 1].transparent == 0{
                                    return true
                                }
                                if j + 1 < 8 && i - 1 >= 0 && piece[i - 1][j + 1].transparent == 0{
                                   return true
                                }
                            }
                        }
                    }
                }
            }
            return false
        }
        
    func color_filled(){
        for player in player_coord{
            if piece[player.x][player.y].transparent == 0.3{
                piece[player.x][player.y].transparent = 0
                piece[player.x][player.y].color = Color.red
            }
        }
        player_coord = [coordinate]()
    }
    
        func checkselect(i:Int, j:Int){
            var turn_color: Color
            var enemycolor: Color
            switch player_turn{
            case.orange:
                turn_color = Color.orange
            case.blue:
                turn_color = Color.blue
            }
            if turn_color == Color.orange{
                enemycolor = Color.blue
            }
            else{
                enemycolor = Color.orange
            }
            if checkmove(color: turn_color)==false{
                if turn_color == Color.blue{
                    win = "Orange"
                }
                else{
                    win = "Blue"
                }
            }
            if takePiece.count != 0{
                for highlight in takePiece{
                    piece[highlight.x][highlight.y].select = true
                }
                if piece[i][j].select == true && piece[i][j].color == turn_color && valid_move == false{
                    opponent_choice(x: i,y: j)
                    highlight()
                    move = coordinate(x: i, y: j)
                    position(i: i, j: j, turn_color: turn_color, enemycolor: enemycolor)
                }
                else if piece[i][j].transparent == 0.3 && piece[i][j].color == turn_color{
                    highlight()
                    piece[i][j].transparent = 1
                    piece[i][j].color = turn_color
                    piece[move.x][move.y].color = Color.red
                    piece[move.x][move.y].transparent = 0
                    piece[i][j].king = piece[move.x][move.y].king
                    piece[move.x][move.y].king = false
                    piece[(move.x+i)/2][(move.y + j)/2].transparent = 0
                    piece[(move.x+i)/2][(move.y + j)/2].king = false
                    if piece[(move.x+i)/2][(move.y + j)/2].color == Color.orange{
                        black_tile -= 1
                    }
                    else{
                        white_tile -= 1
                    }
                    piece[(move.x+i)/2][(move.y + j)/2].color = Color.red
                    win_message()
                    if piece[i][j].color==Color.orange && i==7{
                        piece[i][j].king = true
                    }
                    else if piece[i][j].color==Color.blue && i==0{
                        piece[i][j].king = true
                    }
                    position(i: i, j: j, turn_color: turn_color, enemycolor: enemycolor)
                    if opponent.count == 0{
                        valid_move = false
                        opponent_choice(x: -1, y: -1)
                        takePieceEmpty()
                        checktakePiece(mycolor: enemycolor, opponent_color: turn_color)
                        player_turn = player_color(color: enemycolor)
                    }
                    else{
                        move = coordinate(x: i, y: j)
                        opponent_choice(x: i, y: j)
                        valid_move = true
                        takePieceEmpty()
                        takePiece.append(coordinate(x: i, y: j))
                    }
                }
            }
            else if piece[i][j].color == turn_color && piece[i][j].transparent == 1{
                piece[move.x][move.y].select = false
                piece[i][j].select = true
                color_filled()
                move = coordinate(x: i, y: j)
                if turn_color == Color.orange{
                    if piece[i][j].king == false{
                        if i + 1 < 8 && (j - 1 >= 0 || j + 1 < 8){
                            if j - 1 >= 0 && piece[i + 1][j - 1].transparent == 0{
                                piece[i + 1][j - 1].transparent = 0.3
                                piece[i + 1][j - 1].color = Color.orange
                                player_coord.append(coordinate(x: i + 1, y: j - 1))
                            }
                             if j + 1 < 8 && piece[i + 1][j + 1].transparent == 0{
                                piece[i + 1][j + 1].transparent = 0.3
                                piece[i + 1][j + 1].color = Color.orange
                                player_coord.append(coordinate(x: i + 1, y: j + 1))
                            }
                        }
                    }
                    else{
                        if (i + 1 < 8 || i - 1 >= 0) && (j - 1 >= 0 || j + 1 < 8 ){
                            if j - 1 >= 0 && i + 1 < 8 && piece[i + 1][j - 1].transparent == 0{
                                piece[i + 1][j - 1].transparent = 0.3
                                piece[i + 1][j - 1].color = Color.orange
                                player_coord.append(coordinate(x: i + 1, y: j - 1))
                            }
                             if j + 1 < 8 && i + 1 < 8 && piece[i + 1][j + 1].transparent == 0{
                                piece[i + 1][j + 1].transparent = 0.3
                                piece[i + 1][j + 1].color = Color.orange
                                player_coord.append(coordinate(x: i + 1, y: j + 1))
                             }
                            if j - 1 >= 0 && i - 1 >= 0 && piece[i - 1][j - 1].transparent == 0{
                                piece[i - 1][j - 1].transparent = 0.3
                                piece[i - 1][j - 1].color = Color.orange
                                player_coord.append(coordinate(x: i - 1, y: j - 1))
                            }
                            if j + 1 < 8 && i - 1 >= 0 && piece[i - 1][j + 1].transparent == 0{
                               piece[i - 1][j + 1].transparent = 0.3
                               piece[i - 1][j + 1].color = Color.orange
                               player_coord.append(coordinate(x: i - 1, y: j + 1))
                            }
                        }
                    }
                }
                else{
                    if piece[i][j].king == false{
                        if i - 1 >= 0 && (j - 1 >= 0 || j + 1 < 8){
                            if j - 1 >= 0 && piece[i - 1][j - 1].transparent == 0{
                                piece[i - 1][j - 1].transparent = 0.3
                                piece[i - 1][j - 1].color = Color.blue
                                player_coord.append(coordinate(x: i - 1, y: j - 1))
                            }
                             if j + 1 < 8 && piece[i - 1][j + 1].transparent == 0{
                                piece[i - 1][j + 1].transparent = 0.3
                                piece[i - 1][j + 1].color = Color.blue
                                player_coord.append(coordinate(x: i - 1, y: j + 1))
                            }
                        }
                    }
                    else{
                        if (i + 1 < 8 || i - 1 >= 0) && (j - 1 >= 0 || j + 1 < 8 ){
                            if j - 1 >= 0 && i + 1 < 8 && piece[i + 1][j - 1].transparent == 0{
                                piece[i + 1][j - 1].transparent = 0.3
                                piece[i + 1][j - 1].color = Color.blue
                                player_coord.append(coordinate(x: i + 1, y: j - 1))
                            }
                             if j + 1 < 8 && i + 1 < 8 && piece[i + 1][j + 1].transparent == 0{
                                piece[i + 1][j + 1].transparent = 0.3
                                piece[i + 1][j + 1].color = Color.blue
                                player_coord.append(coordinate(x: i + 1, y: j + 1))
                             }
                            if j - 1 >= 0 && i - 1 >= 0 && piece[i - 1][j - 1].transparent == 0{
                                piece[i - 1][j - 1].transparent = 0.3
                                piece[i - 1][j - 1].color = Color.blue
                                player_coord.append(coordinate(x: i - 1, y: j - 1))
                            }
                            if j + 1 < 8 && i - 1 >= 0 && piece[i - 1][j + 1].transparent == 0{
                               piece[i - 1][j + 1].transparent = 0.3
                               piece[i - 1][j + 1].color = Color.blue
                               player_coord.append(coordinate(x: i - 1, y: j + 1))
                            }
                        }
                    }
                }
            }
            else if piece[i][j].color == turn_color && piece[i][j].transparent == 0.3{
                piece[i][j].transparent = 1
                piece[move.x][move.y].color = Color.red
                piece[move.x][move.y].select = false
                piece[i][j].king = piece[move.x][move.y].king
                piece[move.x][move.y].transparent = 0
                piece[move.x][move.y].king = false
                if piece[i][j].color==Color.orange && i==7{
                    piece[i][j].king = true
                }
                else if piece[i][j].color==Color.blue && i==0{
                    piece[i][j].king = true
                }
                print(piece[i][j].king)
                color_filled()
                player_turn = player_color(color: enemycolor)
                takePieceEmpty()
                checktakePiece(mycolor: enemycolor, opponent_color: turn_color)
            }

            if takePiece.count != 0{
                for highlight in takePiece{
                    piece[highlight.x][highlight.y].select = true
                }
            }
        }
        
        func king(i:Int, j:Int) -> Double{
            if piece[i][j].king == true{
                return 1
            }
            else{
                return 0
            }
        }
        
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(main_screen: .constant(true), current_game: .constant(.pvp))
    }
}
