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

    private var recordsArr: [[String: Any]]!
    private var ref: DatabaseReference!
    private var sortedKeys: Array<String> = []
    private var sortedKeysInt: Array<Int> = []
    private var clickedRow: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        getRecordsDic()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.recordsArr == nil {
            return 1
        } else {
            return self.recordsArr.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mycell")

        if self.recordsArr == nil {
            cell.textLabel!.text = ""
        } else {
//            var currKey = "\(sortedKeysInt[indexPath.row])"
//            var player = self.recordsDic?[currKey] as? String
            var currDic: [String: Any] = recordsArr[indexPath.row]
            cell.textLabel!.text = "\(indexPath.row + 1). " + "\(currDic["score"]!)" + " Points By: " + "\(currDic["name"]!)"
        }

        return cell
    }

    func getRecordsDic() {
        self.ref.child("highScores").observeSingleEvent(of: .value, with: { (snapshot) in
            self.recordsArr = snapshot.value as? [[String: Any]]
            self.tableView.reloadData()
        })

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let newView: MapViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
//        self.present(newView, animated: true, completion: nil)
        self.clickedRow = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
        var mapViewController = segue.destination as! MapViewController
        mapViewController.clickedRow = self.clickedRow
    }
}
