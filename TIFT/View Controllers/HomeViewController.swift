//
//  HomeViewController.swift
//  TIFT
//
//  Created by Terence Williams on 1/5/22.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var quotes: [Quote] = []
    var collection: Collection!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuotes()

        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchQuotes()
    }
    
    func setupUI() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        let highlightedQuoteCollectionViewCell = UINib(nibName: "HighlightedQuoteCollectionViewCell", bundle: nil)
        collectionView.register(highlightedQuoteCollectionViewCell, forCellWithReuseIdentifier: "HighlightedQuoteCollectionViewCell")
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
                    self.collectionView.reloadData()
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
    
    //MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let collection = collection {
            return collection.highlights.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HighlightedQuoteCollectionViewCell", for: indexPath) as? HighlightedQuoteCollectionViewCell
        
        let highlight = collection.highlights[indexPath.row]
        cell?.quoteLabel.text = highlight.quote
        cell?.authorLabel.text = highlight.author
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let quoteViewController = storyBoard.instantiateViewController(withIdentifier: "QuoteViewController") as! QuoteViewController
        quoteViewController.quotes = collection.highlights
        quoteViewController.index = indexPath.row
        self.navigationController?.pushViewController(quoteViewController, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.collectionView.scrollToNearestVisibleCollectionViewCell()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.collectionView.scrollToNearestVisibleCollectionViewCell()
        }
    }

}
