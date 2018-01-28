//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 22.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Stacks
    
    @IBOutlet weak var categoryButtonsStackView: UIStackView!
    @IBOutlet weak var subCategoryButtonsStackView: UIStackView!
    
    // MARK: - Inputs
    
    @IBOutlet weak var birthDateTextInput: UITextField!
    @IBOutlet weak var ssnTextInput: UITextField!
    @IBOutlet weak var projectNumberTextInput: UITextField!
    @IBOutlet weak var firstNameTextInput: UITextField!
    @IBOutlet weak var lastNameTextInput: UITextField!
    @IBOutlet weak var companyTextInput: UITextField!
    @IBOutlet weak var streetTextInput: UITextField!
    @IBOutlet weak var cityTextInput: UITextField!
    @IBOutlet weak var stateTextInput: UITextField!
    @IBOutlet weak var zipCodeTextInput: UITextField!
    @IBOutlet weak var managementTierTextInput: UITextField!
    @IBOutlet weak var visitDateTextInput: UITextField!
    
    // MARK: - Labels
    
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var ssnLabel: UILabel!
    @IBOutlet weak var projectNumberLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var managementTierLabel: UILabel!
    @IBOutlet weak var visitDateLabel: UILabel!
    
    // MARK: - Attributes
    
    lazy var labelFields: [PersonalInfo: LabelAndField] = {
        return [
            .birthDate: LabelAndField(field: birthDateTextInput, label: birthDateLabel),
            .birthDateJunior: LabelAndField(field: birthDateTextInput, label: birthDateLabel),
            .birthDateSenior: LabelAndField(field: birthDateTextInput, label: birthDateLabel),
            .ssn: LabelAndField(field: ssnTextInput, label: ssnLabel),
            .project: LabelAndField(field: projectNumberTextInput, label: projectNumberLabel),
            .firstName: LabelAndField(field: firstNameTextInput, label: firstNameLabel),
            .lastName: LabelAndField(field: lastNameTextInput, label: lastNameLabel),
            .vendor: LabelAndField(field: companyTextInput, label: companyLabel),
            .street: LabelAndField(field: streetTextInput, label: streetLabel),
            .city: LabelAndField(field: cityTextInput, label: cityLabel),
            .state: LabelAndField(field: stateTextInput, label: stateLabel),
            .zip: LabelAndField(field: zipCodeTextInput, label: zipCodeLabel),
            .managementTier: LabelAndField(field: managementTierTextInput, label: managementTierLabel),
            .visitDate: LabelAndField(field: visitDateTextInput, label: visitDateLabel)
        ]
    }()
    
    lazy var categoryButtons: [CategoryButton] = {
        return createCategoryButtons(for: dataProvider.categories)
    }()
    
    lazy var subCategoryButtons: [SubCategoryButton] = {
        return createSubCategoryButtons(for: dataProvider.subCategories())
    }()
    
    var dataProvider: DataProvider
    
    lazy var currentCategoryButton: ButtonState<CategoryButton> = {
        return ButtonState<CategoryButton>(
            color: ApplicationColor.categoryButtonText.value,
            highlightColor: ApplicationColor.categoryHighlight.value,
            buttons: categoryButtons,
            currentButton: nil
        )
    }()
    
    lazy var currentSubCategoryButton: ButtonState<SubCategoryButton> = {
        return ButtonState<SubCategoryButton>(
            color: ApplicationColor.subCategoryButtonText.value,
            highlightColor: ApplicationColor.subCategoryHighlight.value,
            buttons: subCategoryButtons,
            currentButton: nil
        )
    }()
    
    var currentPerson: Personable?
    
    required init?(coder aDecoder: NSCoder) {
        dataProvider = DataProvider()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialCategoryButton = categoryButtons[0]

        for categoryButton in categoryButtons {
            categoryButtonsStackView.addArrangedSubview(categoryButton.button)
        }
        
        for subCategoryButton in subCategoryButtons {
            subCategoryButtonsStackView.addArrangedSubview(subCategoryButton.button)
        }
        
        chooseCategory(initialCategoryButton.button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let passTesterViewController = segue.destination as? PassTesterViewController {
            passTesterViewController.person = currentPerson
        }
    }
    
    // MARK: - UI Logic
    func managePersonalInfo() {
        let entrant: Entrantable? = findEntrant()

        for (_, labelField) in labelFields {
            labelField.isEnabled = false
        }
        
        if let entrant = entrant, let personalInfoCollection = entrant.personalInfo {
            for personalInfo in personalInfoCollection {
                if let labelButton = labelFields[personalInfo] {
                    labelButton.isEnabled = true
                }
            }
        }
    }
    
    // MARK: - UI Actions
    @objc func chooseCategory(_ sender: UIButton) {
        currentCategoryButton.handle(button: sender)
        
        if let category = currentCategoryButton.currentButton?.category {
            var subCategoryButtonsForCategory: [SubCategoryButton] = []
            for subCategoryButton in subCategoryButtons {
                if subCategoryButton.category == category {
                    subCategoryButtonsForCategory.append(subCategoryButton)
                    subCategoryButton.button.isHidden = false
                } else {
                    subCategoryButton.button.isHidden = true
                }
            }
            
            if subCategoryButtonsForCategory.count > 0 {
                subCategoryButtonsStackView.isHidden = false
                chooseSubCategory(subCategoryButtonsForCategory.first!.button)
            } else {
                subCategoryButtonsStackView.isHidden = true
                chooseSubCategory()
            }
        }
    }
    
    @objc func chooseSubCategory(_ sender: UIButton? = nil) {
        resetState()
        clearFields()
        currentSubCategoryButton.handle(button: sender)
        managePersonalInfo()
    }
    
    @IBAction func generatePass(_ sender: UIButton) {
        resetState()
        
        let entrant: Entrantable? = findEntrant()
        
        if let entrant = entrant, let accesses = entrant.accesses {
            let project: Project? = dataProvider.findProject(number: projectNumberTextInput.text)
            let vendor: Vendor? = dataProvider.findVendor(name: companyTextInput.text)
            
            let pass = Pass(accesses: accesses, categoryAndSubCategory: entrant.categoryAndSubCategory, areaRestrictedEntrantables: [project, vendor])
            let person = Person(pass: pass)
            
            person.firstName = firstNameTextInput.text
            person.lastName = lastNameTextInput.text
            person.street = streetTextInput.text
            person.city = cityTextInput.text
            person.state = stateTextInput.text
            person.zipCode = zipCodeTextInput.text
            person.birthDate = Date.parse(date: birthDateTextInput.text)
            person.ssn = ssnTextInput.text
            person.project = project
            person.vendor = vendor
            person.visitDate = Date.parse(date: visitDateTextInput.text)
            
            if let managementTier = managementTierTextInput.text {
                person.managementTier = ManagementTier(rawValue: managementTier)
            }
            
            if isValid(person: person, personalInfo: entrant.personalInfo) {
                for (_, field) in labelFields {
                    field.clear()
                }
                
                currentPerson = person
                
                performSegue(withIdentifier: "showPassTester", sender: nil)
            }
        } else {
            openPopup(message: "Unknown error, ask your App's Developer")
        }
    }
    
    @IBAction func populate(_ sender: UIButton) {
        if let samplePerson = findSamplePerson() {
            firstNameTextInput.text = samplePerson.firstName
            lastNameTextInput.text = samplePerson.lastName
            streetTextInput.text = samplePerson.street
            cityTextInput.text = samplePerson.city
            stateTextInput.text = samplePerson.state
            zipCodeTextInput.text = samplePerson.zipCode
            birthDateTextInput.text = samplePerson.birthDate
            ssnTextInput.text = samplePerson.ssn
            projectNumberTextInput.text = samplePerson.project
            companyTextInput.text = samplePerson.vendor
            visitDateTextInput.text = samplePerson.visitDate
            managementTierTextInput.text = samplePerson.managementTier
        }
    }
    
    // MARK: - UI Builders
    
    func createCategoryButtons(for categories: [EntrantCategory]) -> [CategoryButton] {
        return categories.map {
            return CategoryButton(category: $0, button: UIButton(
                text: $0.description(),
                selector: #selector(self.chooseCategory),
                target: self,
                backgroundColor: ApplicationColor.categoryButton.value,
                titleColor: ApplicationColor.categoryButtonText.value
            ))
        }
    }
    
    func createSubCategoryButtons(for subCategories: [EntrantSubCategory]) -> [SubCategoryButton] {
        return subCategories.map {
            return SubCategoryButton(category: $0.category(), subCategory: $0, button: UIButton(
                text: $0.description(),
                selector: #selector(self.chooseSubCategory),
                target: self,
                backgroundColor: ApplicationColor.subCategoryButton.value,
                titleColor: ApplicationColor.subCategoryButtonText.value
            ))
        }
    }
    
    func resetState() {
        currentPerson = nil
        
        for (_, field) in labelFields {
            field.reset()
        }
    }
    
    func clearFields() {
        for (_, field) in labelFields {
            field.clear()
        }
    }

    func isValid(person: Personable, personalInfo: [PersonalInfo]?) -> Bool {
        if let personalInfo = personalInfo {
            let errors = PersonalInfo.validate(person: person, personalInfo: personalInfo)
            
            if !errors.isEmpty {
                errors.forEach { (key: PersonalInfo, value: [PersonalInfoError]) in
                    if let field = labelFields[key] {
                        field.inError()
                    }
                }

                openPopup(errors: errors)

                return false
            }
        }
        
        return true
    }

    func openPopup(errors: [PersonalInfo: [PersonalInfoError]]? = nil, message: String? = nil) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popup = storyboard.instantiateViewController(withIdentifier: "validationErrorView") as! ValidationErrorViewController
        
        popup.modalPresentationStyle = .overFullScreen
        popup.modalTransitionStyle = .crossDissolve

        popup.errors = errors
        popup.message = message
        
        self.present(popup, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func findEntrant() -> Entrantable? {
        if let subCategoryButton = currentSubCategoryButton.currentButton {
            return dataProvider.findEntrantFor(category: subCategoryButton.category, subCategory: subCategoryButton.subCategory)
        } else if let categoryButton = currentCategoryButton.currentButton {
            return dataProvider.findEntrantFor(category: categoryButton.category)
        } else {
            return nil
        }
    }

    func findSamplePerson() -> PopulationInfo? {
        if let subCategoryButton = currentSubCategoryButton.currentButton {
            return dataProvider.population.findBy(category: subCategoryButton.category, subCategory: subCategoryButton.subCategory)
        } else if let categoryButton = currentCategoryButton.currentButton {
            return dataProvider.population.findBy(category: categoryButton.category)
        } else {
            return nil
        }
    }
}

protocol Buttonable {
    var button: UIButton { get set }
}

struct CategoryButton: Buttonable {
    var category: EntrantCategory
    var button: UIButton
}

struct SubCategoryButton: Buttonable {
    var category: EntrantCategory
    var subCategory: EntrantSubCategory
    var button: UIButton
}

class LabelAndField {
    var field: UITextField
    var label: UILabel
    
    var isEnabled: Bool = true {
        didSet {
            field.isEnabled = isEnabled
            label.isEnabled = isEnabled
            field.backgroundColor = (field.isEnabled ? ApplicationColor.fieldBackground : ApplicationColor.fieldBackgroundDisabled).value
        }
    }
    
    init(field: UITextField, label: UILabel) {
        self.field = field
        self.label = label
    }
    
    func clear() {
        field.text = nil
    }
    
    func inError() {
        field.borderColor = ApplicationColor.fieldBorderError.value
        field.textColor = ApplicationColor.fieldTextError.value
        label.textColor = ApplicationColor.labelError.value
    }
    
    func reset() {
        field.borderColor = ApplicationColor.fieldBorder.value
        field.textColor = ApplicationColor.fieldText.value
        label.textColor = ApplicationColor.label.value
    }
}

struct ButtonState<T: Buttonable> {
    var color: UIColor
    var highlightColor: UIColor
    var buttons: [T]
    var currentButton: T?
    
    mutating func handle(button: UIButton? = nil) {
        if let previousButton = currentButton {
            previousButton.button.setTitleColor(color, for: .normal)
        }
        
        if let button = button {
            currentButton = buttons.filter({ $0.button == button }).first
            
            if let currentButton = currentButton {
                currentButton.button.setTitleColor(highlightColor, for: .normal)
            }
        } else {
            currentButton = nil
        }
    }
}

