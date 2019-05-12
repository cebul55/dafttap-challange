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
    let reuseIdentifier = "RecordCell"
    //var records: [NSManagedObject] = []
    var recordsDataSource : RecordsDataSource!
    
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
        //recordsDataSource.fetchData()
        //recordsDataSource.saveData(numberOfClicks: 500, gameTime: Date())
        print("Print section")
        print(recordsDataSource.getLowestRecord())
        print(recordsDataSource.records)
    }

    @IBAction func playButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showGameView", sender: sender)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameView" {
            let gameViewController : GameViewController
            gameViewController = segue.destination as! GameViewController
            gameViewController.recordsDataSource = recordsDataSource
        }
    }
    
    func setUpCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        
        recordsCollectionView.dataSource = self
        recordsCollectionView.delegate = self
        recordsCollectionView.register(RecordCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recordsDataSource.records.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let record = recordsDataSource.records[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? RecordCollectionViewCell else {
            return RecordCollectionViewCell()
        }
        
        cell.label.text = record.value(forKeyPath:"gameTime") as? String
        
        return cell
    }
    
    
}

