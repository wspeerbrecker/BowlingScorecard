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
    var existingScorecard : Scorecard? = nil
    var existingIP : NSIndexPath?
    
    var defaultSC = NSUserDefaults.standardUserDefaults()
    var totalText = "Total: "
    var totalGames = 0
    var averageGames = 0
    var noOfGames = 0
    var lName = ""
    var lSession = ""
    var bName = ""
    
    @IBOutlet weak var bowlersNameText: UILabel!
    @IBOutlet weak var bowlingDatePicker: UIDatePicker!
    @IBOutlet weak var game1Text: UITextField!
    @IBOutlet weak var game2Text: UITextField!
    @IBOutlet weak var game3Text: UITextField!
    @IBOutlet weak var totalGamesText: UILabel!
    @IBOutlet weak var averageText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 
        let tbvc = self.tabBarController  as! ScorecardTabBarController
        mySCModel = tbvc.myScorecardModel
        if let tempbName = defaultSC.stringForKey("BowlersName")
        {
            bowlersNameText.text = tempbName
            bName = tempbName
        }
        if let templName = defaultSC.stringForKey("LeagueName")
        {
            lName = templName
        }
        if let templSession = defaultSC.stringForKey("LeagueSession")
        {
            lSession = templSession
        }
        //
        bowlingDatePicker.datePickerMode = UIDatePickerMode.Date
        //
        if existingScorecard != nil
        {
            if let bDate = existingScorecard?.bowlingDate
            {
                bowlingDatePicker.date = bDate
            }
            if let game1 = existingScorecard?.gameScore1 as? Int
            {
                game1Text.text = "\(game1)"
                totalGames = game1
                noOfGames += 1
            }
            if let game2 = existingScorecard?.gameScore2 as? Int
            {
                game2Text.text = "\(game2)"
                totalGames += game2
                noOfGames += 1
            }
            if let game3 = existingScorecard?.gameScore3 as? Int
            {
                game3Text.text = "\(game3)"
                totalGames += game3
                noOfGames += 1
            }
            // Calculate Average
            averageGames = totalGames / noOfGames
            //
            totalGamesText.text = "Total: \(totalGames)"
            averageText.text = "Average: \(averageGames)"
        }
    }
    
    @IBAction func gameScoreEditing(sender: UITextField) {
        
        if let game1 = sender.text.toInt()
        {
            totalGames += game1
            totalGamesText.text = "Total: \(totalGames)"
        }
    }
    @IBAction func saveTapped(sender: AnyObject)
    {
        //
        if existingScorecard != nil
        {
            if let eIP = existingIP
            {
                existingScorecard?.leagueName = lName
                existingScorecard?.leagueSeason = lSession
                existingScorecard?.bowlerName = bName
                existingScorecard?.bowlingDate = bowlingDatePicker.date
                existingScorecard?.gameScore1 = game1Text.text.toInt()!
                existingScorecard?.gameScore2 = game2Text.text.toInt()!
                existingScorecard?.gameScore3 = game3Text.text.toInt()!
                //
                mySCModel.myScorecardList[eIP.row] = existingScorecard!
                //
                //let oid = existingScorecard?.objectID
                mySCModel.updateData()
            }
        }
        else {

            mySCModel.saveData(
                lName
                ,leagueSeason: lSession
                ,bowlerName: bName
                ,bowlingDate: bowlingDatePicker.date
                ,gameScore1: game1Text.text.toInt()!
                ,gameScore2: game2Text.text.toInt()!
                ,gameScore3: game3Text.text.toInt()!
            )
        }
        //
        // Navigate back to root vc
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
