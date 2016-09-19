//
//  MontyEngine.swift
//  Monty
//
//  Created by Jason Gresh on 9/13/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation


class MontyBrain {
    let numCards: Int
    
    init(numCards:Int){
        self.numCards = numCards
        setupCards()
    }
    
    fileprivate enum State{
        case hit
        case miss
    }
    
    private var cards = [State]()
    
    func randomNumber() -> Int {
        let num = Int(arc4random_uniform(UInt32(numCards)))
        return num
        
    }
    
    
    func checkForVerticalEdges(ship: Int, randomNum: Int) -> Bool {
        var counter = 0
        var check = false
        for i in 0..<ship {
            if randomNum + 10 * i >= 90 {
                counter += 1
            }
            else {
                continue
            }
        }
        if counter >= 1 {
            check = false
        }
        else {
            check = true
        }
        return check
        
    }
    
    
    func checkForHorizontalEdges(ship: Int, randomNum: Int) -> Bool {
        var counter = 0
        var check = false
        for i in 0..<ship {
            if randomNum % 10 + i >= 9 {
                counter += 1
            }
            else {
                continue
            }
        }
        if counter >= 1 {
            check = false
        }
        else {
            check = true
        }
        return check
    }
    
    func fillTheShipHorizontally(ship: Int) {
        var rand = randomNumber()
        if checkForHorizontalEdges(ship: ship, randomNum: rand) {
            inner: for _ in 0..<ship {
                if cards[rand] != .hit {
                    cards[rand] = .hit
                    rand += 1
                }
                else {
                    rand = randomNumber()
                    continue inner
                }
                
            }
        }
        else {
            inner: for _ in 0..<ship {
                if cards[rand] != .hit {
                    cards[rand] = .hit
                    rand -= 1
                }
                else {
                    rand = randomNumber()
                    continue inner
                }
                
            }
        }
        
    }
    
    func fillTheShipVertically (ship: Int) {
        var rand = randomNumber()
        if checkForVerticalEdges(ship: ship, randomNum: rand) {
            inner: for _ in 0..<ship {
                if cards[rand] != .hit {
                    cards[rand] = .hit
                    rand += 10
                }
                else {
                    rand = randomNumber()
                    continue inner
                }
            }
        }
        else {
            inner: for _ in 0..<ship {
                if cards[rand] != .hit {
                    cards[rand] = .hit
                    rand -= 10
                }
                else {
                    rand = randomNumber()
                    continue inner
                }
            }
        }
        
    }
    
    func randomPicker(ship: Int) {
        let num = Int(arc4random_uniform(UInt32(2)))
        if num == 1 {
            fillTheShipHorizontally(ship: ship)
        }
        else {
            fillTheShipVertically(ship: ship)
        }
    }
    
    func setupCards(){
        cards = Array(repeating: .miss, count: numCards)
        
        randomPicker(ship: 5)
        randomPicker(ship: 4)
        randomPicker(ship: 3)
        randomPicker(ship: 3)
        randomPicker(ship: 2)
    }
    
    func checkCard(_ cardIn: Int) -> Bool{
        assert(cardIn < cards.count)  //helps with debugging
        return cards[cardIn] == .hit
    }
    
}
