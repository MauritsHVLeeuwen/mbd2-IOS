//
//  PokemonCatcherController.swift
//  MBD2 eindopdracht
//
//  Created by Maurits van Leeuwen on 20/03/2019.
//  Copyright © 2019 Maurits van Leeuwen. All rights reserved.
//

import Foundation
import UIKit

class PokemonCatcherController: UIViewController {
    
    @IBOutlet weak var gameView: UIView!
    var animator: UIDynamicAnimator!
    var behavior: PokemonBehavior!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var item: UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: gameView)
        behavior = PokemonBehavior(in: animator)
        animator.addBehavior(behavior)
        
//        print(gameView.bounds.size.width)
//        print(gameView.bounds.size.height)
    }
    
    func spawnPokemon() {
        
        let x = Int.random(in: 0 ..< Int(gameView.bounds.size.width))
        let y = Int.random(in: 0 ..< Int(gameView.bounds.size.height))
        print(x)
        print(y)
        
        let frame = CGRect(x: 0, y:0, width:50, height: 50)
        let point = CGPoint(x: x, y:y)
        let pokemonView = PokemonView(frame: frame)
        pokemonView.center = point
        
        pokemonView.backgroundColor = getRandomColor()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        pokemonView.addGestureRecognizer(tap)
        pokemonView.pokemonID = 5
        
        gameView.addSubview(pokemonView)
        behavior.addItem(pokemonView)
        behavior.push(pokemonView)
    }
    
    @objc func tapped(gesture : UITapGestureRecognizer) {
        print("tapped")
        
        if let pokemonView = gesture.view! as? PokemonView {
            print(pokemonView.pokemonID)
        }
    }
    
    func getRandomColor() -> UIColor {
        switch(Int.random(in: 0 ..< 4)) {
        case 0:
            return UIColor.green
        case 1:
            return UIColor.blue
        case 2:
            return UIColor.orange
        case 3:
            return UIColor.red
        case 4:
            return UIColor.purple
        default:
            return UIColor.black
        }
    }
    
    @IBAction func clickTestButton(_ sender: Any) {
        spawnPokemon()
    }
    
    //    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
//        var text=""
//        switch UIDevice.current.orientation{
//        case .portrait:
//            text="Portrait"
//        case .portraitUpsideDown:
//            text="PortraitUpsideDown"
//        case .landscapeLeft:
//            text="LandscapeLeft"
//        case .landscapeRight:
//            text="LandscapeRight"
//        default:
//            text="Another"
//        }
//        print()
//    }
    
    
    
}
