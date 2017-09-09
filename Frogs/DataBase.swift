//
// Created by Ran Endelman on 01/09/2017.
// Copyright (c) 2017 RanEndelman. All rights reserved.
//

import FirebaseDatabase
import Foundation


class DataBase {
    var ref: DatabaseReference!
    var recordsDic: [String: String]!

    init() {
        self.ref = Database.database().reference()
        self.getRecordsDic()

    }


    /* This method insert the score to the scores top 10 table in FireBase DB */
    func insertScore(score: String, name: String) {
        getRecordsListAndInsert(score: score, name: name)
    }

    /* This method get the records list from the FireBase DB */
    func getRecordsListAndInsert(score: String, name: String) {
        self.ref.child("highScores").observeSingleEvent(of: .value, with: { (snapshot) in
            var dic = snapshot.value as? [String: String]
            if dic![score] == nil {
                dic![score] = name
            } else {
                var oldName = dic![score]
                dic![score] = oldName! + ", " + name
            }
            self.ref.child("highScores").setValue(dic)

        }) { (error) in
            print(error.localizedDescription)
        }
    }

//    func getRecordsDic() {
//        self.ref.child("highScores").observeSingleEvent(of: .value, with: { (snapshot) in
//            var dic = snapshot.value as? [String: String]
//            self.recordsDic = dic
//
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }

    func getRecordsDic() {
        var counter = 0
        self.ref.child("highScores").observeSingleEvent(of: .value, with: { (snapshot) in
            var dic = snapshot.value as? [String: String]
            self.recordsDic = dic

        })

    }
}
