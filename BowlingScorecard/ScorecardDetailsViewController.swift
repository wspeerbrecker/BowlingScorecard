//
//  ScorecardDetailsViewController.swift
//  BowlingScorecard
//
//  Created by Admin on 2015-08-27.
//  Copyright (c) 2015 infoshare. All rights reserved.
//

import UIKit
import CoreData

class ScorecardDetailsViewController: UIViewController {

    var mySCModel = ScorecardModel()
    var defaultSC = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 
        let tbvc = self.tabBarController  as! ScorecardTabBarController
        mySCModel = tbvc.myScorecardModel
    }
    
    @IBAction func saveTapped(sender: AnyObject)
    {
    
        // Reference to our app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // Reference moc
        let context: NSManagedObjectContext = appDel.managedObjectContext!

        // Create instance of our data model and initilize
        var newItem = NSEntityDescription.insertNewObjectForEntityForName("Scorecard", inManagedObjectContext: context) as! Scorecard
        // Map our properties
        newItem.leagueName = "Test" //defaultSC.stringForKey("LeagueName")!
        newItem.leagueSeason = "FALL" //defaultSC.stringForKey("LeagueSeason")!
        newItem.bowlerName = "Wes Speer" //defaultSC.stringForKey("bowlersName")!
        newItem.bowlingDate = NSDate()
        newItem.gameScore1 = 100
        newItem.gameScore2 = 200
        newItem.gameScore3 = 300
        // Save our contents
        context.save(nil)
        
        // Navigate back to root vc
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
