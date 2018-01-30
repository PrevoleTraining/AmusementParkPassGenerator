//
//  ValidationErrorViewController.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 25.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import UIKit

/**
 * Controller to show the validation errors or generic error
 */
class ValidationErrorViewController: UIViewController {

    @IBOutlet weak var textErrorArea: UITextView!
    
    // The validation errors or a simple message
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
    
    /**
     * Close the error popup
     */
    @IBAction func dismissPopup(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UI Helpers
    
    /**
     * Show the errors in the popup
     *
     * - parameter errors: The errors to show
     */
    func showErrors(errors: [PersonalInfo: [PersonalInfoError]]) {
        var completeMessage = ""
        
        // Format the errors and simplify some errors
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
