//
//  GamePlay.swift
//  FruitEater
//
//  Created by punyawee  on 9/8/61.
//  Copyright © พ.ศ. 2561 Punyugi. All rights reserved.
//

import UIKit
import SpriteKit

class GamePlay: SKScene {
    var playerController: Player?
    var goPoint: CGPoint?
    
    override func didMove(to view: SKView) {
        initGame()
    }
    private func initGame() {
        playerController = childNode(withName: "Player") as? Player
        playerController?.position = CGPoint(x: self.frame.midX, y: 70)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if
            let location = touches.first?.location(in: self),
            let playerController = playerController
        {
            playerController.move(to: CGPoint(x: location.x, y: playerController.position.y))
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if
            let location = touches.first?.location(in: self),
            let playerController = playerController
        {
            playerController.move(to: CGPoint(x: location.x, y: playerController.position.y))
        }
    }
}
