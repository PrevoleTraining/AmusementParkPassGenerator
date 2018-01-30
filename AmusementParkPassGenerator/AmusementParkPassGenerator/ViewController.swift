//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 22.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

import UIKit

/**
 * Controller for the main view of the application
 */
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
    
    /// Store a reference of the personal data fields with their enum corresponding value
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
    
    /// Reference to the category buttons (top button bar)
    lazy var categoryButtons: [CategoryButton] = {
        return createCategoryButtons(for: dataProvider.categories)
    }()
    
    /// Reference to the sub category buttons (second bar at the top)
    lazy var subCategoryButtons: [SubCategoryButton] = {
        return createSubCategoryButtons(for: dataProvider.subCategories())
    }()
    
    /// The data provider containing all the loaded data
    var dataProvider: DataProvider
    
    /// Category state button
    lazy var currentCategoryButton: ButtonState<CategoryButton> = {
        return ButtonState<CategoryButton>(
            color: ApplicationColor.categoryButtonText.value,
            highlightColor: ApplicationColor.categoryHighlight.value,
            buttons: categoryButtons,
            currentButton: nil
        )
    }()
    
    /// Sub category state button
    lazy var currentSubCategoryButton: ButtonState<SubCategoryButton> = {
        return ButtonState<SubCategoryButton>(
            color: ApplicationColor.subCategoryButtonText.value,
            highlightColor: ApplicationColor.subCategoryHighlight.value,
            buttons: subCategoryButtons,
            currentButton: nil
        )
    }()

    /// The current person being created
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
        
        // Initialize the top button bars with the first category and first sub category if any
        chooseCategory(initialCategoryButton.button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Give the current person being created to the pass tester view
        if let passTesterViewController = segue.destination as? PassTesterViewController {
            passTesterViewController.person = currentPerson
        }
    }
    
    // MARK: - UI Logic
    
    /**
     * Enable/Disable the data fields regarding the current entrant
     */
    func managePersonalInfo() {
        let entrant: Entrantable? = findEntrant()

        // Disable all personal info because the future info is not enought to do the job
        for (_, labelField) in labelFields {
            labelField.isEnabled = false
        }
        
        // Enable the required fields
        if let entrant = entrant, let personalInfoCollection = entrant.personalInfo {
            for personalInfo in personalInfoCollection {
                if let labelButton = labelFields[personalInfo] {
                    labelButton.isEnabled = true
                }
            }
        }
    }
    
    // MARK: - UI Actions
    
    /**
     * Category is touched
     */
    @objc func chooseCategory(_ sender: UIButton) {
        currentCategoryButton.handle(button: sender)
        
        if let category = currentCategoryButton.currentButton?.category {
            var subCategoryButtonsForCategory: [SubCategoryButton] = []
            // Show/Hide the sub category buttons corresponding to the category
            for subCategoryButton in subCategoryButtons {
                if subCategoryButton.category == category {
                    subCategoryButtonsForCategory.append(subCategoryButton)
                    subCategoryButton.button.isHidden = false
                } else {
                    subCategoryButton.button.isHidden = true
                }
            }
            
            // If no sub category buttons visible, we hide the complete bar
            if subCategoryButtonsForCategory.count > 0 {
                subCategoryButtonsStackView.isHidden = false
                chooseSubCategory(subCategoryButtonsForCategory.first!.button)
            } else {
                subCategoryButtonsStackView.isHidden = true
                chooseSubCategory()
            }
        }
    }
    
    /**
     * Sub category is touched
     */
    @objc func chooseSubCategory(_ sender: UIButton? = nil) {
        resetState()
        clearFields()
        currentSubCategoryButton.handle(button: sender)
        managePersonalInfo()
    }
    
    /**
     * Generate pass is touched
     */
    @IBAction func generatePass(_ sender: UIButton) {
        // Reset the app state to validate a fresh data set
        resetState()
        
        let entrant: Entrantable? = findEntrant()
        
        if let entrant = entrant, let accesses = entrant.accesses {
            // Retrieve the project and vendor
            let project: Project? = dataProvider.findProject(number: projectNumberTextInput.text)
            let vendor: Vendor? = dataProvider.findVendor(name: companyTextInput.text)
            
            // Create a eligible pass and person
            let pass = Pass(accesses: accesses, categoryAndSubCategory: entrant.categoryAndSubCategory, areaRestrictedEntrantables: [project, vendor])
            let person = Person(pass: pass)
            
            // Fill the personal info
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
            
            // Same for management tier except we convert it from text to its enum
            if let managementTier = managementTierTextInput.text {
                person.managementTier = ManagementTier(rawValue: managementTier)
            }
            
            // Do the data validation
            if isValid(person: person, personalInfo: entrant.personalInfo) {
                // Clear all the fields
                for (_, field) in labelFields {
                    field.clear()
                }
                
                currentPerson = person
                
                // Show the tester screen
                performSegue(withIdentifier: "showPassTester", sender: nil)
            }
        } else {
            // Show a generic error. This should never happen
            openPopup(message: "Unknown error, ask your App's Developer")
        }
    }
    
    /**
     * Populate button is touched
     */
    @IBAction func populate(_ sender: UIButton) {
        // We find a sample person and we fill the fields on the screen with its data
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
    
    /**
     * Create the buttons for the given categories
     *
     * - parameter for: The categories
     *
     * - returns: The collection of created buttons
     */
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
    
    /**
     * Create the buttons for the given sub categories
     *
     * - parameter for: The sub categories
     *
     * - returns: The collection of created buttons
     */
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
    
    /**
     * Reset the main view state
     */
    func resetState() {
        currentPerson = nil
        
        for (_, field) in labelFields {
            field.reset()
        }
    }
    
    /**
     * Clear the data in the text fields
     */
    func clearFields() {
        for (_, field) in labelFields {
            field.clear()
        }
    }

    /**
     * Check if the personal info filled for a person are valid
     *
     * - parameter person: The person to check
     * - parameter personalInfo: The personal info to check
     *
     * - returns: True if no error, false otherwise but also open a popup with errors
     */
    func isValid(person: Personable, personalInfo: [PersonalInfo]?) -> Bool {
        if let personalInfo = personalInfo {
            // Validate the person against the chosen peronal info
            let errors = PersonalInfo.validate(person: person, personalInfo: personalInfo)
            
            // Check if there are errors
            if !errors.isEmpty {
                // Update the UI of the fields to reflect the erros (ex: red border)
                errors.forEach { (key: PersonalInfo, value: [PersonalInfoError]) in
                    if let field = labelFields[key] {
                        field.inError()
                    }
                }

                // Open the error popup
                openPopup(errors: errors)

                return false
            }
        }
        
        return true
    }

    /**
     * Open the error popup to show the errors to the user
     *
     * - parameter errors: The errors to show
     * - parameter message: A message to show
     */
    func openPopup(errors: [PersonalInfo: [PersonalInfoError]]? = nil, message: String? = nil) {
        // Prepare the popup
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popup = storyboard.instantiateViewController(withIdentifier: "validationErrorView") as! ValidationErrorViewController
        
        // Configure it
        popup.modalPresentationStyle = .overFullScreen
        popup.modalTransitionStyle = .crossDissolve

        // Set the data
        popup.errors = errors
        popup.message = message
        
        // Present it
        self.present(popup, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    /**
     * Find an entrant corresponding to the current category and sub cateogory state of the application
     *
     * - returns: The entrant found
     */
    func findEntrant() -> Entrantable? {
        if let subCategoryButton = currentSubCategoryButton.currentButton {
            return dataProvider.findEntrantFor(category: subCategoryButton.category, subCategory: subCategoryButton.subCategory)
        } else if let categoryButton = currentCategoryButton.currentButton {
            return dataProvider.findEntrantFor(category: categoryButton.category)
        } else {
            return nil
        }
    }

    /**
     * Find an sample person corresponding to the current category and sub cateogory state of the application
     *
     * - returns: The sample person found
     */
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

/**
 * Protocol to make available a button
 */
protocol Buttonable {
    var button: UIButton { get set }
}

/**
 * To store a category with its associated button
 */
struct CategoryButton: Buttonable {
    var category: EntrantCategory
    var button: UIButton
}

/**
 * To store a sub category with its associated button and parent category
 */
struct SubCategoryButton: Buttonable {
    var category: EntrantCategory
    var subCategory: EntrantSubCategory
    var button: UIButton
}

/**
 * Group a field and label together
 */
class LabelAndField {
    var field: UITextField
    var label: UILabel
    
    /**
     * Enable/Disable the field and label at once
     */
    var isEnabled: Bool = true {
        didSet {
            field.isEnabled = isEnabled
            label.isEnabled = isEnabled
            field.backgroundColor = (field.isEnabled ? ApplicationColor.fieldBackground : ApplicationColor.fieldBackgroundDisabled).value
        }
    }
    
    /**
     * Constructor
     *
     * - parameter field: The text field
     * - parameter label: The label associated to the field
     */
    init(field: UITextField, label: UILabel) {
        self.field = field
        self.label = label
    }
    
    /**
     * Clear the text field
     */
    func clear() {
        field.text = nil
    }
    
    /**
     * Manage the field and label to show the error state
     */
    func inError() {
        field.borderColor = ApplicationColor.fieldBorderError.value
        field.textColor = ApplicationColor.fieldTextError.value
        label.textColor = ApplicationColor.labelError.value
    }
    
    /**
     * Reset the error state from the label and text field
     */
    func reset() {
        field.borderColor = ApplicationColor.fieldBorder.value
        field.textColor = ApplicationColor.fieldText.value
        label.textColor = ApplicationColor.label.value
    }
}

/**
 * Store the state of a button for the category or sub category
 */
struct ButtonState<T: Buttonable> {
    var color: UIColor
    var highlightColor: UIColor
    var buttons: [T]
    var currentButton: T?
    
    /**
     * Switch to the latest button touched
     */
    mutating func handle(button: UIButton? = nil) {
        // Restore the current button to its normal UI state
        if let previousButton = currentButton {
            previousButton.button.setTitleColor(color, for: .normal)
        }
        
        if let button = button {
            // Find the new button
            currentButton = buttons.filter({ $0.button == button }).first
            
            // Update the new button to reflect the user choice
            if let currentButton = currentButton {
                currentButton.button.setTitleColor(highlightColor, for: .normal)
            }
        } else {
            currentButton = nil
        }
    }
}

