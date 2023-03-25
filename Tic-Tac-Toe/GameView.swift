//
//  ContentView.swift
//  Tic-Tac-Toe
//
//  Created by Nisanur Korkmaz on 23/03/2023.
//

import SwiftUI


struct GameView: View {

    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        GeometryReader{ geometry in
        VStack{
            Spacer()
            LazyVGrid(columns: viewModel.columns, spacing: 5){
                ForEach(0..<9){ i in
                    ZStack{
                        GameSquareView(geometry: geometry)
                        PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                    }
                    .onTapGesture {
                        viewModel.processPlayerMove(for: i)
                    }
                }
            }
            Spacer()
        }
        .disabled(viewModel.isGameBoardDisabled)
        .padding()
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: .default(alertItem.butonTitle, action: {viewModel.resetGame() }))
            
            })
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
            GameView()
        }
    }

    struct GameSquareView: View {
        var geometry : GeometryProxy
        
        var body: some View {
            Circle()
                .foregroundColor(.red.opacity(0.5))
                .frame(width: geometry.size.width/3 - 15,
                       height: geometry.size.width/3 - 15)
        }
    }

    struct PlayerIndicator: View {
        var systemImageName: String
        
        var body: some View {
            Image(systemName: systemImageName)
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
        }
    }
