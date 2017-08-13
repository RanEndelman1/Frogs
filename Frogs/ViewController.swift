//
//  ViewController.swift
//  Frogs
//
//  Created by Ran Endelman on 11/08/2017.
//  Copyright (c) 2017 RanEndelman. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.jpg")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }


    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }



}
