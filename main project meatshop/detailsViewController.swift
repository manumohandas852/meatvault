import UIKit

class detailsViewController: UIViewController {
    var recipeData: [String: Any]?
    var selectedImageName: String?

    @IBOutlet weak var NAME: UILabel!
    @IBOutlet weak var incredients: UILabel!
    @IBOutlet weak var mindescription: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var recepieimage: UIImageView!
    @IBOutlet weak var cals: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var howtocook: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let recipeId = UserDefaults.standard.string(forKey: "selectedRecipeID") {
            print("Selected Recipe ID: \(recipeId)")
            fetchRecipeDetails(recipeId: recipeId)
            addGradientToImage()
        }
    }

    func fetchRecipeDetails(recipeId: String) {
        guard let userID = UserDefaults.standard.string(forKey: "MyKey") else {
            print("Error: User ID not found in UserDefaults")
            return
        }
        
        // API endpoint
        let apiEndpoint = "https://meatshop.b4production.com/index.php?route=api/completeapi/recipe&api_token"
        
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
        let postString = "user_id=\(userID)&recipe_id=\(recipeId)&key=\("koFCpCMzm8hhn9ULj0BnUzZkpqM3rg9Mqdii3FwPRjBwZFQWriIJYgB5jjOhNIyasSl4RrmCFLW3tHDRtI39viQbYEP7nEkYvba2wstThYWjvkndZq0zaXJaWjuqeZo8vR3MMHa6OhBDKsFPmWOlIM4H1TgB1fudQndGKzUPg8YhAoaAoCxZ562zjbQdPO73ZkwyPV7iOIkyH11ZLAN42a5dgLH22Rs1VasEWBKdfkqMLPfDbLQpF9Ofqah4fqwc")"
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
                   let recipeData = jsonData["data"] as? [String: Any],
                   let recipe = recipeData["recipie"] as? [String: Any] {
                    
                    // Successfully fetched and parsed the recipe data
                    DispatchQueue.main.async {
                        self.updateUI(with: recipe)
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

    func updateUI(with recipe: [String: Any]) {
        NAME.text = recipe["name"] as? String
        mindescription.text = recipe["min_description"] as? String
        incredients.text = recipe["ingredients"] as? String
        label.text = recipe["name"] as? String
        cals.text = "Calories: \(recipe["cals"] as? String ?? "N/A")"
        time.text = "Time: \(recipe["time"] as? String ?? "N/A") mins"
        howtocook.text = recipe["description"] as? String

        // Use the selected image passed from the previous view controller
        if let imageName = selectedImageName {
            recepieimage.image = UIImage(named: imageName) // Display the local image
        } else {
            recepieimage.image = UIImage(named: "placeholder") // Placeholder if no image name is available
        }
    }

    

    func addGradientToImage() {
        let gradient = CAGradientLayer()
        gradient.frame = recepieimage.bounds
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor,
            UIColor.black.cgColor
        ]
        gradient.locations = [0.6, 0.85, 1.0]
        recepieimage.layer.addSublayer(gradient)
    }

    @IBAction func back(_ sender: Any) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
