//
//  ViewController.swift
//  Match Game
//
//  Created by Student on 23/05/2020.
//  Copyright © 2020 ernest.patryk.memory.game. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var model = CardModule()
    var cardArray = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray = model.getCard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

