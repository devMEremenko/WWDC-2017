//
//  WWBubbleBuilder.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/30/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWBubbleBuilder: NSObject {
    
    static let kWWBublesThingsCount = 10
    static let kWWBublesAlarmCount = 5

    static func bubbles() -> [WWBubbleNode] {
        
        var bubbles = [WWBubbleNode]()
        bubbles.append(contentsOf: alarmBubles(count: kWWBublesAlarmCount))
        bubbles.append(contentsOf: thingsBubles(count: kWWBublesThingsCount))
        
        return bubbles
    }
    
    
    static func alarmBubles(count: Int) -> [WWBubbleNode] {
        
        var nodes = [WWBubbleNode]()
        
        for _ in 0 ..< count {
            
            let bubble = bubbleForType(type: .Alarm)
            
            if let bubble = bubble {
                nodes.append(bubble)
            }
        }
        
        return nodes
    }
    
    static func thingsBubles(count: Int) -> [WWBubbleNode] {
        
        var nodes = [WWBubbleNode]()
        
        for _ in 0 ..< count {
            let bubble = randomBubble()
            
            if let bubble = bubble {
                nodes.append(bubble)
            }
        }
        
        return nodes
    }
    
    static func randomBubble() -> WWBubbleNode? {
        
        let count = WWBubleType.Count.rawValue
        let randomIndex = Int(arc4random_uniform(UInt32(count - 1)) + 1)
        let bubbleType = WWBubleType(rawValue: randomIndex)
        
        return bubbleForType(type: bubbleType!)
    }
    
    static func bubbleForType(type: WWBubleType) -> WWBubbleNode? {
        
        var node : WWBubbleNode?
        
        switch type {
            case .Alarm:
                
                let title = "Alarm"
                let image = UIImage(named: "alarm")
                let color = WWColorTheme.reddishPink()
                let radius : CGFloat = 40.0
                node = WWBubbleNode(title: title, image: image, color: color, radius: radius)
                node?.type = .Alarm
                break
            
            case .Radio:
                
                let title = "Photo"
                let image = UIImage(named: "photo_camera")
                let color = WWColorTheme.skyBlue()
                let radius : CGFloat = 30.0
                node = WWBubbleNode(title: title, image: image, color: color, radius: radius)
                node?.type = .Radio
                break
            
            case .Door:
            
                let title = "Radio"
                let image = UIImage(named: "radio")
                let color = WWColorTheme.marigold()
                let radius : CGFloat = 20.0
                node = WWBubbleNode(title: title, image: image, color: color, radius: radius)
                node?.type = .Door
                break
            
            default: break
        }
        
        return node
    }
    
    func randomColor() -> UIColor? {
        
        return nil
    }
    
    func randomSide() -> CGFloat? {
        
        return nil
    }
}
