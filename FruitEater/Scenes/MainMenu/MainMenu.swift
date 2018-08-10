//
//  MainMenu.swift
//  FruitEater
//
//  Created by punyawee  on 9/8/61.
//  Copyright © พ.ศ. 2561 Punyugi. All rights reserved.
//

import UIKit
import SpriteKit

let highScoreKey = "HighScoreKey"

class MainMenu: SKScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if nodes(at: touch.location(in: self)).first?.name == "StartButton" {
                if let gamePlayScene = GamePlay(fileNamed: "GamePlay") {
                    view!.presentScene(gamePlayScene)
                }
            }
        }
    }
    override func didMove(to view: SKView) {
        self.size = view.frame.size
        if let backgroundNode = childNode(withName: "Background") as? SKSpriteNode {
            backgroundNode.size = view.frame.size
        }
        if let highScore = childNode(withName: "HighScore") as? SKLabelNode {
            highScore.text = "\(UserDefaults.standard.integer(forKey: highScoreKey))"
        }
    }
}
