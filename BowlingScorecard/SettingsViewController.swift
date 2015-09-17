//
//  SettingsViewController.swift
//  BowlingScorecard
//
//  Created by Admin on 2015-08-27.
//  Copyright (c) 2015 infoshare. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var leagueNameText: UITextField!
    @IBOutlet weak var leagueSeasonText: UITextField!
    @IBOutlet weak var bowlersNameText: UITextField!
    
    var scorecardDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let lname = scorecardDefaults.stringForKey("LeagueName")
        {
            leagueNameText.text = lname
        }
        if let lseason = scorecardDefaults.stringForKey("LeagueSeason")
        {
            leagueSeasonText.text = lseason
        }
        if let bname = scorecardDefaults.stringForKey("BowlersName")
        {
            bowlersNameText.text = bname
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }

    @IBAction func saveTapped(sender: AnyObject)
    {
        //
        scorecardDefaults.setObject(leagueNameText.text, forKey: "LeagueName")
        scorecardDefaults.setObject(leagueSeasonText.text, forKey: "LeagueSeason")
        scorecardDefaults.setObject(bowlersNameText.text, forKey: "BowlersName")
        scorecardDefaults.synchronize()
        
    }
}
