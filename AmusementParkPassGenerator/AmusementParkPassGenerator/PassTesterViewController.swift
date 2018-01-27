//
//  PassTesterViewController.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 27.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import UIKit

class PassTesterViewController: UIViewController {

    var person: Personable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func createNewPass(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
