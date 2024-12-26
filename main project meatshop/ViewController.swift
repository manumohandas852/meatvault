//
//  ViewController.swift
//  main project meatshop
//
//  Created by irohub on 13/11/24.
//

import UIKit
import SkyFloatingLabelTextField

class ViewController: UIViewController {
    @IBOutlet weak var myview: UIView!
    
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var loginbtn: UIButton!
    @IBOutlet weak var myview3: UIView!
    @IBOutlet weak var textfield1: SkyFloatingLabelTextField!
    @IBOutlet weak var textfield2: SkyFloatingLabelTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myview3.layer.shadowColor = UIColor.black.cgColor
        myview3.layer.shadowOpacity = 0.3
        myview3.layer.shadowOffset = CGSize(width: 0, height: 4)
        myview3.layer.shadowRadius = 6
        
        
        myview3.layer.cornerRadius = 10
        textfield1.placeholder = "Enter Your Username"
        textfield1.title = "Username"
        
        
        textfield1.tintColor = .black
        textfield1.textColor = .black
        textfield1.lineColor = .gray
        textfield1.selectedTitleColor = .black
        textfield1.selectedLineColor = .black
        textfield1.font = UIFont.systemFont(ofSize: 14)
        textfield1.titleFont = UIFont.systemFont(ofSize: 12)
        textfield1.placeholderFont = UIFont(name: "Roboto-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
        
        
        
        textfield2.placeholder = "Enter Your Password "
        textfield2.title = "Password"
        textfield2.tintColor = .black
        textfield2.textColor = .black
        textfield2.lineColor = .gray
        textfield2.selectedTitleColor = .black
        textfield2.selectedLineColor = .black
        textfield2.font = UIFont.systemFont(ofSize: 14)
        textfield2.titleFont = UIFont.systemFont(ofSize: 12)
        textfield2.placeholderFont = UIFont(name: "Roboto-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
        textfield2.isSecureTextEntry = true
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        eyeButton.tintColor = .gray
        eyeButton.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        // Set the eye button as the left view of the text field
        textfield2.rightView = eyeButton
        textfield2.rightViewMode = .always
        loginbtn.layer.cornerRadius = 15
        
        checkbox.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        
        // Set the initial appearance of the checkbox
        updateCheckboxAppearance()
        
        // Do any additional setup after loading the view.
    }
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        // Toggle the selected state of the button
        sender.isSelected.toggle()
        
        // Toggle the secure text entry of textfield2
        if let textfield2 = myview3.subviews.compactMap({ $0 as? SkyFloatingLabelTextField }).last {
            textfield2.isSecureTextEntry.toggle()
        }
    }
    
    @IBAction func toggleCheckbox(_ sender: Any) {
        
        checkbox.isSelected.toggle()
        
        // Update the checkbox appearance based on its new state
        updateCheckboxAppearance()
    }
    func updateCheckboxAppearance() {
        if checkbox.isSelected {
            checkbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            checkbox.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    @IBAction func signup(_ sender: Any) {
        let sttoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextpage = sttoryboard.instantiateViewController(identifier: "signup")as! signupViewController
        self.navigationController?.pushViewController(nextpage, animated: true)
    }
    @IBAction func login(_ sender: Any) {
        if textfield1.text == "" || textfield2.text == ""

        {

            let alert = UIAlertController(title: "Alert", message: "Fill All The Columns", preferredStyle: .alert)

            

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

            

            alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))

            

            self.present(alert, animated: true, completion: nil)

        }

    

        else

        {

            let urll = URL(string:"https://meatshop.b4production.com/index.php?route=api/login&api_token=")

            var req = URLRequest(url:urll!)

            req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content_type")

            req.httpMethod="POST"

            let poststring = "email=\(textfield1.text!)&password=\(textfield2.text!)&key=\("koFCpCMzm8hhn9ULj0BnUzZkpqM3rg9Mqdii3FwPRjBwZFQWriIJYgB5jjOhNIyasSl4RrmCFLW3tHDRtI39viQbYEP7nEkYvba2wstThYWjvkndZq0zaXJaWjuqeZo8vR3MMHa6OhBDKsFPmWOlIM4H1TgB1fudQndGKzUPg8YhAoaAoCxZ562zjbQdPO73ZkwyPV7iOIkyH11ZLAN42a5dgLH22Rs1VasEWBKdfkqMLPfDbLQpF9Ofqah4fqwc")"

            

            print("poststring__>>",poststring)

            

            req.httpBody=poststring.data(using: .utf8)

            

            let task=URLSession.shared.dataTask(with: req){(data,response,error)in

                let mydata = data

                do{

                    print("mydata__>>",mydata!)

                    do{

                     

                        let jsondata:NSDictionary = try JSONSerialization.jsonObject(with: mydata!, options: [])as! NSDictionary

                        print("jsondata__>>",jsondata)

                        DispatchQueue.main.async

                        {

                            

                            //let a = UserDefaults.standard.set(jsondata["user id"], forKey: "userid")

                            

                            //var a = UserDefaults.standard.set(jsondata["user_id"], forKey: "userid")

                            

                            

                            

                      

                            

                            if let message = jsondata["status"] as? String, message == "success"

                            

                            {

                                let strbyd = UIStoryboard(name: "Main", bundle: nil)

                            

                                let new = strbyd.instantiateViewController(identifier: "tab")as! tabViewController

                                

                                UserDefaults.standard.set(jsondata["user_id"], forKey: "MyKey")

                                

                                self.navigationController?.pushViewController(new, animated: true)

                            }

                            else

                            {

                                let alert = UIAlertController(title: "Alert", message: "Invalid User", preferredStyle: .alert)

                                

                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                                

                                self.present(alert, animated: true, completion: nil)

                            }

                            

                        }

                    }

                }

                catch{ print("error",error.localizedDescription) }

            }; task.resume()

        }

  }


    
    @IBAction func guestlogin(_ sender: Any) {
        let sttoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextpage1 = sttoryboard.instantiateViewController(identifier: "tab")as! tabViewController
        self.navigationController?.pushViewController(nextpage1, animated: true)
    }
    private func homepage() {
        let sttoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextpage1 = sttoryboard.instantiateViewController(identifier: "tab")as! tabViewController
        self.navigationController?.pushViewController(nextpage1, animated: true)
    }
}
