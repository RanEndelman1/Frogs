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
        self.tableView.center = self.view.center
        self.view.addSubview(self.tableView)
        self.tableView.backgroundColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /* This override method return number of rows in the records table */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.recordsArr == nil {
            return 1
        } else {
            return self.recordsArr.count
        }
    }

    /* This override method set the text for each row in the records table */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mycell")
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.green
        if self.recordsArr == nil {
            cell.textLabel!.text = ""
        } else {
            var currDic: [String: Any] = recordsArr[indexPath.row]
            cell.textLabel!.text = "\(indexPath.row + 1). " + "\(currDic["score"]!)" + " Points By: " + "\(currDic["name"]!)"
        }

        return cell
    }

    /* This method get the records list from the FireBase */
    func getRecordsDic() {
        self.ref.child("highScores").observeSingleEvent(of: .value, with: { (snapshot) in
            self.recordsArr = snapshot.value as? [[String: Any]]
            self.tableView.reloadData()
        })
    }

    /* This override method handle click on row in the records table */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.clickedRow = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)

    }

    /* This method prepare the segue for the map view of specific record */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if clickedRow != -1 {
            var mapViewController = segue.destination as! MapViewController
            mapViewController.clickedRow = self.clickedRow
        }
    }
}
