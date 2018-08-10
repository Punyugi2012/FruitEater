//
//  FinishPlay.swift
//  FruitEater
//
//  Created by punyawee  on 9/8/61.
//  Copyright © พ.ศ. 2561 Punyugi. All rights reserved.
//

import UIKit
import SpriteKit

class FinishPlay: SKScene {
    var getScore: Int?
    override func didMove(to view: SKView) {
        self.size = view.frame.size
        if let getScore = getScore {
            if let score = childNode(withName: "Score") as? SKLabelNode {
                score.text = "\(getScore)"
            }
        }
        if let highScore = childNode(withName: "HighScore") as? SKLabelNode {
            highScore.text = "\(UserDefaults.standard.integer(forKey: highScoreKey))"
        }
        if let backgroundNode = childNode(withName: "Background") as? SKSpriteNode {
            backgroundNode.size = view.frame.size
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if nodes(at: touch.location(in: self)).first?.name == "Replay" {
                if let gamePlayScene = GamePlay(fileNamed: "GamePlay") {
                    view!.presentScene(gamePlayScene)
                }
            }
            else if  nodes(at: touch.location(in: self)).first?.name == "Home" {
                if let mainMenuScene = MainMenu(fileNamed: "MainMenu") {
                    view!.presentScene(mainMenuScene)
                }
            }
        }
    }
}
