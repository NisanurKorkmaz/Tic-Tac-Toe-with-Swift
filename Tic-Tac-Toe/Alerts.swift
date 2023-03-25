//
//  Alerts.swift
//  Tic-Tac-Toe
//
//  Created by Nisanur Korkmaz on 25/03/2023.
//

import SwiftUI

struct AlertItem : Identifiable {
    let id = UUID()
    var title : Text
    var message : Text
    var butonTitle : Text
}

struct AlertContext {
    
    static let humanWin = AlertItem(title: Text("You win !"),
                             message: Text("You are so smart"),
                             butonTitle: Text("Hell yeah"))
    

    static let computerWin = AlertItem(title: Text("You lost !"),
                             message: Text("You programmed a super AI"),
                             butonTitle: Text("Rematch"))
    
    static let draw = AlertItem(title: Text("Draw"),
                             message: Text("What a battle "),
                             butonTitle: Text("Try again"))
    
}
