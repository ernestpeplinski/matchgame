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
    @IBOutlet weak var timerLabel: UILabel!
    var milliseconds: Float = 30 * 1000 // 30 sec
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardArray = model.getCard()
        collectionView.delegate = self
        collectionView.dataSource = self
        
                timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    //Mark : Timer Mathods
    @objc func timerElapsed(){
        
        milliseconds -= 1
        
       let seconds = String(format:"%.2f", milliseconds/1000)
      
        timerLabel.text = "time Remaining: \(seconds)"
        
        if milliseconds <= 0 {
            
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            checkGameEnded()
        }
        
        
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
             
             checkGameEnded()
             
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
         func checkGameEnded() {
             
             var isWon = true
             
             for card in cardArray {
                 
                 if card.isMatched == false {
                     isWon = false
                     break
                 }
             }
            var title = ""
            var message = ""
            
             if isWon == true {
                 
                 if milliseconds > 0{
                     timer?.invalidate()
                 }
                title = "Congrarulations!"
                message  = "You`ve Won"
             } else {
                 if milliseconds > 0 {
                     return
                 }
                
                title = "Game Over"
                message = "You`ve Lost"
                
            }
            
                    showAlert(title, message)
            
    }
    
        func showAlert(_ title : String, _ message : String){
        //Show won/lost messaging
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)

        
    }
}

