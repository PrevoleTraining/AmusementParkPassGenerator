//
//  PassTesterViewController.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 27.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import UIKit

/**
 * The controller for the UI which allow to test a Pass
 */
class PassTesterViewController: UIViewController {
    @IBOutlet weak var faceImage: UIImageView!
    @IBOutlet weak var descriptionDataView: UIView!
    @IBOutlet weak var descriptionHoleView: UIView!
    
    @IBOutlet weak var areaAccessButton: UIButton!
    @IBOutlet weak var rideAccessButton: UIButton!
    @IBOutlet weak var discountAccessButton: UIButton!
    @IBOutlet weak var createNewPassButton: UIButton!
    
    @IBOutlet weak var firstLastNamesLabel: UILabel!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var accessesTextArea: UITextView!
    
    @IBOutlet weak var accessResultsTextArea: UITextView!
    
    // The simulator to test the pass on various check points
    let simulator: CheckpointSimulator = CheckpointSimulator()
    
    // The person and its pass
    var person: Personable?
    var pass: Pass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        populateData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions
    
    /**
     * Back to the main screen
     */
    @IBAction func createNewPass(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /**
     * Verification of the area accesses
     */
    @IBAction func checkAreaAccesses(_ sender: Any) {
        if let person = person {
            showSwipeResults(results: simulator.testAreaCheckpoints(pass: person.pass))
        }
    }
    
    /**
     * Verification of the ride accesses
     */
    @IBAction func checkRideAccesses(_ sender: Any) {
        if let person = person {
            showSwipeResults(results: simulator.testRideCheckpoints(pass: person.pass))
        }
    }
    
    /**
     * Verification of the discount accesses
     */
    @IBAction func checkDiscountAccesses(_ sender: Any) {
        if let person = person {
            showSwipeResults(results: simulator.testDiscountCheckpoints(pass: person.pass))
        }
    }
    
    // MARK: - UI Helpers
    
    /**
     * Prepare the UI
     */
    func setup() {
        accessResultsTextArea.addFullInnerShadow()
        descriptionHoleView.addTopInnerShadow()
    }
    
    /**
     * Populate the data in the UI
     */
    func populateData() {
        if let person = person {
            let firstLastName = "\(person.firstName ?? "Unknown") \(person.lastName ?? "")".trimmingCharacters(in: CharacterSet(charactersIn: " "))

            if firstLastName.isEmpty {
                firstLastNamesLabel.text = "GUEST"
            } else {
                firstLastNamesLabel.text = firstLastName
            }
            
            if let subCategory = person.pass.subCategory {
                passTypeLabel.text = "\(person.pass.category.description()) \(subCategory.description())"
            } else {
                passTypeLabel.text = "\(person.pass.category.description())"
            }
            
            accessesTextArea.text = person.pass.accesses.reduce("", { (memo, access) -> String in
                return memo + "• \(access.description())\n"
            })
        }
    }
    
    /**
     * Show swipe accesses
     *
     * - parameter results: The results of the swipe
     */
    func showSwipeResults(results: [String: SwipeResult]) {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString()

        for (name, result) in results {
            var color: UIColor
            
            switch result.status {
            case .granted, .grantedForDiscount: color = ApplicationColor.simulatorGreenText.value
            case .denied: color = ApplicationColor.simulatorRedText.value
            }

            let nameAttribues: [NSAttributedStringKey: Any] = [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: color]
            let messagesAttributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: color]
            attributedString.append(NSMutableAttributedString(string: name, attributes: nameAttribues))
            attributedString.append(NSMutableAttributedString(string: ": \(result.description)\n", attributes: messagesAttributes))
        }

        accessResultsTextArea.attributedText = attributedString
    }
}
