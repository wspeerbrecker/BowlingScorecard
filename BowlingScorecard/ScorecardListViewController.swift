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
    var selectedScorecard : Scorecard? = nil
    var selectedIP : NSIndexPath?
    var totalNoOfGames = 0
    var totalScores = 0
    
    @IBOutlet weak var tableViewSC: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let tbvc = self.tabBarController  as! ScorecardTabBarController
        mySCModel = tbvc.myScorecardModel
        totalNoOfGames = 0
        totalScores = 0
    }

    override func viewDidAppear(animated: Bool) {
        //
        // Retrieve all of the Scorecard records from the Model.
        mySCModel.myScorecardList = mySCModel.FetchAllEntityRecs("Scorecard")
        //
        totalNoOfGames = 0
        totalScores = 0
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
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let strDate = dateFormatter.stringFromDate(data.bowlingDate)
            //
            cell.bowlingDateLabel.text = strDate
            cell.game1Label.text = "\(data.gameScore1)"
            cell.game2Label.text = "\(data.gameScore2)"
            cell.game3Label.text = "\(data.gameScore3)"
            //
            var noOfGames = 0
            var tempTriple = 0
            var tempAverage = 0
            var tempSeasonAverage = 0
            if let game1 = data.gameScore1 as? Int
            {
                tempTriple += game1
                noOfGames += 1
            }
            //
            if let game2 = data.gameScore2 as? Int
            {
                tempTriple += game2
                noOfGames += 1
            }
            //
            if let game3 = data.gameScore3 as? Int
            {
                tempTriple += game3
                noOfGames += 1
            }
            if (noOfGames != 0) && (tempTriple != 0)
            {
                tempAverage = tempTriple / noOfGames
                totalNoOfGames += noOfGames
                totalScores += tempTriple
            }
            cell.totalLabel.text = "Total: \(tempTriple)"
            cell.averageLabel.text = "Avg: \(tempAverage)"
            if (totalNoOfGames != 0) && (totalScores != 0)
            {
                tempSeasonAverage = totalScores / totalNoOfGames
                cell.seasonAvgLabel.text = "Season Avg: \(tempSeasonAverage)"
            }
        }
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedScorecard = mySCModel.myScorecardList[indexPath.row]
        selectedIP = indexPath
        self.performSegueWithIdentifier("updateSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "updateSegue"
        {
            var SDViewController = segue.destinationViewController as! ScorecardDetailsViewController
            SDViewController.existingScorecard = selectedScorecard
            SDViewController.existingIP = selectedIP
        }
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // Reference to our app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // Reference moc
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            if let tv = tableView as UITableView?
            {
                mySCModel.deleteData(indexPath)
                tv.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                
            }
            var error: NSError? = nil
            if !context.save(&error)
            {
                abort()
            }
        }
    }

}

