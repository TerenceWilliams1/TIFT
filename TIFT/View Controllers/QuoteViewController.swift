//
//  QuoteViewController.swift
//  TIFT
//
//  Created by Terence Williams on 1/4/22.
//

import UIKit

class QuoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!

    var quotes: [Quote] = []
    var index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        scrollToQuote(_atIndex: index)
    }
    
    func setupData() {
        self.table.decelerationRate = UIScrollView.DecelerationRate.fast

        NotificationCenter.default.addObserver(self, selector: #selector(self.shareQuote(_fromNotification:)),
                                               name: NSNotification.Name(rawValue: "shareQuote"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.saveQuote(_fromNotification:)),
                                               name: NSNotification.Name(rawValue: "saveQuote"),
                                               object: nil)
    }
    
    //MARK: - Helpers
    func scrollToQuote(_atIndex index: Int) {
        let quoteIndexPath = IndexPath(row: index, section: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.table.scrollToRow(at: quoteIndexPath, at: UITableView.ScrollPosition.top, animated: true)
        }
    }
    
    //MARK: - Actions
    @objc func shareQuote(_fromNotification notification: NSNotification) {
        if let quote = notification.userInfo?["quote"] as? String,
            let author = notification.userInfo?["author"] as? String {
            let shareAll = [quote, author] as [Any]
            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    @objc func saveQuote(_fromNotification notification: NSNotification) {
        if let indexPath = notification.userInfo?["indexPath"] as? IndexPath {
            self.table.cellForRow(at: indexPath)?.contentView.backgroundColor = UIColor.systemGroupedBackground
            let quoteData = self.table.cellForRow(at: indexPath)?.contentView.asImage().pngData()
            self.table.cellForRow(at: indexPath)?.contentView.backgroundColor = .clear
            
            UIImageWriteToSavedPhotosAlbum((UIImage(data: quoteData!) ?? UIImage(named: ""))!, self, nil, nil)
            
            let message = "Quote Saved Successfully"
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.present(alert, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
    }

    //MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteTableViewCell", for: indexPath) as? QuoteTableViewCell
        
        let quote = quotes[indexPath.row]
        cell?.quoteLabel.text = quote.quote
        cell?.authorLabel.text = "- \(quote.author)"
        cell?.quoteIndexPath = indexPath
        return cell!
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            centerTableView()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        centerTableView()
    }
    
    func centerTableView() {
        let centerPath: IndexPath = table.indexPathForRow(at: CGPoint(x: table.bounds.midX, y: table.bounds.midY))!
        table.scrollToRow(at: centerPath, at: .middle, animated: true)
    }
}
