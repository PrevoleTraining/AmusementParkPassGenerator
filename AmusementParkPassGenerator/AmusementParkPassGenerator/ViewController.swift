//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 08.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    var entrants: [Entrantable]
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()
    
    lazy var entrantMapping: [UIButton: Entrantable] = {
        return [
            self.classicGuestButton: findEntrant(category: .guest, subCategory: .classic),
            self.vipGuestButton: findEntrant(category: .guest, subCategory: .vip),
            self.childGuestButton: findEntrant(category: .guest, subCategory: .child),
            self.hourlyFoodButton: findEntrant(category: .employee, subCategory: .hourlyFood),
            self.hourlyRideButton: findEntrant(category: .employee, subCategory: .hourlyRide),
            self.hourlyMaintenanceButton: findEntrant(category: .employee, subCategory: .hourlyMaintenance),
            self.managerButton: findEntrant(category: .employee, subCategory: .manager)
        ]
    }()
    
    lazy var people: [UIButton: Personable] = {
        func createPerson(entrant: Entrantable, first: String, last: String, street: String, city: String, zip: String, state: String, birthDate: Date? = nil) -> Person {
            return Person(pass: Pass(accesses: entrant.accesses!), firstName: first, lastName: last, street: street, city: city, state: state, zipCode: zip, birthDate: birthDate)
        }
        
        return [
            self.classicGuestButton: createPerson(
                entrant: entrantMapping[self.classicGuestButton]!, first: "John", last: "Doe", street: "Main Street", city: "San Diego", zip: "12345", state: "CA"),
            self.vipGuestButton: createPerson(
                entrant: entrantMapping[self.vipGuestButton]!,  first: "Jane", last: "Doe", street: "Cross Road", city: "Santa Clara", zip: "23456", state: "CA"),
            self.childGuestButton: createPerson(
                entrant: entrantMapping[self.childGuestButton]!, first: "Jason", last: "Doe", street: "Infinite Loop", city: "Santa Monica", zip: "34567", state: "CA", birthDate: dateFormatter.date(from: "2015/11/25")),
            self.hourlyFoodButton: createPerson(
                entrant: entrantMapping[self.hourlyFoodButton]!, first: "Alice", last: "Tree", street: "Down Hill", city: "Mountain View", zip: "45678", state: "CA"),
            self.hourlyRideButton: createPerson(
                entrant: entrantMapping[self.hourlyRideButton]!, first: "Bob", last: "Bridge", street: "Treehouse", city: "Cupertino", zip: "56789", state: "CA"),
            self.hourlyMaintenanceButton: createPerson(
                entrant: entrantMapping[self.hourlyMaintenanceButton]!, first: "Charlie", last: "Apolo", street: "Loop Drive", city: "San Francisco", zip: "67890", state: "CA"),
            self.managerButton: createPerson(
                entrant: entrantMapping[self.managerButton]!, first: "Dave", last: "Hal", street: "Spaceship", city: "Los Angeles", zip: "78901", state: "CA")
        ]
    }()
    
    lazy var checkPoints: [UIButton: Checkpointable] = {
        return [
            amusementAccessButton: AreaCheckpoint(access: .amusement),
            kitcherAccessButton: AreaCheckpoint(access: .kitchen),
            rideAccessButton: AreaCheckpoint(access: .rideControl),
            maintenanceAccessButton: AreaCheckpoint(access: .maintenance),
            officeAccessButton: AreaCheckpoint(access: .office),
            allRidesAccessButton: RideCheckpoint(access: .allRides),
            skipRideLinesAccessButton: RideCheckpoint(access: .skipRideLines),
            foodAccessButton: DiscountCheckpoint(access: .food(discount: 0)),
            merchandiseAccessButton: DiscountCheckpoint(access: .merchandise(discount: 0))
        ]
    }()
    
    @IBOutlet weak var classicGuestButton: UIButton!
    @IBOutlet weak var vipGuestButton: UIButton!
    @IBOutlet weak var childGuestButton: UIButton!
    @IBOutlet weak var hourlyFoodButton: UIButton!
    @IBOutlet weak var hourlyRideButton: UIButton!
    @IBOutlet weak var hourlyMaintenanceButton: UIButton!
    @IBOutlet weak var managerButton: UIButton!
    
    @IBOutlet weak var amusementAccessButton: UIButton!
    @IBOutlet weak var kitcherAccessButton: UIButton!
    @IBOutlet weak var rideAccessButton: UIButton!
    @IBOutlet weak var maintenanceAccessButton: UIButton!
    @IBOutlet weak var officeAccessButton: UIButton!
    
    @IBOutlet weak var allRidesAccessButton: UIButton!
    @IBOutlet weak var skipRideLinesAccessButton: UIButton!
    
    @IBOutlet weak var foodAccessButton: UIButton!
    @IBOutlet weak var merchandiseAccessButton: UIButton!
    
    @IBOutlet weak var entrantCreationSwitch: UISwitch!
    @IBOutlet weak var birthdateProvidedSwitch: UISwitch!
    
    @IBOutlet weak var accessStackView: UIStackView!
    
    @IBOutlet weak var checkResults: UITextView!
    
    var currentEntrant: UIButton?
    
    required init?(coder aDecoder: NSCoder) {
        do {
            let array = try PlistConverter.array(fromFile: "entrants", ofType: "plist")
            entrants = try EntrantableUnarchiver.entrants(fromArray: array)
            print(entrants)
        } catch let error {
            fatalError("\(error)")
        }
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchGuest(_ sender: UIButton) {
        if let previousEntrant = currentEntrant {
            previousEntrant.backgroundColor = .white
        }

        currentEntrant = sender
        currentEntrant?.backgroundColor = .cyan
        
        if entrantCreationSwitch.isOn {
            if let entrant = entrantMapping[sender] {
                if let personalInfo = entrant.personalInfo {
                    let validationErrors = PersonalInfo.validate(person: Person(pass: Pass(accesses: [])), personalInfo: personalInfo)

                    if validationErrors.isEmpty {
                        checkResults.text = "Entrant can be created. All personal info are present"
                    } else {
                        var message = ""
                        
                        for singleError in validationErrors {
                            message.append("\(singleError.description())\n")
                        }
                        
                        checkResults.text = message
                    }
                } else {
                    checkResults.text = "No personal data required"
                }
            }
        } else {
            checkResults.text = people[sender]?.description
        }
    }
    
    @IBAction func accessCheck(_ sender: UIButton) {
        if let entrant = currentEntrant {
            if let checkPoint = checkPoints[sender], let person = people[entrant] {
                let previousBirthDate = person.pass.birthDate
                
                if birthdateProvidedSwitch.isOn {
                    (person.pass as! Pass).birthDate = Date()
                }
                
                let result = checkPoint.swipeWithBirthdayCheck(pass: person.pass)
                
                (person.pass as! Pass).birthDate = previousBirthDate
                
                var message = "\(person.description)\n\(result.description)\n"
                
                for singleMessage in result.messages {
                    message.append("\(singleMessage)\n")
                }
                
                checkResults.text = message
            }
        } else {
            checkResults.text = "You must first select an entrant"
        }
    }
    
    @IBAction func entrantCreationMode(_ sender: UISwitch) {
        if sender.isOn {
            birthdateProvidedSwitch.isOn = false
            accessStackView.isHidden = true
        } else {
            accessStackView.isHidden = false
        }
    }
    
    
    @IBAction func birthDateProvidedMode(_ sender: UISwitch) {
        if sender.isOn {
            entrantCreationSwitch.isOn = false
            accessStackView.isHidden = false
        }
    }
    
    func findEntrant(category: EntrantCategory, subCategory: EntrantSubCategory) -> Entrantable {
        let foundEntrants = self.entrants.filter { $0.category == category && $0.subCategory == subCategory }
        return foundEntrants.first!
    }
}

