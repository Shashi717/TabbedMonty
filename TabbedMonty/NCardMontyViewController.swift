//
//  NCardMontyViewController.swift
//  TabbedMonty
//
//  Created by The TEAM on 9/16/16.
//  Copyright © 2016 C4Q. All rights reserved.
//


import UIKit

class NCardMontyViewController: UIViewController {
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var buttonContainer: UIView!
    
    let howManyCards: Int
    
    let brain: MontyBrain
    var loaded: Bool
    let resetTitle = "Reset"
    var counter = 0
    
    
    required init?(coder aDecoder: NSCoder) {
        self.howManyCards = 100
        self.loaded = false
        self.brain = MontyBrain(numCards: self.howManyCards)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        if !loaded {
            setUpGameButtons(v: buttonContainer, totalButtons: self.howManyCards, buttonsPerRow: 10)
            self.view.setNeedsDisplay()
        }
        loaded = true
    }
    
    func resetButtonColors() {
        for v in buttonContainer.subviews {
            if let button = v as? UIButton {
                button.backgroundColor = UIColor.cyan
                button.isEnabled = true
            }
        }
    }
    
    func handleReset() {
        brain.setupCards()
        setUpGameLabel()
        resetButtonColors()
        counter = 0
    }
    
    func disableCardButtons() {
        for v in buttonContainer.subviews {
            if let button = v as? UIButton {
                button.isEnabled = false
            }
        }
    }
    
    @IBAction func resetTapped(_ sender: UIButton) {
        handleReset()
    }
    
    func buttonTapped(_ sender: UIButton) {
        gameLabel.text = sender.currentTitle
        
        if brain.checkCard(sender.tag - 1) {
            
            gameLabel.text = "It's a Hit"
            counter += 1
            sender.backgroundColor = UIColor.lightGray
            sender.isEnabled = false
            
            if counter == 17 {
                gameLabel.text = "You got all the hits! You Win!"
                disableCardButtons()
            }
        }
        else {
            gameLabel.text = "Miss"
            sender.backgroundColor = UIColor.red
        }
    }
    
    
    func setUpResetButton() {
        let resetRect = CGRect(x: 10, y: 300, width: 60, height: 40)
        let resetButton = UIButton(frame: resetRect)
        resetButton.setTitle(resetTitle, for: UIControlState())
        resetButton.backgroundColor = UIColor.darkGray
        resetButton.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        view.addSubview(resetButton)
    }
    
    func setUpGameLabel() {
        gameLabel.text = "Let's Play!"
    }
    
    func setUpGameButtons(v: UIView, totalButtons: Int, buttonsPerRow : Int) {
        for i in 1...howManyCards {
            let y = ((i - 1) / buttonsPerRow)
            let x = ((i - 1) % buttonsPerRow)
            let side : CGFloat = v.bounds.size.width / CGFloat(buttonsPerRow)
            
            let rect = CGRect(origin: CGPoint(x: side * CGFloat(x), y: (CGFloat(y) * side)), size: CGSize(width: side, height: side))
            let button = UIButton(frame: rect)
            button.tag = i
            button.backgroundColor = UIColor.cyan
            button.setTitle(String(i), for: UIControlState())
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            v.addSubview(button)
        }
        
        setUpGameLabel()
    }
}

