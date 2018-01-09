//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 08.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let array = try PlistConverter.array(fromFile: "entrants", ofType: "plist")
            let entrants = try EntrantableUnarchiver.entrants(fromArray: array)
            print(entrants)
        } catch let error {
            fatalError("\(error)")
        }

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

