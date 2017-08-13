//
//  CollectionViewCellHeader.swift
//  Frogs
//
//  Created by Ran Endelman on 12/08/2017.
//  Copyright © 2017 RanEndelman. All rights reserved.
//

import UIKit

class CollectionViewCellHeader: UICollectionViewCell {

    @IBOutlet weak var scoreLabel: UILabel!

    func initScore() {
        scoreLabel.text = "0"
    }

    func increaseScore() {
        var currScore = Int(scoreLabel.text!)
//        scoreLabel.text = (currScore! + 1)

    }

    func reduceScore() {
        var currScore = Int(scoreLabel.text!)
//        scoreLabel.text = (currScore! - 1)

    }
}
