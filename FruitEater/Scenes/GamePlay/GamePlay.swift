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
    var speedGame: TimeInterval = 2
    var counter = 0
    var timer: Timer?
    
    override func didMove(to view: SKView) {
        initGame()
    }
    
    private func initGame() {
        playerController = childNode(withName: "Player") as? Player
        playerController?.position = CGPoint(x: self.frame.midX, y: 70)
        timer = Timer.scheduledTimer(timeInterval: speedGame, target: self, selector: #selector(spawnItem), userInfo: nil, repeats: true)
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
  
    @objc func spawnItem() {
        counter += 1
        if counter >= 40 {
            speedGame = 0.2
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: speedGame, target: self, selector: #selector(spawnItem), userInfo: nil, repeats: true)
        }
        else if counter >= 20 {
            speedGame = 0.5
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: speedGame, target: self, selector: #selector(spawnItem), userInfo: nil, repeats: true)
        }
        else if counter >= 10 {
            speedGame = 1
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: speedGame, target: self, selector: #selector(spawnItem), userInfo: nil, repeats: true)
        }
        let item = ItemManager.getItem(minX: self.frame.minX, maxX: self.frame.maxX)
        addChild(item)
    }
    
}
