//
//  UIViewExtensions.swift
//  Kingdom
//
//  Created by Justin Haddadnia on 4/16/20.
//  Copyright © 2020 Justin Haddadnia. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    //TODO
    func pinAnchors(left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat, to view: UIView) {
        topAnchor.constraint(equalTo: view.topAnchor, constant: top)
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: left)
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: right)
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
    }
    
    func addAndCenter(views: [UIView]) {
        for view in views {
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
            view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
    }
}
