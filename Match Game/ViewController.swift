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
    
        
    var firstFlippedCardIndex : IndexPath?
    var timer : Timer?
    var milliseconds: Float = 30 * 1000 // 30 sec
    
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
           

           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
           

           let card = cardArray[indexPath.row]
           

           cell.setCard(card)
           
                   return cell
           
       }
       
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
             
             if milliseconds <= 0 {
                 return
             }
             
            let cell =  collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
             
             let card = cardArray[indexPath.row]
             
             if card.isFliped == false && card.isMatched == false {

                 cell.flip()
                 card.isFliped = true
                 if firstFlippedCardIndex == nil {

                     firstFlippedCardIndex = indexPath
                 } else {
                     
                     checkForMatches(indexPath)
                 }
             }
             
             
         } //Engding of didSelectItem method.
         
    
         func checkForMatches(_ secondFlippedCardIndex: IndexPath){

             let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
             
             let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
             

             let cardOne = cardArray[firstFlippedCardIndex!.row]
             let cardTwo = cardArray[secondFlippedCardIndex.row]

            if cardOne.imageName == cardTwo.imageName {
           
             cardOne.isMatched = true
             cardTwo.isMatched = true
             
             cardOneCell?.remove()
             cardTwoCell?.remove()
             
             ckeckGameEnded()
             
             }
             else {
             cardOne.isFliped = false
             cardTwo.isFliped = false
                 
             cardOneCell?.flipBack()
             cardTwoCell?.flipBack()
                 
             }

             if cardOneCell == nil {
                 collectionView.reloadItems(at: [firstFlippedCardIndex!])
             }

             firstFlippedCardIndex = nil
         }
         func ckeckGameEnded() {
             
             var isWon = true
             
             for card in cardArray {
                 
                 if card.isMatched == false {
                     isWon = false
                     break
                 }
             }

             if isWon == true {
                 
                 if milliseconds > 0{
                     timer?.invalidate()
                 }

                 
             } else {
                 if milliseconds > 0 {
                     return
                 }
             }
         }

}

