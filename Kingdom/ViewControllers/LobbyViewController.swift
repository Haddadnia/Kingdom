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
    var game: Game
    let currentPlayer: Player
    
    weak var delegate: LobbyViewControllerDelegate?
    
    
    // MARK - initializers
    init(game: Game, currentPlayer: Player, delegate: LobbyViewControllerDelegate) {
        self.game = game
        self.currentPlayer = currentPlayer
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        
        view.backgroundColor = UIColor.white
        
        view.addAndCenter(views: [topLabel, playersLabel, startButton])
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        playersLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 60).isActive = true
        playersLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        startButton.isHidden = !isCurrentPlayerTheHost()
        
        reloadFrom(game: game)
    }
    
    func reloadFrom(game: Game) {
        self.game = game
        setTopLabelText()
        setPlayersLabelText()
    }
    
    func showCancelWarning() {
        let alert = UIAlertController(title: Strings.areYouSureToLeave, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Strings.yes, style: .default, handler: { [weak self] (alertAction) in
            guard let delegate = self?.delegate else {
                assertionFailure("lost delegate")
                return
            }
            delegate.lobbyviewControllerDidFinish()
        }))
        alert.addAction(UIAlertAction(title: Strings.no, style: .cancel, handler: { (alertAction) in
            alert.dismiss(animated: true, completion: {})
        }))
        self.present(alert, animated: true)
    }
    
    @objc func cancelButtonTapped() {
        showCancelWarning()
    }
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    lazy var playersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
        guard let nav = navigationController else {
            assertionFailure("where the nav at bro?")
            return
        }
        nav.pushViewController(GameViewController(game: game, currentPlayer: currentPlayer), animated: true)
    }
}

// Helper
extension LobbyViewController {
    func isCurrentPlayerTheHost() -> Bool {
        return game.host.name == currentPlayer.name
    }
}

//MARK - text setting
extension LobbyViewController {
    func setTopLabelText() {
        if (game.host.name == currentPlayer.name) { //replace with a real check for me being host
            if (game.players.count < 2) {
                topLabel.text = Strings.playerWarning
            } else {
                topLabel.text = Strings.hostDirections
            }
        } else {
            topLabel.text = Strings.waitingForHost
        }
    }
    
    func setPlayersLabelText() {
        var text = Strings.players + "(" + String(game.players.count) + "): "
        for player in game.players {
            text = text + player.name + ", "
        }
        playersLabel.text = text
    }
}

