//
//  PokemonBehavior.swift
//  MBD2 eindopdracht
//
//  Created by Maurits van Leeuwen on 21/03/2019.
//  Copyright © 2019 Maurits van Leeuwen. All rights reserved.
//

import Foundation
import UIKit

class PokemonBehavior: UIDynamicBehavior
{
    lazy var collisionBehavior: UICollisionBehavior = {
        let collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        return collision
    }()
    
    var gravityBehavior: UIGravityBehavior = {
        let gravity = UIGravityBehavior()
        gravity.magnitude = 0
        return gravity
    }()
    
    lazy var itemBehavior: UIDynamicItemBehavior = {
        let item = UIDynamicItemBehavior()
        item.elasticity = 1.0
        item.resistance = 0
        return item
    }()
    
    func push(_ item: UIDynamicItem) {
        
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        
        push.angle = CGFloat(Double.random(in: 0 ..< Double.pi))
        push.magnitude = CGFloat(Int.random(in: 1 ..< 3))
        push.action = { [unowned push, weak self] in
            self?.removeChildBehavior(push)
        }
        
        addChildBehavior(push)
    }
    
    func addItem(_ item: UIDynamicItem) {
        collisionBehavior.addItem(item)
        itemBehavior.addItem(item)
        gravityBehavior.addItem(item)
    }
    
    func removeItem(_ item: UIDynamicItem) {
        collisionBehavior.removeItem(item)
        itemBehavior.removeItem(item)
        gravityBehavior.removeItem(item)
    }
    
    override init() {
        super.init()
        addChildBehavior(collisionBehavior)
        addChildBehavior(itemBehavior)
        addChildBehavior(gravityBehavior)
    }
    
    convenience init(in animator: UIDynamicAnimator) {
        self.init()
        animator.addBehavior(self)
    }
}
