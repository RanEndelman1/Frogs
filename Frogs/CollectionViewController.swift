//
//  CollectionViewController.swift
//  Frogs
//
//  Created by Ran Endelman on 11/08/2017.
//  Copyright © 2017 RanEndelman. All rights reserved.
//

import UIKit


class CollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "cell"
    private let numberOfCells = 15
    private let numOfSections = 1
    private var score = 0
    private var hits = 3
    private var counter = 60
    private var timer: Timer?
    private var timerForChangeBackgroundImages: Timer?

    @IBOutlet weak var gameTitle: UINavigationItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)

        timerForChangeBackgroundImages = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(changeBackgroundImage), userInfo: nil, repeats: true)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /* This method determine number of Sections in the CollectionView */
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numOfSections
    }

    /* This method determine number of Cell's in the CollectionView */
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return numberOfCells
    }

    /* This method initialize all the CollectionView Cell's */
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
        } else {
            cell.alpha = 99
        }
        return cell
    }

    /* This method initialize the CollectionView Header and Footer */
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {

        case UICollectionElementKindSectionHeader:

            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            return headerView

        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
            return footerView

        default:
            assert(false, "Unexpected element kind")
        }
    }

    /* This method handle click on cell event */
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFrogPic(collectionView: collectionView, indexPath: indexPath) {
            score += 1
            let header = collectionView.supplementaryView(forElementKind: UICollectionElementKindSectionHeader, at: indexPath)
            let scoreLabel = collectionView.viewWithTag(1) as! UILabel
            scoreLabel.text = "Score: \(score)"

//            scoreBoard.text = "The score is :" + String(score)
        } else {
            hits -= 1
            if hits > -1 {
                let hitsLabel = collectionView.viewWithTag(2) as! UILabel
                hitsLabel.text = "Hits: \(hits)"
            }
            if hits < 0 {
                showEndOfGameAlert(title: "Game Over! You are out of Hits!")
            }
        }
        print("The score is :" + String(score))
        print("The hits is :" + String(hits))
    }

    /* This method return back to the root viewController */
    func finishGame() {
        self.dismiss(animated: true)
    }

    /* This method called by timer count down the time for the game */
    func updateCounter() {
        if hits < 0 {
            stopTimers()
        }
        if counter >= 0 {
            print("00:\(counter)")
            if counter == 60 {
                gameTitle.title = "01:00"
            } else if counter < 10 {
                gameTitle.title = "00:0\(counter)"
            } else {
                gameTitle.title = "00:\(counter)"
            }
            counter -= 1
        } else {
            print("OUT OF TIME!")
            stopTimers()
            showEndOfGameAlert(title: "You are out of time!")
        }
    }

    /* This method generate and show no more hits alert */
    func showEndOfGameAlert(title: String) {
        let alert = UIAlertController(title: title, message: "Your score is: \(score)", preferredStyle: UIAlertControllerStyle.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (alert: UIAlertAction!) in self.finishGame() })
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }

    /* This method determine if the cell clicked contain frog image */
    func isFrogPic(collectionView: UICollectionView, indexPath: IndexPath) -> Bool {
        return collectionView.cellForItem(at: indexPath)?.alpha == 100
    }

    /* This method change all the Cell's background image, called by timerForChangeBackgroundImages */
    func changeBackgroundImage() {
        if counter <= 0 || hits < 0 {
            stopTimers()
        }
        for cell in collectionView?.visibleCells as! [UICollectionViewCell] {
            var random_number = Int(arc4random_uniform(12) + 1)
            let image = UIImage(named: String(random_number) + ".jpg")
            let imageView = UIImageView(image: image!)
            imageView.image = image
            cell.backgroundView = imageView
            // To determine if it is a frog pic
            if random_number <= 4 {
                cell.alpha = 100
            } else {
                cell.alpha = 99
            }
        }
        print("Changed background")
    }

    /* This method stop the two timers */
    func stopTimers() {
        timer?.invalidate()
        timer = nil
        timerForChangeBackgroundImages?.invalidate()
        timerForChangeBackgroundImages = nil
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
