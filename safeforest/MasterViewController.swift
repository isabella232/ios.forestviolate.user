//
//  MasterViewController.swift
//  safeforest
//
//  Created by Дмитрий Барышников on 12.10.16.
//  Copyright © 2016 NextGIS. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        
        // TODO:
        if UserDefaults.standard.bool(forKey: Constants.firstLaunch) {
            print("First launch. Show intro")
            // Show intro
        } else {
            print("Normal launch")
            // Normal view
        }
    }*/
    
    func setupView() {
        setupSegmentedControl()
        updateView()
    }
    
    func selectionDidChange(sender: UISegmentedControl) {
        updateView()
    }
    
    func setupSegmentedControl() {
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        let listText = NSLocalizedString("List", comment: "List segment name")
        let mapText = NSLocalizedString("Map", comment: "Map segment name")
        
        segmentedControl.insertSegment(withTitle: listText, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: mapText, at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(MasterViewController.selectionDidChange), for: .valueChanged)
        
        // Select First Segment
        segmentedControl.selectedSegmentIndex = 0
    }
    
    lazy var listViewController: ListViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        
        // Add View Controller as Child View Controller
        self.addViewControllerAsChildViewController(viewController: viewController)
        
        return viewController
    }()
    
    lazy var mapViewController: MapViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        // Add View Controller as Child View Controller
        self.addViewControllerAsChildViewController(viewController: viewController)
        
        return viewController
    }()
    
    private func addViewControllerAsChildViewController(viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func removeViewControllerAsChildViewController(viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    func updateView() {
        listViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        mapViewController.view.isHidden = (segmentedControl.selectedSegmentIndex == 0)
    }
}
