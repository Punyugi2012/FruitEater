//
//  ItemManager.swift
//  FruitEater
//
//  Created by punyawee  on 9/8/61.
//  Copyright © พ.ศ. 2561 Punyugi. All rights reserved.
//

import SpriteKit

class ItemManager {
    static func randomBetweenNumbers(first: CGFloat, second: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(first - second) + min(first, second)
    }
    static func getItem(minX: CGFloat, maxX: CGFloat) -> SKSpriteNode {
        var item: SKSpriteNode
        let randomNumber = Int(randomBetweenNumbers(first: 1, second: 10))
        if randomNumber >= 5 {
            item = SKSpriteNode(imageNamed: "boom")
        }
        else {
            item = SKSpriteNode(imageNamed: "banana")
        }
        item.size = CGSize(width: 40, height: 40)
        item.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        item.physicsBody = SKPhysicsBody(circleOfRadius: item.size.height / 2)
        item.physicsBody?.categoryBitMask = ColliderType.fruit_and_boom
        item.position = CGPoint(x: randomBetweenNumbers(first: minX + 1, second: maxX), y: UIScreen.main.bounds.height + 50)
        return item
    }
}
