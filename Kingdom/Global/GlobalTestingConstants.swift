//
//  GlobalTestingConstants.swift
//  Kingdom
//
//  Created by Justin Haddadnia on 4/17/20.
//  Copyright © 2020 Justin Haddadnia. All rights reserved.
//

import Foundation


//////
let testPlayer1 = Player(name: "Justin", word: "red")
let testPlayer2 = Player(name: "Sarah", word: "blue")
let testPlayer3 = Player(name: "Bob", word: "green")
let testPlayer4 = Player(name: "Yarn", word: "grey")
let testPlayer5 = Player(name: "Stan", word: "newspaper")
let testPlayer6 = Player(name: "Lee", word: "coders")
let testPlayer7 = Player(name: "Vincent", word: "blackish")

var testGame1 = Game(
    host: testPlayer1,
    gameState: .lobby,
    code: "testcode",
    players: [testPlayer1, testPlayer2, testPlayer3, testPlayer4, testPlayer5, testPlayer6, testPlayer7],
    teams: [testTeam1],
    words: ["red","blue", "green"],
    guessingPlayer: testPlayer4
)
//player 3 gets it wrong
var testGame2 = Game(
    host: testPlayer1,
    gameState: .playing,
    code: "testcode",
    players: [testPlayer1, testPlayer2, testPlayer3, testPlayer4, testPlayer5, testPlayer6, testPlayer7],
    teams: [testTeam1],
    words: ["red","blue", "green"],
    guessingPlayer: testPlayer1
)
//player 1 guesses player 3's word
let testTeam1 = Team(teamName: "", leader: testPlayer1, players:[testPlayer1, testPlayer3])
var testGame3 = Game(
    host: testPlayer1,
    gameState: .playing,
    code: "testcode",
    players: [testPlayer1, testPlayer2, testPlayer3, testPlayer4, testPlayer5, testPlayer6, testPlayer7],
    teams: [testTeam1],
    words: ["red","blue", "green"],
    guessingPlayer: testPlayer2
)
// player 1 guesses wrong
