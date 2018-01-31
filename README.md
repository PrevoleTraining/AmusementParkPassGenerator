# Amusement Park Pass Generator

> Generates Pass for amusement park employees, vendors and guests.

## Branch - Part 2 (Treehouse - Project 05)

In this part, the goal is to refactor few business logic and to build the UI of the application.

The UI must conform to the provided mockups or at least must be really similar to them.

> You will now take the foundation you created in Project 4 (Amusement Park Generator (I)) and add the User Interface for the app, along with a short list of new features and entrant types handling. You might need to refactor some code in order to accommodate these changes.

> Upon completion, you will have a functional iPad app, created entirely yourself! The app can take user input and create personalized entrant passes for all the entrant types. When the passes are being swiped at different locations in the park, business rules such as whether the entrant is allowed to access an area, whether the entrant can get a discount, will be tested.

## How to test - Part 2 (Treehouse - Project 05)

Launch the app with the simulator and play with the controls. On the main screen you can choose a category (top button bar) and then, if available, you can chose a sub category. These selections will prepare the creation of the pass. It will also decide which fields are required to be filled to create the pass.

You can populate the fields with the corresponding button which will fill only the relevant fields.

Pressing the generate pass button will create the pass and show the testing pass screen if there is no validation error. If there is validation errors, a popup will tell you what are the errors in the fields and the fields will be borderized with a red color.

On the test screen, you will see details about the person and the pass if relevant. There are three buttons to test the different access types. The area, ride and discount accesses. For each type, all the possible accesses are checked. A selection of checkpoints are prepared to do these tests. In the result rectangle, you will see all the results for one sets of accesses at a time.

You can go back to the main screen by pressing create new pass button

## Known issues - Part 2 (Treehouse - Project 05)

* In the screen to test the accesses, the inner shadow does not render properly. Right border of the shadow is not aligned with right border of textview
* In the main screen, when the keyboard is shown on screen, it hides some fields. Workaround is to click on the button to hide the keyboard.

## Notes for reviewer - Part 2 (Treehouse - Project 05)

Regarding the exceeding expectations, I was not able to use the sounds. It will not be great to play the sound five times in a row when testing the five category of area accesses for example. The code is present and as it is the same than the two projects 2 and 3, I assume I can let this aside at the moment. You will find the code ready to use in the project.

## Branch - Part 1 (Treehouse - Project 04)

In this part, the goal is to prepare the data model and the mechanism to manage
the passes, the guests (employees, ...) and accesses.

There is the base instructions to implement (from Treehouse):

> For this project, you’ll create a system for creating and validating access passes to an amusement park. There are three types of people who can be granted access to the park: employees, vendors, and of course, guests. As you can imagine, these different groups are allowed to enter different areas of the park, and may or may not be permitted to do certain things, like ride the rides or receive discounts in certain eateries and shops, for example.

> Within each category of park access, there should be several sub-categories with varying access rights. For example, guests can be “Classic”, “VIP”, or “Free Child”, with different privileges associated with each. Details on exactly what each type of entrant is permitted to do and what type of personal information is required from them are outlined in the Business Rules Matrix. The document can be downloaded in the Project Resources area.

> This project is divided into two parts. Part 1, outlined here as Project 4, will focus on building the data structures, object definitions, logic, error handling and other plumbing for the app. No user interface will be built at this stage. Your code will be built, tested and run by using temporary hard-coded “plug” values (or test cases).

> For Part 2, which is Project 5, you will construct the User Interface element and workflow. They are shown in the project mockups and Onward and Upward Instruction Video. You will also add features like data entry screen and pass generation. In addition, several additional types of entrants such as contracted employees, vendors, season pass holders and senior guests, will be added. Keep in mind that you’ll want to write the code for Part I so it can be reused and extended in Part 2. (You will probably need to refactor some code, regardless, but do keep this in mind.)

> In creating your code, be sure to make use of optionals, enums, protocols, data structures (such as collections) and error handling. Also, remember you can use a combination of both inheritance and composition, depending on which is best suited for the particular feature. The majority of the tools, syntax and concepts needed to complete Part I have been covered in the courses so far. However the implementation of certain elements, like dates and extra credit items will require you to seek additional resources and documentation.

> Just to be clear, the app you are creating would utilized by the staff of the amusement park at the entrance gates, inside their kiosk. Actual entrants wouldn’t see the screen. They will tell the staff their relevant information and staff members would type it on the iPad screen and generate the passes. The access levels of the passes will then be tested by simulated “swiping’ on the iPad. The completed app in Project 5 will not actually print any passes, but simply creates an image of the pass, as per the mockups. Please watch the Onward and Upward Instruction Video for a walk through of the app in order to get a full understanding.

## How to test - Part 1 (Treehouse - Project 04)

Build and launch the App. There is a simple UI to play with all the possible entrants
and all possible check points. A text view show the result of the access control.

In addition, a switch allow to set a temporary birth date to the entrant person
to see the birth date message.

Finally, another switch can be use to see the data validation of the personal info.
Once activated, the entrants buttons become button to check the validation. The validation
follow the rules from the data matrix provided.
