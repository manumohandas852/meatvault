//
//  editViewController.swift
//  main project meatshop
//
//  Created by irohub on 10/12/24.
//

import UIKit

class editViewController: UIViewController {
    @IBOutlet weak var update: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var landmark: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var pincode: UITextField!
    @IBOutlet weak var flatno: UITextField!
    @IBOutlet weak var locality: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mbnumber: UITextField!
    @IBOutlet weak var name: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Curving the corners and adding shadows to view1 and view2
        applyStylingToView(view: view1)
        applyStylingToView(view: view2)
        
        // Add red mandatory stars to the required text fields
            addMandatoryStar(to: name)
            addMandatoryStar(to: city)
            addMandatoryStar(to: pincode)
            addMandatoryStar(to: state)
        // Curving the edges of the update button
        applyStylingToButton(button: update)
        update.addTarget(self, action: #selector(handleUpdateButtonClick), for: .touchUpInside)
    }

    func applyStylingToView(view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
    }
    func addMandatoryStar(to textField: UITextField) {
        if let placeholder = textField.placeholder {
            textField.placeholder = placeholder + " *"
            let starRange = (textField.placeholder! as NSString).range(of: " *")
            
            // Applying red color to the star
            let attributedString = NSMutableAttributedString(string: textField.placeholder!)
            attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: starRange)
            textField.attributedPlaceholder = attributedString
        }
    }
    func applyStylingToButton(button: UIButton) {
        button.layer.cornerRadius = 10  // Adjust the radius as needed
        button.layer.masksToBounds = true  // Ensure the corners are clipped to match the rounded corners
    }
    @objc func handleUpdateButtonClick() {
        // Clear previous warnings (if any)
        resetWarnings()
        
        // Flag to check if validation passes
        var isValid = true
        
        // Check if mandatory fields are empty
        if name.text?.isEmpty ?? true {
            showWarning(on: name)
            isValid = false
        }
        if city.text?.isEmpty ?? true {
            showWarning(on: city)
            isValid = false
        }
        if pincode.text?.isEmpty ?? true {
            showWarning(on: pincode)
            isValid = false
        }
        if state.text?.isEmpty ?? true {
            showWarning(on: state)
            isValid = false
        }
        
        // If all fields are valid, proceed with the update
        if isValid {
            // Proceed with the update action (for example, save data or navigate)
            print("Update successful!")
            
            // Navigate to the tabViewController after a successful update
            navigateToTabViewController()
        } else {
            print("Please fill out all mandatory fields.")
        }
    }

    func navigateToTabViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabVC = storyboard.instantiateViewController(identifier: "tab") as? tabViewController {
            // Navigate to the TabViewController
            self.navigationController?.pushViewController(tabVC, animated: true)
        }
    }

    func showWarning(on textField: UITextField) {
        // Show red border on the empty text field
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1.0
    }

    func resetWarnings() {
        // Reset the border color for all text fields
        let textFields = [name, city, pincode, state]
        for textField in textFields {
            textField?.layer.borderColor = UIColor.clear.cgColor
            textField?.layer.borderWidth = 0.0
        }
    }

    @IBAction func back(_ sender: Any) {
        
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            // If there's no navigation controller, dismiss the current view controller
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func update(_ sender: Any) {
        guard let userID = UserDefaults.standard.string(forKey: "MyKey") else {
            print("Error: User ID not found in UserDefaults")
            return
        }
        let url_str = URL(string: "https://meatshop.b4production.com/index.php?route=api/register&api_token=")
                var url_req = URLRequest(url: url_str!)
                url_req
                    .setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                url_req.httpMethod = "POST"
let stringg = "user_id=\(userID)&firstname=\(name.text!)&lastname=\(lastname.text!)&telephone=\(mbnumber.text!)&email=\(email.text!)&type=\("0")&referal_code=\("0")&key=koFCpCMzm8hhn9ULj0BnUzZkpqM3rg9Mqdii3FwPRjBwZFQWriIJYgB5jjOhNIyasSl4RrmCFLW3tHDRtI39viQbYEP7nEkYvba2wstThYWjvkndZq0zaXJaWjuqeZo8vR3MMHa6OhBDKsFPmWOlIM4H1TgB1fudQndGKzUPg8YhAoaAoCxZ562zjbQdPO73ZkwyPV7iOIkyH11ZLAN42a5dgLH22Rs1VasEWBKdfkqMLPfDbLQpF9Ofqah4fqwc"
                url_req.httpBody = stringg.data(using: .utf8)
                let task = URLSession.shared.dataTask(with: url_req){(data,response,error)in
                    let mydata = data
                    do
                    {
                        let jsondata = try?
                        JSONSerialization.jsonObject(with: mydata!, options: [])
                        print(jsondata ?? "")
                        DispatchQueue.main.async {
                            print("Registration Successfull!!!")
                        }
                    }
                    
                }
                task.resume()
    }
    private func loginpage() {
        let sttoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextpage = sttoryboard.instantiateViewController(identifier: "tab")as! tabViewController
        self.navigationController?.pushViewController(nextpage, animated: true)
    }
}

