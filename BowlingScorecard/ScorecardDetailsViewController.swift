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
    var totalText = "Total: "
    var totalGames = 0
    
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
        //
        bowlingDatePicker.datePickerMode = UIDatePickerMode.Date
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
        mySCModel.saveData(
            defaultSC.stringForKey("LeagueName")!
            ,leagueSeason: defaultSC.stringForKey("LeagueSeason")!
            ,bowlerName: defaultSC.stringForKey("BowlersName")!
            ,bowlingDate: bowlingDatePicker.date
            ,gameScore1: game1Text.text.toInt()!
            ,gameScore2: game2Text.text.toInt()!
            ,gameScore3: game3Text.text.toInt()!
        )
        //
        // Navigate back to root vc
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
