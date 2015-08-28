//
//  ViewController.swift
//  BowlingScorecard
//
//  Created by Admin on 2015-08-27.
//  Copyright (c) 2015 infoshare. All rights reserved.
//

import UIKit
import CoreData

class ScorecardListViewController: UIViewController {

    var mySCModel = ScorecardModel()
    
    @IBOutlet weak var tableViewSC: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //
        let tbvc = self.tabBarController  as! ScorecardTabBarController
        mySCModel = tbvc.myScorecardModel
        
    }

    override func viewDidAppear(animated: Bool) {
        
        // Reference to our app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // Reference moc
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "Scorecard")
        
        var results = context.executeFetchRequest(freq, error: nil)
        if results != nil
        {
            mySCModel.myScorecardList = results! as! [Scorecard]
            var ls = mySCModel.myScorecardList[0].leagueSeason
        }
        tableViewSC.reloadData()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return mySCModel.myScorecardList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellID = "Cell"
        var cell: ScorecardTableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID) as! ScorecardTableViewCell
        
        if let ip = indexPath as NSIndexPath?
        {
            var data: Scorecard = mySCModel.myScorecardList[ip.row]
            cell.bowlingDateLabel.text = "\(data.bowlingDate)"
            cell.game1Label.text = "\(data.gameScore1)"
            cell.game2Label.text = "\(data.gameScore2)"
            cell.game3Label.text = "\(data.gameScore3)"
        }
        
        return cell
    }

}

