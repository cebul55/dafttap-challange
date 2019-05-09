//
//  GameViewController.swift
//  dafttap-challange
//
//  Created by Bartosz Cybulski on 09/05/2019.
//  Copyright © 2019 Bartosz Cybulski. All rights reserved.
//

import Foundation
import UIKit

class GameViewController : UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var clicksLabel: UILabel!
    
    var clicks : Int!
    var timer : Timer!
    var timeLeft : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_ : )))
        view.addGestureRecognizer(tapGesture)
        setUpClicks()
        setUpTimer()
        // Do any additional setup after loading the view.
    }
    
    func setUpClicks(){
        clicks = 0
        clicksLabel.text = String(clicks!)
    }
    
    func setUpTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.01 , target: self, selector: #selector(onTimeEnds), userInfo: nil, repeats: true)
        timeLeft = 5.00
    }
    
    func setUpAlert(){
        //todo check if it qualifies for leaderboard and display different message
        let title = "Time's up!"
        let message = "You tapped the screen \(clicks!) times."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ action in
                self.navigationController?.popViewController(animated: true)
            }))
        
        self.present(alert, animated: true)
    }
    
    @objc func onTimeEnds(){
        timeLeft -= 0.01
        timerLabel.text = (String(format:"%.2f", timeLeft!)) + " seconds left !"
        
        if timeLeft <= 0{
            timerLabel.text = "0.00 seconds left !"
            timer.invalidate()
            setUpAlert()
        }
    }
    
    @objc func handleTap(_ tap : UITapGestureRecognizer){
        if timeLeft > 0.00 {
            clicks += 1
            clicksLabel.text = String(clicks!)
        }
    }
}
