//
//  Page3ViewController.swift
//  TIFT
//
//  Created by Terence Williams on 1/27/22.
//

import UIKit

class Page3ViewController: UIViewController {

    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        actionButton.layer.cornerRadius = 5
        actionButton.addTarget(self, action: #selector(goToPage2), for: .touchUpInside)
        
        DispatchQueue.main.async {
            self.backgroundImageView.image = UIImage(named: "road3")
        }

    }
    
    @objc func goToPage2() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "continueWalkthrough"),
        object: nil,
        userInfo: nil)
    }
}
