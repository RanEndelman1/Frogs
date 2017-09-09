//
//  RecordsViewController.swift
//  Frogs
//
//  Created by Ran Endelman on 08/09/2017.
//  Copyright © 2017 RanEndelman. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RecordsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    private var recordsDic: [String: String]!
    private var ref: DatabaseReference!
    private var sortedKeys: Array<String> = []
    private var sortedKeysInt: Array<Int> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        getRecordsDic()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.recordsDic == nil {
            return 1
        } else {
            return self.recordsDic.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mycell")

        if self.recordsDic == nil {
            cell.textLabel!.text = ""
        } else {
            var currKey = "\(sortedKeysInt[indexPath.row])"
            var player = self.recordsDic?[currKey] as? String
            cell.textLabel!.text = "\(indexPath.row + 1). "  + currKey + " Points By: " + player!
        }

        return cell
    }

    func getRecordsDic() {
        self.ref.child("highScores").observeSingleEvent(of: .value, with: { (snapshot) in
            self.recordsDic = snapshot.value as? [String: String]
            var recordCount = self.recordsDic.count
            self.sortedKeysInt = [Int]()
            for (index, element) in Array(self.recordsDic.keys).enumerated() {
                self.sortedKeysInt.append(Int(element)!)
            }
            self.sortedKeysInt = self.sortedKeysInt.sorted(by: >)
            self.tableView.reloadData()
        })

    }

}
