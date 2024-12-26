//
//  aboutusViewController.swift
//  main project meatshop
//
//  Created by irohub on 05/12/24.
//

import UIKit

class aboutusViewController: UIViewController {

    @IBOutlet weak var back: UIButton!
    override func viewDidLoad() {
           super.viewDidLoad()
           
           // Setup the back button action
           back.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
       }

       @objc func backButtonTapped() {
           // Check if there's a navigation controller and pop the current view controller
           if let navigationController = self.navigationController {
               navigationController.popViewController(animated: true)
           } else {
               // If there's no navigation controller, dismiss the current view controller
               self.dismiss(animated: true, completion: nil)
           }
       }
   }
   
