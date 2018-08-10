//
//  GamePlay.swift
//  FruitEater
//
//  Created by punyawee  on 9/8/61.
//  Copyright © พ.ศ. 2561 Punyugi. All rights reserved.
//

import UIKit
import SpriteKit

class GamePlay: SKScene, SKPhysicsContactDelegate {
    
    var playerController: Player?
    var goPoint: CGPoint?
    var speedGame: TimeInterval = 2
    var counter = 0
    var speedGameDetecter: Timer?
    var itemOutOfBoundDetecter: Timer?
    var scoreLabel: SKLabelNode?
    var score = 0
    var highScore: SKLabelNode?
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        initGame()
        self.size = view.frame.size
    }
    
    private func initGame() {
        playerController = childNode(withName: "Player") as? Player
        if let playerController = playerController {
            playerController.position = CGPoint(x: self.frame.midX, y: 70)
            playerController.physicsBody = SKPhysicsBody(circleOfRadius: playerController.size.height / 2)
            playerController.physicsBody?.categoryBitMask = ColliderType.player
            playerController.physicsBody?.contactTestBitMask = ColliderType.fruit_and_boom
            playerController.physicsBody?.affectedByGravity = false
            playerController.physicsBody?.isDynamic = false
        }
        speedGameDetecter = Timer.scheduledTimer(timeInterval: speedGame, target: self, selector: #selector(spawnItem), userInfo: nil, repeats: true)
        itemOutOfBoundDetecter = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(removeItemForOutOfBound), userInfo: self, repeats: true)
        scoreLabel = childNode(withName: "ScoreLabel") as? SKLabelNode
        scoreLabel?.text = "\(score)"
        scoreLabel?.position = CGPoint(x: self.frame.minX + 50, y: self.frame.maxY - 50)
        let highScoreLabel = childNode(withName: "HighScoreLabel") as? SKLabelNode
        highScoreLabel?.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.maxY - 50)
        highScore = childNode(withName: "HighScore") as? SKLabelNode
        highScore?.text = "\(UserDefaults.standard.integer(forKey: highScoreKey))"
        highScore?.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.maxY - 100)
        
        if let backgroundNode = childNode(withName: "Background") as? SKSpriteNode {
            backgroundNode.size = view!.bounds.size
        }
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
            speedGameDetecter?.invalidate()
            speedGameDetecter = Timer.scheduledTimer(timeInterval: speedGame, target: self, selector: #selector(spawnItem), userInfo: nil, repeats: true)
        }
        else if counter >= 20 {
            speedGame = 0.5
            speedGameDetecter?.invalidate()
            speedGameDetecter = Timer.scheduledTimer(timeInterval: speedGame, target: self, selector: #selector(spawnItem), userInfo: nil, repeats: true)
        }
        else if counter >= 10 {
            speedGame = 1
            speedGameDetecter?.invalidate()
            speedGameDetecter = Timer.scheduledTimer(timeInterval: speedGame, target: self, selector: #selector(spawnItem), userInfo: nil, repeats: true)
        }
        let item = ItemManager.getItem(minX: self.frame.minX, maxX: self.frame.maxX)
        addChild(item)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "Banana" {
            score += 1
            scoreLabel?.text = "\(score)"
            if score > UserDefaults.standard.integer(forKey: highScoreKey) {
                UserDefaults.standard.set(score, forKey: highScoreKey)
                highScore?.text = "\(score)"
               
            }
            contact.bodyB.node?.removeFromParent()
        }
        else if contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "Boom" {
            if let finishPlayScene = FinishPlay(fileNamed: "FinishPlay") {
                finishPlayScene.getScore = score
                view!.presentScene(finishPlayScene)
            }
        }
    }
    
    @objc func removeItemForOutOfBound() {
        for child in children {
            if child.position.y < self.frame.minY {
                child.removeFromParent()
                print("out of bound removed")
            }
        }
    }
    
}
