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
    
    lazy var labelFields: [PersonalInfo: LabelButton] = {
        return [
            .birthDate: LabelButton(field: birthDateTextInput, label: birthDateLabel),
            .birthDateJunior: LabelButton(field: birthDateTextInput, label: birthDateLabel),
            .birthDateSenior: LabelButton(field: birthDateTextInput, label: birthDateLabel),
            .ssn: LabelButton(field: ssnTextInput, label: ssnLabel),
            .project: LabelButton(field: projectNumberTextInput, label: projectNumberLabel),
            .firstName: LabelButton(field: firstNameTextInput, label: firstNameLabel),
            .lastName: LabelButton(field: lastNameTextInput, label: lastNameLabel),
            .vendor: LabelButton(field: companyTextInput, label: companyLabel),
            .street: LabelButton(field: streetTextInput, label: streetLabel),
            .city: LabelButton(field: cityTextInput, label: cityLabel),
            .state: LabelButton(field: stateTextInput, label: stateLabel),
            .zip: LabelButton(field: zipCodeTextInput, label: zipCodeLabel)
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
        
        chooseCategory(initialCategoryButton.button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI Logic
    func managePersonalInfo() {
        var entrant: Entrantable?

        if let subCategoryButton = currentSubCategoryButton.currentButton {
            entrant = dataProvider.findEntrantFor(category: subCategoryButton.category, subCategory: subCategoryButton.subCategory)
        } else if let categoryButton = currentCategoryButton.currentButton {
            entrant = dataProvider.findEntrantFor(category: categoryButton.category)
        }
        
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
        currentSubCategoryButton.handle(button: sender)
        managePersonalInfo()
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

class LabelButton {
    var field: UITextField
    var label: UILabel
    
    var isEnabled: Bool = true {
        didSet {
            field.isEnabled = isEnabled
            label.isEnabled = isEnabled
        }
    }
    
    init(field: UITextField, label: UILabel) {
        self.field = field
        self.label = label
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

