//
//  Player.swift
//  FruitEater
//
//  Created by punyawee  on 9/8/61.
//  Copyright © พ.ศ. 2561 Punyugi. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    var playerSpeed = 0.01
    func move(to: CGPoint?) {
        if let to = to {
            let moveAction = SKAction.move(to: to, duration: playerSpeed)
            run(moveAction)
        }
    }
    
}
