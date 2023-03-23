//
//  ContentView.swift
//  Tic-Tac-Toe
//
//  Created by Nisanur Korkmaz on 23/03/2023.
//

import SwiftUI




struct ContentView: View {
    let columns : [GridItem] = [GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible()),]
    
    @State private var moves : [Move?] = Array(repeating: nil, count: 9)
    
    
    var body: some View {
        GeometryReader{ geometry in
        VStack{
            Spacer()
            LazyVGrid(columns: columns, spacing: 5){
                ForEach(0..<9){ i in
                    ZStack{
                        Circle()
                            .foregroundColor(.red.opacity(0.5))
                            .frame(width: geometry.size.width/3 - 15,
                                   height: geometry.size.width/3 - 15)
                    }
                    
                }
            }
            Spacer()
        }
        .padding()
        }
    }
}

enum Player{
    case human, computer
}

struct Move{
    let player : Player
    let boardIndex: Int
    
    var indicator : String {
        return player == .human ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
