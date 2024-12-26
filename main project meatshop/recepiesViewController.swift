//
//  recepiesViewController.swift
//  main project meatshop
//
//  Created by irohub on 10/12/24.
//

import UIKit

class recepiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionview: UICollectionView!
    var recepies: [[String: Any]] = []
    let image = ["fishcurry","karimeenpollichathu","fishfingers","fishroast","fishmappas","chickenroast","crabsukka","friedprawnss","grilledsquid"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.delegate = self
        collectionview.dataSource = self
        fetchCategoriesData()
    }
    
    private func fetchCategoriesData() {
        // Get user ID from UserDefaults
        guard let userID = UserDefaults.standard.string(forKey: "MyKey") else {
            print("Error: User ID not found in UserDefaults")
            return
        }
        
        // API endpoint
        let apiEndpoint = "https://meatshop.b4production.com/index.php?route=api/completeapi/getRecipes&api_token="
        
        // Construct URL for API
        guard let url = URL(string: apiEndpoint) else {
            print("Error: Invalid URL")
            return
        }
        
        // Prepare POST request
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // Set up the post string with userID and other required parameters
        let postString = "user_id=\(userID)&key=koFCpCMzm8hhn9ULj0BnUzZkpqM3rg9Mqdii3FwPRjBwZFQWriIJYgB5jjOhNIyasSl4RrmCFLW3tHDRtI39viQbYEP7nEkYvba2wstThYWjvkndZq0zaXJaWjuqeZo8vR3MMHa6OhBDKsFPmWOlIM4H1TgB1fudQndGKzUPg8YhAoaAoCxZ562zjbQdPO73ZkwyPV7iOIkyH11ZLAN42a5dgLH22Rs1VasEWBKdfkqMLPfDbLQpF9Ofqah4fqwc"
        request.httpBody = postString.data(using: .utf8)
        
        // Start the data task
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Error: No data received")
                return
            }
            
            do {
                // Parse the JSON data
                if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let recipes = jsonData["data"] as? [[String: Any]] {
                    
                    // Successfully fetched and parsed categories
                    self.recepies = recipes
                    
                    // Update UI on the main thread
                    DispatchQueue.main.async {
                        self.collectionview.reloadData()
                    }
                } else {
                    print("Error: Invalid response format")
                }
            } catch {
                print("Error: JSON parsing failed - \(error.localizedDescription)")
            }
        }
        
        // Execute the task
        task.resume()
    }
    
    // Collection View Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recepies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "foodie", for: indexPath) as? foodsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let recipe = recepies[indexPath.row]
        cell.foodname.text = recipe["name"] as? String
        cell.difficult.text = "Calories: \(recipe["cals"] as? String ?? "Unknown")"
        cell.time.text = "Time: \(recipe["time"] as? String ?? "Unknown")"
        
        // Use the local image array instead of the image URL from the API
        if indexPath.row < image.count {
            let imageName = image[indexPath.row]
            cell.img.image = UIImage(named: imageName) // Load image from local assets
        } else {
            cell.img.image = UIImage(named: "placeholder") // Placeholder image if index is out of bounds
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Get the selected recipe
        let selectedRecipe = recepies[indexPath.row]
        
        // Save the "id" of the selected recipe to UserDefaults
        if let recipeId = selectedRecipe["id"] as? String {
            UserDefaults.standard.set(recipeId, forKey: "selectedRecipeID")
        }
        
        // Get the corresponding image from the local image array
        let selectedImageName = image[indexPath.row]
        
        // Navigate to the details view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsVC = storyboard.instantiateViewController(identifier: "recep") as? detailsViewController {
            detailsVC.recipeData = selectedRecipe
            detailsVC.selectedImageName = selectedImageName // Pass the image name to the detailsVC
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    // Back Button Action
    @IBAction func back(_ sender: Any) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
