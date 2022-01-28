//
//  WalkThroughViewController.swift
//  TIFT
//
//  Created by Terence Williams on 1/27/22.
//

import UIKit

class WalkThroughPageViewController: UIPageViewController {

    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "Page3"),
            self.getViewController(withIdentifier: "Page1"),
            self.getViewController(withIdentifier: "Page2")
        ]
    }()
        
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    required init?(coder aDecoder: NSCoder?) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate   = self
        
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.closeView),
        name: NSNotification.Name(rawValue: "closeWalkthrough"),
        object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.moveToNext),
        name: NSNotification.Name(rawValue: "continueWalkthrough"),
        object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.moveToNext1),
        name: NSNotification.Name(rawValue: "continueWalkthrough1"),
        object: nil)

    }
    
    override var prefersStatusBarHidden: Bool {
      return true
    }
    
    //MARK: - Actions
    @objc func closeView() {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func moveToNext() {
        self.setViewControllers([pages[1]], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func moveToNext1() {
        self.setViewControllers([pages[2]], direction: .forward, animated: true, completion: nil)
    }
}

extension WalkThroughPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
         
        guard previousIndex >= 0
            else {
                return nil
            }
        
        guard pages.count > previousIndex
            else {
                return nil
            }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count
            else {
                return nil
            }
        
        guard pages.count > nextIndex
            else {
                return nil
            }
        
        return pages[nextIndex]
    }
    
    func pageViewControllerPreferredInterfaceOrientationForPresentation(_ pageViewController: UIPageViewController) -> UIInterfaceOrientation {
        return .portrait
    }
}

extension WalkThroughPageViewController: UIPageViewControllerDelegate { }

