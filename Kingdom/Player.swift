//
//  Player.swift
//  Kingdom
//
//  Created by Justin Haddadnia on 4/16/20.
//  Copyright © 2020 Justin Haddadnia. All rights reserved.
//

import Foundation
class Player {
    init(name: String, word: String) {
        self.name = name
        self.word = word
    }
    
    var name: String = ""
    let teammates: [Player] = []
    let leader: Player? = nil
    var word: String
}
