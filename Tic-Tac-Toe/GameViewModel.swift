//
//  GameViewModel.swift
//  Tic-Tac-Toe
//
//  Created by Nisanur Korkmaz on 25/03/2023.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    let columns : [GridItem] = [GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible()),]
    
    
    @Published var moves : [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisabled = false
    @Published var alertItem : AlertItem?
    
    
    func processPlayerMove(for position : Int){
        
        //                        controle si le cercle est déjà occupé, ne fait rien
                                if isSquareOccupied(in: moves, forIndex: position){
                                    return
                                }
                                
        //                        l'humain joue
                                moves[position] = Move(player: .human, boardIndex: position)
                                
        //                        check for win condition or draw
                                if checkWinCondition(for: .human, in: moves){
                                    alertItem = AlertContext.humanWin
                                    return
                                }
                                if checkForDraw(in: moves){
                                    alertItem = AlertContext.draw
                                    return
                                }
                                isGameBoardDisabled = true
        //                        l'odinateur joue
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [self] in
                                    let computerPosition = determineComputerMovePosition(in: moves)
                                    moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                                    isGameBoardDisabled = false
                                    
                                    //                          check for win condition or draw
                                    if checkWinCondition(for: .computer, in: moves){
                                        alertItem = AlertContext.computerWin
                                        return
                                    }
                                    if checkForDraw(in: moves){
                                        alertItem = AlertContext.draw
                                        return
                                    }
                                }
        
        
    }
    
    //    controle de la place occupé ou non
        func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool{
            
            return moves.contains(where: {$0?.boardIndex == index})
        }
        
    //
        func determineComputerMovePosition(in moves: [Move?]) -> Int{
            var MovePosition = Int.random(in: 0..<9)
            
            while isSquareOccupied(in: moves, forIndex: MovePosition){
                 MovePosition = Int.random(in: 0..<9)
            }
            return MovePosition
        }
        
        func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool{
            let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
            let playerMoves = moves.compactMap{ $0 }.filter {$0.player == player}
            let playerPositions = Set(playerMoves.map{$0.boardIndex})
            
            for pattern in winPatterns where pattern.isSubset(of : playerPositions) {
                return true
            }
            return false
        }
        
        func checkForDraw(in moves : [Move?]) -> Bool{
            return moves.compactMap { $0 }.count == 9
        }
        
        func resetGame() {
            moves = Array(repeating: nil, count: 9)
        }

}
