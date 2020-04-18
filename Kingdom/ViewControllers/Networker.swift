//
//  Networker.swift
//  Kingdom
//
//  Created by Justin Haddadnia on 4/18/20.
//  Copyright © 2020 Justin Haddadnia. All rights reserved.
//

import Foundation

class Networker {

    //testing with the version which isn't ready for a JSON object
    static func addPlayer(name1: String) {
        guard let url = URL(string: "http://localhost:8080/addPlayer1") else {
            assertionFailure("add Player URL is messed up")
            return
        }
        var request = URLRequest(url: url)
        
        let json: [String: Any] = ["name": name1]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

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
    
//fixup
    static func addPlayer(name: String) {
        guard let url = URL(string: "http://localhost:8080/addPlayer") else {
            assertionFailure("add Player URL is messed up")
            return
        }
        let json: [String: Any] = ["name": name]
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
