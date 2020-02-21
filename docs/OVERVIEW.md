# Turnify

## Project Overview

The main scope of this project is to bring multiple clinics the possibility of handle appointments inside a single platform. 
    
### Workflow detail

We will be developing an application where, given the case, an user can register either as an Individual (single professional running a doctor's office) or a Clinic (an organization that manages a lot of professionals). Each one of this users will be able to create a calendar (or multiple, but always one per professional), pick the desired week days where the professional will be working and the time range to set appointments. 

Once the appointment is setted, both the patient and the professional will receive a confirmation (via email and sms, if given), and the patient will be asked to confirm its assitance to the appointment. Once the confirmation is placed, that space in the calendar is reserved and no other patient can place an appointment there.

The appointments can be placed by both, a clinic administrator or a customer (patient). Each clinic / professional will have its own permalink, and as the main page itself will be the calendar (or a selector with the professionals, prior the calendar display, if it's a clinic) where to place an appointment - having a Calendar (to pick a day), a time selector (e.g.: ["16:30", "16:45", "17:00"] as possible values) and a form to fill with personal data.

**NOTE**: If a patient has a pending appointment, will not be able to place another one that same day. A patient can always cancel an appointment.
    
### Future implementations
    
* In the near future will be desired to add a tracking service for patients, following its clinical records and storing each visit (appointment), as well as the reason (patology) behind each one, in order to keep track of the clinical history.
    
* Since a lot of clinics will be operating in the same place, we can even check for fraudulent clients, comparing the data they're using on each clinic and alerting them about a possible scam.

* On-site payment methods. 

## Views (tech description, non-graphical)

### Sign up

**Related mutation:**  
`createUser(email: String!, role: String!, password: String!, passwordConfirmation: String!)`

* First step
    * The user will have to select between two types: "Individual" or "Clínica".
    * Once the user select one or another, store the value as Role, that will be sent to GraphQL once finished the process.

* Second step
    * A form with the following fields will be required to submit: Firstname, Lastname, Email, Password, PasswordConfirmation. 
    * Each one of those is a WIP, just fields to start testing the app. More will be added in future implementations.
    * OPTIONAL: add a `validate` button, that sends an email with a code, to secure the given address.
    * Once finished, the `createUser` mutation should be called. We're creating the user first, then giving the chance of creating the Clinic association. This is to give the users the possibility of finishing the form later, so saving the `registration_state` will be desired.

* Third step
    * **Related mutation:** 
    `createCompany(name: String!)`. Remember that, from this point forward, the user token will **always** be required to make a transaction.
    * A new form with the following fields will be prompted: Name.
    
* Fourth step
    * Congratulations screen, showing a brief message and redirecting to the main page.

### Sign In
    
**Related mutation:**  
`signIn(email: String!, password: String!) { token }`
The returned token will be required in the Authorization header.

This will be the typical Sign In page, no mysteries attached.

### Calendar
    WIP
