//
//  ValidationErrorViewController.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 25.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import UIKit

class ValidationErrorViewController: UIViewController {

    @IBOutlet weak var textErrorArea: UITextView!
    
    var errors: [PersonalInfo: [PersonalInfoError]]?
    var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let errors = errors {
            showErrors(errors: errors)
        } else if let message = message {
            textErrorArea.text = message
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissPopup(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UI Helpers
    func showErrors(errors: [PersonalInfo: [PersonalInfoError]]) {
        var completeMessage = ""
        
        for (key, errorMessages) in errors {
            completeMessage += "\(key.description())\n"
            
            for message in errorMessages {
                switch message {
                case .blankError:
                    completeMessage += " - \(message.description())\n"
                default:
                    if !errorMessages.contains(where: { $0 == PersonalInfoError.blankError }) {
                        completeMessage += " - \(message.description())\n"
                    }
                }
            }
            
            completeMessage += "\n"
        }

        textErrorArea.text = completeMessage
    }
}
