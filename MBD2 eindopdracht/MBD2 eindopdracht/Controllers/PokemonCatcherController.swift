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
    var pokemonsCaught: Array<String>!
    var pokemonCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: gameView)
        behavior = PokemonBehavior(in: animator)
        animator.addBehavior(behavior)
        pokemonCount = 0
        
        
        let emptyList : [String:Array<Int>] = ["nl.avans.pokemoncatcher.pokemons" : []]
        UserDefaults.standard.register(defaults: emptyList)
        pokemonsCaught = UserDefaults.standard.stringArray(forKey: "nl.avans.pokemoncatcher.pokemons")
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PokemonCatcherController.spawnNewPokemon), userInfo: nil, repeats: true)
        
//        print(gameView.bounds.size.width)
//        print(gameView.bounds.size.height)
    }
    
    @objc func spawnNewPokemon() {
        if(pokemonCount < 6) {
            pokemonCount += 1
            
            let pokemonID = Int.random(in: 1 ..< 152)
            PokemonApi.sharedInstance.getPokemonDetail(pokemonNumber: pokemonID, callback: self.displayPokemon)
        } else {
            let myViews = gameView.subviews.filter({$0 is PokemonView})
            behavior.push(myViews[Int.random(in: 0 ..< myViews.count)])
        }
    }
    
    func displayPokemon(pokemonData: PokemonData) {
        
        let x = Int.random(in: 0 ..< Int(gameView.bounds.size.width))
        let y = Int.random(in: 0 ..< Int(gameView.bounds.size.height))

        
        let frame = CGRect(x: 0, y:0, width:64, height: 64)
        let point = CGPoint(x: x, y:y)
        let pokemonView = PokemonView(frame: frame)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        
        
        pokemonView.pokemonData = pokemonData
        pokemonView.tapped = false
        pokemonView.center = point
        pokemonView.addGestureRecognizer(tap)
        
        let url = URL(string: pokemonData.sprites.front_default)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                
                var image = UIImage(data: data!)!
                UIGraphicsBeginImageContextWithOptions(CGSize(width: 64, height: 64), true, CGFloat(0.0))
                image.draw(in: frame)
                image = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                
                pokemonView.backgroundColor = UIColor(patternImage: image)
                self.gameView.addSubview(pokemonView)
                self.behavior.addItem(pokemonView)
                self.behavior.push(pokemonView)
            }
        }
        
        
    }
    
    @objc func tapped(gesture : UITapGestureRecognizer) {
        
        if let pokemonView = gesture.view! as? PokemonView {
            if(pokemonView.tapped == false) {
                pokemonView.tapped = true
                var text = ""
                
                if(pokemonsCaught.contains(String(pokemonView.pokemonData!.id))) {
                    text = "\(pokemonView.pokemonData.name) is al gevangen"
                } else {
                    text = "\(pokemonView.pokemonData.name) gevangen!"
                    pokemonsCaught.append(String(pokemonView.pokemonData!.id))
                    UserDefaults().set(pokemonsCaught, forKey: "nl.avans.pokemoncatcher.pokemons")
                }
                
                
                let animatedLabel = UILabel(frame: CGRect(x: 0, y:0, width:250, height: 40))
                animatedLabel.text = text
                animatedLabel.center = pokemonView.center
                animatedLabel.frame.origin.y += 80
                
                self.view.addSubview(animatedLabel)
                
                UIView.animate(withDuration: 2.0,
                               animations: {
                                    animatedLabel.frame.origin.y -= 100.0
                                    animatedLabel.alpha = 0.0
                                    pokemonView.alpha = 0.0},
                               completion: { finished in
                                    animatedLabel.removeFromSuperview()
                                    pokemonView.removeFromSuperview()
                                    self.behavior.removeItem(pokemonView)
                                    self.pokemonCount -= 1
                })
            }
        }
    }
    
    func getRandomColor() -> UIColor {
        switch(Int.random(in: 0 ..< 5)) {
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
        spawnNewPokemon()
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
