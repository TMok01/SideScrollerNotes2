//
//  GameScene.swift
//  SideScrollerNotes
//
//  Created by TYLER MOK on 2/22/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var hello = ""
    var cam = SKCameraNode()
    var score = 0
    
    
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        // making an outlet for the ball on the screen
        ball = self.childNode(withName: "ball") as? SKSpriteNode
        
        
        // making an outlet for the label on screen
        scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
        scoreLabel.text = "\(score)"
        
        
        // connecting Xcode's camera var to our cam var
        self.camera = cam
    }
   
   // function gets called when contact happens
    func didBegin(_ contact: SKPhysicsContact) {
        print("hit")
        
        let restartAction = SKAction.move(to: CGPoint(x: -480, y: 50), duration: 0.0)
        ball.run(restartAction)
        
        // adding 1 to score when the ball hits only the coin
        if (contact.bodyA.node?.name == "ball" && contact.bodyB.node?.name == "coin") || (contact.bodyB.node?.name == "ball" && contact.bodyA.node?.name == "coin")  {
            score = score + 1
            scoreLabel.text = "\(score)"
            if contact.bodyA.node?.name == "coin" {
                contact.bodyA.node?.removeFromParent()
                ball.physicsBody?.velocity.dx = 500
            }
            if contact.bodyB.node?.name == "coin" {
                contact.bodyB.node?.removeFromParent()
                ball.physicsBody?.velocity.dx = 500
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        cam.position.x = ball.position.x
        cam.position.y = ball.position.y - 50
        scoreLabel.position.x = cam.position.x + 500
        scoreLabel.position.y = cam.position.y + 225
        ball.physicsBody?.velocity.dx = 500
        
        if ball.position.y < -480 {
           respawn()
        }
    }
    
    func respawn() {
        ball.position.x = -480
        ball.position.y = 50
    }
    
    
    func jump() {
        ball.physicsBody?.velocity.dy = 500
    }
}
