//
//  MainMenu.swift
//  FruitEater
//
//  Created by punyawee  on 9/8/61.
//  Copyright © พ.ศ. 2561 Punyugi. All rights reserved.
//

import UIKit
import SpriteKit

class MainMenu: SKScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if nodes(at: touch.location(in: self)).first?.name == "StartButton" {
                if let gamePlayScene = GamePlay(fileNamed: "GamePlay") {
                    view!.presentScene(gamePlayScene, transition: .crossFade(withDuration: 0.5))
                }
            }
        }
    }
}
