//
//  LobbyViewController.swift
//  Kingdom
//
//  Created by Justin Haddadnia on 4/16/20.
//  Copyright © 2020 Justin Haddadnia. All rights reserved.
//

import Foundation
import UIKit

protocol LobbyViewControllerDelegate: class {
    func lobbyviewControllerDidFinish()
}

class LobbyViewController: UIViewController {
    
    //MARK - properties
    let game: Game
    let currentPlayer: Player
    
    
    // MARK - initializers
    init(game: Game, currentPlayer: Player) {
        self.game = game
        self.currentPlayer = currentPlayer
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addAndCenter(views: [topLabel, startButton])
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        startButton.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 200).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        if (game.host.name == currentPlayer.name) { //replace with a real check for me being host
            if (game.players.count < 2) {
                label.text = Strings.playerWarning
            } else {
                label.text = Strings.hostDirections
            }
        } else {
            label.text = Strings.waitingForHost
        }
        
        return label
    }()
    
    var startButton: UIButton = {
       let button = UIButton()
        button.setTitle(Strings.startGame, for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(startButtonWasPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc func startButtonWasPressed(sender : UIButton) {
        start(game)
    }
    
    func start(_ game: Game) {
        present(UINavigationController(rootViewController: GameViewController(game: game, currentPlayer: currentPlayer)), animated: true) {}
    }
    
}
