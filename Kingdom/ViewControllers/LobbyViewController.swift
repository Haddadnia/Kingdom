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
        
        view.addAndCenter(views: [topLabel, startButton])
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        startButton.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 200).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
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
        guard let nav = navigationController else {
            assertionFailure("where the nav at bro?")
            return
        }
        nav.pushViewController(GameViewController(game: game, currentPlayer: currentPlayer), animated: true)
    }
}
