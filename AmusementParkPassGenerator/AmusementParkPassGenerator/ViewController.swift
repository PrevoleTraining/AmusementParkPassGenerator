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
            .zip: LabelAndField(field: zipCodeTextInput, label: zipCodeLabel)
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
        
        for (_, labelField) in labelFields {
            setupBorder(labelField: labelField, color: ApplicationColor.fieldBorder.value, width: 2.0, cornerRadius: 5.0)
        }
        
        chooseCategory(initialCategoryButton.button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI Logic
    func managePersonalInfo() {
        var entrant: Entrantable? = findEntrant()

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
        resetErrors()
        clearFields()
        currentSubCategoryButton.handle(button: sender)
        managePersonalInfo()
    }
    
    @IBAction func generatePass(_ sender: UIButton) {
        resetErrors()
        
        let entrant: Entrantable? = findEntrant()
        
        if let entrant = entrant, let accesses = entrant.accesses {
            let person = Person(pass: Pass(accesses: accesses))
            
            person.firstName = firstNameTextInput.text
            person.lastName = lastNameTextInput.text
            person.street = streetTextInput.text
            person.city = cityTextInput.text
            person.state = stateTextInput.text
            person.zipCode = zipCodeTextInput.text
            person.birthDate = Date.parse(date: birthDateTextInput.text)
            person.ssn = ssnTextInput.text
            person.project = dataProvider.findProject(number: projectNumberTextInput.text)
            person.vendor = dataProvider.findVendor(name: companyTextInput.text)
            
            if let personalInfo = entrant.personalInfo {
                let errors = PersonalInfo.validate(person: person, personalInfo: personalInfo)
                for (key, errorMessages) in errors {
                    if let field = labelFields[key] {
                        field.inError()
                    }
                    
                    print(key)
                    for message in errorMessages {
                        print(message.description())
                    }
                }
                
                openPopup()
            } else {
                // TODO: Continue, no validation required
                // TODO: Clear fields
            }
        } else {
            // TODO: Do better error handling
            fatalError("Should never happen: Entrant not found")
        }
    }
    
    @IBAction func populate(_ sender: UIButton) {
    }
    
    // MARK: - UI Builders
    
    func createCategoryButtons(for categories: [EntrantCategory]) -> [CategoryButton] {
        return categories.map {
            return CategoryButton(category: $0, button: createUIButton(
                text: $0.description(),
                selector: #selector(self.chooseCategory),
                backgroundColor: ApplicationColor.categoryButton.value,
                titleColor: ApplicationColor.categoryButtonText.value
            ))
        }
    }
    
    func createSubCategoryButtons(for subCategories: [EntrantSubCategory]) -> [SubCategoryButton] {
        return subCategories.map {
            return SubCategoryButton(category: $0.category(), subCategory: $0, button: createUIButton(
                text: $0.description(),
                selector: #selector(self.chooseSubCategory),
                backgroundColor: ApplicationColor.subCategoryButton.value,
                titleColor: ApplicationColor.subCategoryButtonText.value
            ))
        }
    }
    
    func createUIButton(text: String?, selector: Selector?, backgroundColor: UIColor, titleColor: UIColor) -> UIButton {
        let button = UIButton()
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        
        if let text = text {
            button.setTitle(text, for: .normal)
        }
        
        if let selector = selector {
            button.addTarget(self, action: selector, for: .touchUpInside)
        }
        
        return button
    }
    
    func setupBorder(labelField: LabelAndField, color: UIColor, width: Double? = nil, cornerRadius: Double? = nil) {
        labelField.field.layer.borderColor = color.cgColor

        if let width = width {
            labelField.field.layer.borderWidth = CGFloat(width)
        }
        
        if let cornerRadius = cornerRadius {
            labelField.field.layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
    
    func resetErrors() {
        for (_, field) in labelFields {
            field.reset()
        }
    }
    
    func clearFields() {
        for (_, field) in labelFields {
            field.clear()
        }
    }
    
    func openPopup() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "validationErrorView") as! ValidationErrorViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
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
        field.layer.borderColor = ApplicationColor.fieldBorderError.value.cgColor
        field.textColor = ApplicationColor.fieldTextError.value
        label.textColor = ApplicationColor.labelError.value
    }
    
    func reset() {
        field.layer.borderColor = ApplicationColor.fieldBorder.value.cgColor
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

