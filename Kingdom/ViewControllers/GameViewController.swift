//
//  GameViewController.swift
//  Kingdom
//
//  Created by Justin Haddadnia on 4/17/20.
//  Copyright © 2020 Justin Haddadnia. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    //MARK - properties
    var game: Game
    let currentPlayer: Player
    
    var guessedPlayer: Player?
    
    let pickerView = UIPickerView()
    
    
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
        
        title = Strings.gameName
        view.backgroundColor = UIColor.white
        
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        pickerView.dataSource = self
        
        view.addAndCenter(views: [yourWordLabel, yourTeammatesLabel, topLabel, wordTextField, submitButton])
        yourWordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        yourWordLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        yourTeammatesLabel.topAnchor.constraint(equalTo: yourWordLabel.bottomAnchor, constant: 50).isActive = true
        yourTeammatesLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        topLabel.topAnchor.constraint(equalTo: yourTeammatesLabel.bottomAnchor, constant: 50).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        wordTextField.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 60).isActive = true
        wordTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        submitButton.topAnchor.constraint(equalTo: wordTextField.bottomAnchor, constant: 60).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        layoutPickerView()
        reload(with: game)
    }
    
    func layoutPickerView() {
        view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pickerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pickerView.topAnchor.constraint(greaterThanOrEqualTo: submitButton.bottomAnchor).isActive = true
        pickerView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        showPicker()
    }
    
    lazy var yourWordLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.yourWordIsSpace + currentPlayer.word
        return label
    }()
    
    lazy var yourTeammatesLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var wordTextField: UITextField = {
        let wordTextField = UITextField()
        wordTextField.placeholder = Strings.enterYourGuess
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
        if game.guessingPlayer.name != currentPlayer.name {
            showToast(Strings.notYourTurn)
        } else {
            //submit to server, get new game back     //create a different state
            reload(with: testGame2)
        }
        
        reload(with: testGame2)
    }
    
    func reload(with game: Game) {
        self.game = game
        setTopLabelTextFor(game: game)
        setTeammatesLabelFor(game: game)
    }
    
    func showPicker() {
        pickerView.isHidden = false
    }
    func hidePicker() {
        pickerView.isHidden = true
    }
}

extension GameViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var playersMinusMe = game.players
        playersMinusMe.removeAll{$0.name == currentPlayer.name}
        guessedPlayer = playersMinusMe[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var playersMinusMe = game.players
        playersMinusMe.removeAll{$0.name == currentPlayer.name}
        return playersMinusMe[row].name // Fix this
    }
}
extension GameViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return game.players.count - 1
    }
    
}

extension GameViewController {
    func setTopLabelTextFor(game: Game) {
        if game.guessingPlayer.name == currentPlayer.name {
            topLabel.text = Strings.yourTurn
        } else {
            topLabel.text = Strings.waitingForSpace + game.guessingPlayer.name + Strings.spaceToGuess
        }
    }
    func setTeammatesLabelFor(game: Game) {
        var myTeam: Team?
        for team in game.teams {
            if myTeam != nil {
                break
            }
            for player in team.players {
                if player.name == currentPlayer.name {
                    myTeam = team
                    break
                }
            }
        }
        guard let t = myTeam else {
            yourTeammatesLabel.text = "You alone sucka"
            return
        }
        var myTeammatesNames = ""
        for player in t.players {
            if player.name != currentPlayer.name {
                myTeammatesNames = myTeammatesNames + player.name + ", "
            }
        }
        yourTeammatesLabel.text = Strings.yourTeammatesAre + myTeammatesNames
    }
}
