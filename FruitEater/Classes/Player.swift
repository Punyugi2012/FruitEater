//
//  Player.swift
//  FruitEater
//
//  Created by punyawee  on 9/8/61.
//  Copyright © พ.ศ. 2561 Punyugi. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    func move(to: CGPoint?) {
        if let to = to {
            let moveAction = SKAction.move(to: to, duration: 0)
            run(moveAction)
        }
    }
    
}
