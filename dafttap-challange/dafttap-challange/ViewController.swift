//
//  ViewController.swift
//  dafttap-challange
//
//  Created by Bartosz Cybulski on 09/05/2019.
//  Copyright © 2019 Bartosz Cybulski. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var recordsCollectionView: UICollectionView!
    private let reuseIdentifier = "RecordCell"
    private let numberOfClicksKey = "numberOfClicks"
    private let gameTimeKey = "gameTime"
    private var recordsDataSource : RecordsDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCollectionView()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        recordsDataSource = RecordsDataSource(context: context)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recordsDataSource.fetchData()
        recordsDataSource.sortData()
        self.recordsCollectionView?.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let flowLayout = self.recordsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: self.recordsCollectionView.bounds.width, height: (self.recordsCollectionView.bounds.height / 5) - 10)
        }
    }

    @IBAction private func playButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showGameView", sender: sender)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameView" {
            let gameViewController : GameViewController
            gameViewController = segue.destination as! GameViewController
            gameViewController.recordsDataSource = recordsDataSource
        }
    }
    
    private func setUpCollectionView(){
        
        recordsCollectionView.dataSource = self
        recordsCollectionView.delegate = self
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recordsDataSource.records.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? RecordCollectionViewCell else {
            return RecordCollectionViewCell()
        }
        let record = recordsDataSource.records[indexPath.row]
        let clicks = record.value(forKeyPath: numberOfClicksKey) as! Int
        let date = record.value(forKeyPath: gameTimeKey) as! String

        cell.label.text = "[\(indexPath.row + 1)].Cliks: \(clicks), timestamp: \(date)"
        cell.backgroundColor = .white
        cell.label.textColor = .green
        
        return cell
    }
    

}

