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
    
    private var clickCounter = ClickCounter()
    private var gameTimer : Timer!
    private var gameTimeLeft : Double!
    private var prepareTimer : Timer!
    private var prepareTimeLeft : Double!
    var recordsDataSource : RecordsDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clicksLabel.text = "0"
        timerLabel.text = ""
        setUpPrepareTimer()
    }
    
   private func setupTapGestureRecognizer(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_ : )))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setUpGameTimer(){
        gameTimer = Timer.scheduledTimer(timeInterval: 0.01 , target: self, selector: #selector(onTimeEnds), userInfo: nil, repeats: true)
        gameTimeLeft = 5.00
    }
    
    private func setUpPrepareTimer(){
        prepareTimer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(onPrepareTime), userInfo: nil, repeats: true)
        prepareTimeLeft = 3.00
    }
    
    private func setUpAlert(){
        if clickCounter.click >= recordsDataSource.getLowestRecordValue() || (recordsDataSource.records.count < 5 && clickCounter.click != 0 ) {
            let title = "New highscore!"
            let message = "You tapped the screen \(clickCounter.click) times.\nYour score will be displayed in record's table."
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ action in
                self.navigationController?.popViewController(animated: true)
            }))
            recordsDataSource.saveData(numberOfClicks: clickCounter.click, gameTime: clickCounter.timeStamp)
            self.present(alert, animated: true)
        }
        else {
            let title = "Time's up!"
            let message = "You tapped the screen \(clickCounter.click) times."
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ action in
                    self.navigationController?.popViewController(animated: true)
                }))
        
            self.present(alert, animated: true)
        }
    }
    
     @objc private func onTimeEnds(){
        gameTimeLeft -= 0.01
        timerLabel.text = (String(format:"%.2f", gameTimeLeft!)) + " seconds left !"
        
        if gameTimeLeft <= 0{
            timerLabel.text = "0.00 seconds left !"
            gameTimer.invalidate()
            setUpAlert()
        }
    }
    
    @objc private func onPrepareTime(){
        prepareTimeLeft -= 0.15
        clicksLabel.text? = (String(format:"%.0f", prepareTimeLeft!)) + "..."
        
        if 0 < prepareTimeLeft && prepareTimeLeft <= 1.00 {
            clicksLabel.text = "PLAY!"
        }
        else if prepareTimeLeft <= 0{
            prepareTimer.invalidate()
            clicksLabel.text = "0"
            setupTapGestureRecognizer()
            setUpGameTimer()
        }
    }
    
    @objc private func handleTap(_ tap : UITapGestureRecognizer){
        if gameTimeLeft > 0.00 {
            clicksLabel.text = String(clickCounter.increaseClicksByOne())
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        prepareTimer.invalidate()
        gameTimer?.invalidate()
    }
}
