//
//  IntroViewController.swift
//  safeforest
//
//  Created by Dmitry Baryshnikov on 15.10.16.
//  Copyright © 2016 NextGIS. All rights reserved.
//

import UIKit
import BWWalkthrough

class IntroViewController: UIViewController, BWWalkthroughViewControllerDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let prefs = UserDefaults.standard
        if !prefs.bool(forKey: Constants.firstLaunch) {
            self.view.isHidden = false
        } else {
            self.view.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let prefs = UserDefaults.standard
        if !prefs.bool(forKey: Constants.firstLaunch) { // show intro
            showWalkthrough()
            
            //prefs.set(true, forKey: Constants.firstLaunch)
            //prefs.synchronize()
        } else { // go to next screen
            self.performSegue(withIdentifier: "master", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showWalkthrough(){
        
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let walkthrough = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as! BWWalkthroughViewController
        let page1 = storyboard.instantiateViewController(withIdentifier: "page1")
        let page2 = storyboard.instantiateViewController(withIdentifier: "page2")
        let page3 = storyboard.instantiateViewController(withIdentifier: "page3")
        let page4 = storyboard.instantiateViewController(withIdentifier: "page4")
        
        // Attach the pages to the master
        walkthrough.delegate = self
        walkthrough.addViewController(page1)
        walkthrough.addViewController(page2)
        walkthrough.addViewController(page3)
        walkthrough.addViewController(page4)
        
        self.present(walkthrough, animated: true, completion: nil)
    }
    
    
    // MARK: Walkthrough delegate
    
    func walkthroughPageDidChange(_ pageNumber: Int) {
        print("Current Page \(pageNumber)")
    }
    
    func walkthroughCloseButtonPressed() {
        self.performSegue(withIdentifier: "master", sender: self)
        //self.dismiss(animated: true, completion: nil)
    }
}
