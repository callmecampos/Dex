//
//  ContactWrite.swift
//  Dex
//
//  Created by Felipe Campos on 8/9/17.
//  Copyright © 2017 Orange Inc. All rights reserved.
//

import Foundation
import UIKit
import Contacts

@available(iOS 9.0, *)
class OnCallEmpContact: UITableViewController {
    
    var store: CNContactStore!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var workPhoneLabel: UILabel!
    
    
    
    var emp = employee()
    var rank = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text=self.emp.getFirstName()+" "+emp.getLastName()
        self.phoneLabel.text="0"+self.emp.getMobile()
        self.emailLabel.text=self.emp.getEmail()
        self.workPhoneLabel.text=self.emp.getPhone()
        
        store = CNContactStore()
        checkContactsAccess()
    }
    
    private func checkContactsAccess() {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        // Update our UI if the user has granted access to their Contacts
        case .authorized:
            self.accessGrantedForContacts()
            
        // Prompt the user for access to Contacts if there is no definitive answer
        case .notDetermined :
            self.requestContactsAccess()
            
        // Display a message if the user has denied or restricted access to Contacts
        case .denied,
             .restricted:
            let alert = UIAlertController(title: "Privacy Warning!",
                                          message: "Permission was not granted for Contacts.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func requestContactsAccess() {
        
        store.requestAccess(for: .contacts) {granted, error in
            if granted {
                DispatchQueue.main.async() {
                    self.accessGrantedForContacts()
                    return
                }
            }
        }
    }
    
    // This method is called when the user has granted access to their address book data.
    private func accessGrantedForContacts() {
        //Update UI for grated state.
        //...
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if rank == "0" {
                return "Primary Employee"
            } else if rank == "1" {
                return "Backup Employee"
            }
        }
        return""
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true) // to stop highliting the selected cell
        
        if indexPath.section == 1 && indexPath.row == 0 {
            self.saveContact()
        }
    }
    
    func saveContact() {
        do {
            let contact = CNMutableContact()
            contact.givenName = self.emp.getFirstName()
            contact.familyName = self.emp.getLastName()
            contact.phoneNumbers = [CNLabeledValue(
                label:CNLabelPhoneNumberiPhone,
                value:CNPhoneNumber(stringValue:emp.getMobile())),
                                    CNLabeledValue(
                                        label:CNLabelPhoneNumberiPhone,
                                        value:CNPhoneNumber(stringValue:emp.getPhone()))]
            
            let workEmail = CNLabeledValue(label:CNLabelWork, value:emp.getEmail())
            contact.emailAddresses = [workEmail]
            
            
            let saveRequest = CNSaveRequest()
            saveRequest.add(contact, toContainerWithIdentifier:nil)
            try store.execute(saveRequest)
            print("saved")
            
        } catch _ {
            print("error")
        }
    }
}
