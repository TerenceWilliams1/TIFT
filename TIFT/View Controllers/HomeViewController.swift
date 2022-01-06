//
//  HomeViewController.swift
//  TIFT
//
//  Created by Terence Williams on 1/5/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var quotes: [Quote] = []
    var collection: Collection!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchQuotes()
    }

    func fetchQuotes() {
        URLCache.shared.removeAllCachedResponses()

        guard let artistURL = URL(string: "https://terencewilliams1.github.io/TIFT/data.json") else { return }
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        session.dataTask(with: artistURL) { (data, response
            , error) in
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                self.collection = nil
                let collectionData = try decoder.decode(Collection.self, from: data)
                self.collection = collectionData
                DispatchQueue.main.async {
                    print("\n\n***Successfully loaded quotes***\n\n")
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                }
            } catch let err {
                print("Error Loading: ", err)
            }
            print(data)
            }.resume()
    }
    
    //MARK: - Actions
    @IBAction func exploreAll() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let quoteViewController = storyBoard.instantiateViewController(withIdentifier: "QuoteViewController") as! QuoteViewController
        let category = collection.categories[0]
        quoteViewController.quotes = category.quotes
        self.navigationController?.pushViewController(quoteViewController, animated: true)
    }

}
