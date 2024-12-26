//
//  signupViewController.swift
//  main project meatshop
//
//  Created by irohub on 14/11/24.
//

import UIKit

class signupViewController: UIViewController {
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var secondname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    @IBOutlet weak var registerbtn: UIButton!
    
    private var isPasswordVisible = false
        private var isConfirmPasswordVisible = false
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set placeholder text for fields
            setMandatoryPlaceholder(for: firstname, placeholder: "First Name")
            setMandatoryPlaceholder(for: secondname, placeholder: "Second Name")
            setMandatoryPlaceholder(for: email, placeholder: "Email")
            setMandatoryPlaceholder(for: phonenumber, placeholder: "Phone Number")
            setMandatoryPlaceholder(for: password, placeholder: "Password")
            setMandatoryPlaceholder(for: confirmpassword, placeholder: "Confirm Password")
            
            // Set up password toggle buttons
            setupPasswordToggleButton(for: password, isPasswordField: true)
            setupPasswordToggleButton(for: confirmpassword, isPasswordField: false)
        }

        private func setMandatoryPlaceholder(for textField: UITextField, placeholder: String) {
            let attributedString = NSMutableAttributedString(string: "\(placeholder) *", attributes: [
                .foregroundColor: UIColor.lightGray
            ])
            
            // Add red color to the asterisk
            let range = (placeholder + " *") as NSString
            let asteriskRange = range.range(of: "*")
            attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: asteriskRange)
            
            textField.attributedPlaceholder = attributedString
        }

        private func setupPasswordToggleButton(for textField: UITextField, isPasswordField: Bool) {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal)  // Initial icon (hidden)
            button.tintColor = .gray
            button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            
            // Set action for toggle button
            button.addTarget(self, action: isPasswordField ? #selector(togglePasswordVisibility) : #selector(toggleConfirmPasswordVisibility), for: .touchUpInside)
            
            // Set button as right view of the text field
            textField.rightView = button
            textField.rightViewMode = .always
            
            // Initially set text as hidden, using dots
            textField.isSecureTextEntry = true
        }

        @objc private func togglePasswordVisibility() {
            isPasswordVisible.toggle()
            password.isSecureTextEntry = !isPasswordVisible
            if let button = password.rightView as? UIButton {
                button.setImage(UIImage(systemName: isPasswordVisible ? "eye" : "eye.slash"), for: .normal)
            }
        }

        @objc private func toggleConfirmPasswordVisibility() {
            isConfirmPasswordVisible.toggle()
            confirmpassword.isSecureTextEntry = !isConfirmPasswordVisible
            if let button = confirmpassword.rightView as? UIButton {
                button.setImage(UIImage(systemName: isConfirmPasswordVisible ? "eye" : "eye.slash"), for: .normal)
            }
        }

        @IBAction func registerButtonClicked(_ sender: Any) {
            validateFields()
            loginpage()
    let url_str = URL(string: "https://meatshop.b4production.com/index.php?route=api/register&api_token=")
            var url_req = URLRequest(url: url_str!)
            url_req
                .setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            url_req.httpMethod = "POST"
            let stringg = "firstname=\(firstname.text!)&lastname=\(secondname.text!)&email=\(email.text!)&telephone=\(phonenumber.text!)&password=\(password.text!)&type=\("0")&referal_code=\("0")&key=koFCpCMzm8hhn9ULj0BnUzZkpqM3rg9Mqdii3FwPRjBwZFQWriIJYgB5jjOhNIyasSl4RrmCFLW3tHDRtI39viQbYEP7nEkYvba2wstThYWjvkndZq0zaXJaWjuqeZo8vR3MMHa6OhBDKsFPmWOlIM4H1TgB1fudQndGKzUPg8YhAoaAoCxZ562zjbQdPO73ZkwyPV7iOIkyH11ZLAN42a5dgLH22Rs1VasEWBKdfkqMLPfDbLQpF9Ofqah4fqwc"
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

        private func validateFields() {
            // List of text fields to validate
            let fields: [(UITextField, String)] = [
                (firstname, "First Name"),
                (secondname, "Second Name"),
                (email, "Email"),
                (phonenumber, "Phone Number"),
                (password, "Password"),
                (confirmpassword, "Confirm Password")
            ]
            
            // Flag to track validation
            var allFieldsValid = true
            
            // Loop through fields and check for emptiness
            for (textField, placeholder) in fields {
                if textField.text?.isEmpty == true {
                    // Mark field as invalid
                    allFieldsValid = false
                    showWarningPlaceholder(for: textField, placeholder: "\(placeholder) is required")
                }
            }
            
            if allFieldsValid {
                // Proceed with registration process
                print("All fields are filled. Proceed with registration.")
            } else {
                // Show alert if not all fields are filled
                showAlert(message: "Please fill in all mandatory fields.")
            }
        }

        // Function to show warning placeholder text (already in place)
        private func showWarningPlaceholder(for textField: UITextField, placeholder: String) {
            let attributedString = NSMutableAttributedString(string: placeholder, attributes: [
                .foregroundColor: UIColor.red
            ])
            
            textField.attributedPlaceholder = attributedString
        }

        // Function to show alert
        private func showAlert(message: String) {
            let alertController = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
            
            // Add "OK" action to dismiss the alert
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            // Present the alert
            present(alertController, animated: true, completion: nil)
        }
    
    @IBAction func backbtn(_ sender: Any) {
        let sttoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextpage = sttoryboard.instantiateViewController(identifier: "main")as! ViewController
        self.navigationController?.pushViewController(nextpage, animated: true)
    }
    private func loginpage() {
        let sttoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextpage = sttoryboard.instantiateViewController(identifier: "main")as! ViewController
        self.navigationController?.pushViewController(nextpage, animated: true)
    }
    /*
     @IBAction func signup(_ sender: Any) {
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
