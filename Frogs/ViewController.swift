//
//  ViewController.swift
//  Frogs
//
//  Created by Ran Endelman on 11/08/2017.
//  Copyright (c) 2017 RanEndelman. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var lastScoreLabel: UILabel!

    private var usersImage: UIImage?

    private var key: String = "LASTSCORE"

    @IBAction func uploadPicButton(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLastScore()
        // Do any additional setup after loading the view, typically from a nib.
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.jpg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.usersImage = image
        }
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGameSegue" {
            var collectionViewController = segue.destination as! CollectionViewController
            collectionViewController.usersImage = self.usersImage
        }
    }

    /* This method get the user last score */
    func setLastScore() {
        let defaults = UserDefaults.standard
        var lastScore = defaults.integer(forKey: self.key)
        if lastScore != nil {
           lastScoreLabel.text = "Your last score was: \(lastScore)"
        }
    }
}
