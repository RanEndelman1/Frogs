//
// Created by Ran Endelman on 01/09/2017.
// Copyright (c) 2017 RanEndelman. All rights reserved.
//

import FirebaseDatabase
import Foundation


class DataBase {
    var ref: DatabaseReference!
    var recordsArr: [[String: Any]]!

    init() {
        self.ref = Database.database().reference()

    }

    /* This method insert the score to the scores top 10 table in FireBase DB */
    func insertScore(score: Int, name: String, long: Double, lat: Double) {
        getRecordsListAndInsert(score: score, name: name, long: long, lat: lat)
    }

    /* This method get the records list from the FireBase DB */
    func getRecordsListAndInsert(score: Int, name: String, long: Double, lat: Double) {
        self.ref.child("highScores").observeSingleEvent(of: .value, with: { (snapshot) in
            var arr = snapshot.value as? [[String: Any]]
            var record = Record(score: score, name: name, long: long, lat: lat)
            if arr!.count < 10 {
                arr!.append(record.dict)
                self.ref.child("highScores").setValue(arr)
            } else {
                var sortedArr = arr!.sorted(by: { ($0["score"] as! Int) > ($1["score"] as! Int) })
                var lastDic: [String: Any] = sortedArr[9]
                if (lastDic["score"] as! Int) < score {
                    sortedArr.append(record.dict)
                    sortedArr = sortedArr.sorted(by: { ($0["score"] as! Int) > ($1["score"] as! Int) })
                    sortedArr.remove(at: 10)
                    self.ref.child("highScores").setValue(sortedArr)
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }

}
