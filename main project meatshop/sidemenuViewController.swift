//
//  sidemenuViewController.swift
//  main project meatshop
//
//  Created by irohub on 10/12/24.
//

import UIKit

class sidemenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var person: UIImageView!
    
    @IBOutlet weak var tableview: UITableView!
    let contents = ["Login","Edit Profile","All Products","Refer and Earn","Offers","Recipes","FAQ","About Us","Contact Us"]
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableview.delegate = self
                  tableview.dataSource = self

                  // Hide separators
                  tableview.separatorStyle = .none  // This hides the lines

                  // Optionally, hide the separator for empty rows
                  tableview.tableFooterView = UIView()
            person.layer.cornerRadius = person.frame.size.width / 2
                person.clipsToBounds = true
                
                // Optional: Set the border color and width (if desired)
                person.layer.borderColor = UIColor.white.cgColor // For example, a white border
                person.layer.borderWidth = 0
            
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // Total rows = 1 for the manually added first cell + array count
            return contents.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
                // Return dynamic cells for array items
                let cell = tableView.dequeueReusableCell(withIdentifier: "sidemenu", for: indexPath) as! sideTableViewCell
            cell.label.text = contents[indexPath.row]
            cell.symbol.image = UIImage(named: contents[indexPath.row
            ])
                return cell
        }

        // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            
            // Navigate to the selected page
            switch indexPath.row {
            case 0:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc1 = storyboard.instantiateViewController(withIdentifier: "main")as! ViewController
                self.navigationController?.pushViewController(vc1, animated: true)
            case 1:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc2 = storyboard.instantiateViewController(withIdentifier: "ed")as! editViewController
                self.navigationController?.pushViewController(vc2, animated: true)
            case 2:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc2 = storyboard.instantiateViewController(withIdentifier: "fresh")as! freshfishViewController
                self.navigationController?.pushViewController(vc2, animated: true)
            case 3:
                print("refer and earn")
            case 4:
                print("offers")
            case 5:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc3 = storyboard.instantiateViewController(withIdentifier: "rece")as! recepiesViewController
                self.navigationController?.pushViewController(vc3, animated: true)
            case 6:
                print("FAQ")
            case 7:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc4 = storyboard.instantiateViewController(withIdentifier: "about")as! aboutusViewController
                self.navigationController?.pushViewController(vc4, animated: true)
            case 8:
                print("contact us")
                
            default:
                break
            }
        }

            
        }
        // MARK: - UITableViewDataSource
        

