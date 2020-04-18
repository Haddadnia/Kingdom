//
//  FirstViewController.swift
//  Kingdom
//
//  Created by Justin Haddadnia on 4/16/20.
//  Copyright © 2020 Justin Haddadnia. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Layout

        view.addAndCenter(views: [welcomeLabel,
                                  codeTextField,
                                  nameTextField,
                                  wordTextField,
                                  submitButton])
        
        welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        welcomeLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        codeTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 180).isActive = true
        codeTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 60).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        wordTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30).isActive = true
        wordTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        
        submitButton.topAnchor.constraint(equalTo: wordTextField.bottomAnchor, constant: 80).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
        
    // MARK - UI Elements
    var welcomeLabel: UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.backgroundColor = UIColor.orange
        welcomeLabel.text = Strings.welcomeToKingdom
        return welcomeLabel
    }()
    
    var codeTextField: UITextField = {
        let codeTextField = UITextField()
        codeTextField.placeholder = Strings.enterYourGameCode
        return codeTextField
    }()
    var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.placeholder = Strings.enterYourName
        return nameTextField
    }()
    var wordTextField: UITextField = {
        let wordTextField = UITextField()
        wordTextField.placeholder = Strings.enterYourWord
        return wordTextField
    }()
    
    var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle(Strings.submit, for: .normal)
        button.addTarget(self, action: #selector(submitButtonWasPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    //Button Presses
    @objc func submitButtonWasPressed(sender : UIButton) {
        // submit to server
        // get game back
        presentLobby(game: testGame1)
    }
    
    func presentLobby(game: Game) {
        guard let name = nameTextField.text,
            let word = wordTextField.text else {
            return //TODO add in error
        }
        // HACKS
        let currentPlayer = Player(name: name, word: word)

        present(UINavigationController(rootViewController: LobbyViewController(game: game, currentPlayer: currentPlayer, delegate: self)), animated: true) {}
    }
    
    
}

extension FirstViewController: LobbyViewControllerDelegate {
    func lobbyviewControllerDidFinish() {
        dismiss(animated: true) {}
    }
}


