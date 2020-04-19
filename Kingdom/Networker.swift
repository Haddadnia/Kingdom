//
//  Networker.swift
//  Kingdom
//
//  Created by Justin Haddadnia on 4/18/20.
//  Copyright © 2020 Justin Haddadnia. All rights reserved.
//

import Foundation

class Networker {

    static func addPlayer(_ player: Player, toGameCode: String?, completion: (Game?) -> Void) {
        guard let url = URL(string: "http://localhost:8080/addPlayer") else {
            assertionFailure("add Player URL is messed up")
            return
        }
        let json: [String: Any] = [
            "name": player.name,
            "word": player.word,
            "gameCode": toGameCode ?? ""
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }

        task.resume()
        
    }
}
