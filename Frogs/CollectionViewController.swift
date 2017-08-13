//
//  CollectionViewController.swift
//  Frogs
//
//  Created by Ran Endelman on 11/08/2017.
//  Copyright © 2017 RanEndelman. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"
private let numberOfCells = 15
private let numOfSections = 1
private let cvch = CollectionViewCellHeader()
private var score = 0
private var hits = 3
private var counter = 60

class CollectionViewController: UICollectionViewController {

    @IBOutlet weak var gameTitle: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
//        initScore()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    func updateCounter() {
        if counter > 0 {
            print("00:\(counter)")
            if counter == 60 {
                gameTitle.title = "01:00"
            }
            else {
                gameTitle.title = "00:\(counter)"
            }
            counter -= 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numOfSections
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return numberOfCells
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as UICollectionViewCell
        var random_number = Int(arc4random_uniform(12) + 1)
        let image = UIImage(named: String(random_number) + ".jpg")
        let imageView = UIImageView(image: image!)
        imageView.image = image
        cell.backgroundView = imageView
        // To determine if it is a frog pic
        if random_number <= 4 {
            cell.alpha = 100
        }
        else {
            cell.alpha = 99
        }
        return cell
    }


    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFrogPic(collectionView: collectionView, indexPath: indexPath) {
            score += 1
        }
        else {
            hits -= 1
        }
        print("The score is :" + String(score))
        print("The hits is :" + String(hits))
    }

    func isFrogPic(collectionView: UICollectionView, indexPath: IndexPath) -> Bool {
        return collectionView.cellForItem(at: indexPath)?.alpha == 100
    }

    // MARK: UICollectionViewDelegate


    // Uncomment this method to specify if the specified item should be highlighted during tracking
//    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    // Uncomment this method to specify if the specified item should be selected
//    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {

    }
    */
}
