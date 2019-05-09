//
//  ViewController.swift
//  dafttap-challange
//
//  Created by Bartosz Cybulski on 09/05/2019.
//  Copyright © 2019 Bartosz Cybulski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func playButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showGameView", sender: sender)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameView" {
            let gameViewController : GameViewController
            gameViewController = segue.destination as! GameViewController
//            gameViewController.testLabel.text! = "dsa"
        }
    }
}

