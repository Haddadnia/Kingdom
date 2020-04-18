//
//  Game.swift
//  Kingdom
//
//  Created by Justin Haddadnia on 4/16/20.
//  Copyright © 2020 Justin Haddadnia. All rights reserved.
//

import Foundation

enum GameState {
    case lobby
    case playing
    case postGame
}

struct Game {

    //setup
    var host: Player
    var gameState: GameState
    var code: String
    
    //game setup
    var players: [Player]
    var teams: [Team]
    var words: [String]
    
    //gameplay
    var guessingPlayer: Player
}
