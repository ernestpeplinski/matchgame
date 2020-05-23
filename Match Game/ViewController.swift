//
//  ViewController.swift
//  Match Game
//
//  Created by Student on 23/05/2020.
//  Copyright © 2020 ernest.patryk.memory.game. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    

    @IBOutlet weak var collectionView: UICollectionView!
    var model = CardModule()
    var cardArray = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardArray = model.getCard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
           return cardArray.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
           
           // get a cardCollectionViewCell object
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
           
           //Get the card that the colletion view is trying to display
           let card = cardArray[indexPath.row]
           
           
           //set that card for the cell
           cell.setCard(card)
           
                   return cell
           
       }
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let cell =  collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        let card = cardArray[indexPath.row]
        if card.isFliped == false {
            cell.flip()
            card.isFliped = true
         }else{
            cell.flipBack()
            card.isFliped = false
            
        }
        } //Engding of didSelectItem method.
}

