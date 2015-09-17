//
//  ScorecardDetailsViewController.swift
//  BowlingScorecard
//
//  Created by Admin on 2015-08-27.
//  Copyright (c) 2015 infoshare. All rights reserved.
//
import Foundation
import UIKit
import CoreData

extension String {
    
    // Returns true if the string represents a proper numeric value.
    // This method uses the device's current locale setting to determine
    // which decimal separator it will accept.
    func isNumeric() -> Bool
    {
        let scanner = NSScanner(string: self)
        
        // A newly-created scanner has no locale by default.
        // We'll set our scanner's locale to the user's locale
        // so that it recognizes the decimal separator that
        // the user expects (for example, in North America,
        // "." is the decimal separator, while in many parts
        // of Europe, "," is used).
        scanner.locale = NSLocale.currentLocale()
        
        return scanner.scanDecimal(nil) && scanner.atEnd
    }
    
}


class ScorecardDetailsViewController: UIViewController, UITextFieldDelegate {

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
        //
        initFields()
        //
        initDefaults()
        //
        bowlingDatePicker.datePickerMode = UIDatePickerMode.Date
        //
        if existingScorecard != nil
        {
            calcTotalGamesAndAverage()
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func initFields()
    {
        game1Text.delegate = self
        game1Text.keyboardType = UIKeyboardType.NumberPad
        //
        game2Text.delegate = self
        game2Text.keyboardType = UIKeyboardType.NumberPad
        //
        game3Text.delegate = self
        game3Text.keyboardType = UIKeyboardType.NumberPad

    }
    func initDefaults()
    {
        //
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
    }
    func calcTotalGamesAndAverage()
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
    @IBAction func gameScoreEditing(sender: UITextField) {
        //
        // Calculate Total Games
        var totalCnt = 0
        totalGames = 0
        averageGames = 0
        if let game1 = game1Text.text.toInt()
        {
            totalGames += game1
            totalCnt += 1
        }
        if let game2 = game2Text.text.toInt()
        {
            totalCnt += 1
            totalGames += game2
        }
        if let game3 = game3Text.text.toInt()
        {
            totalCnt += 1
            totalGames += game3
        }
        //
        if totalCnt != 0
        {
            averageGames = totalGames / totalCnt
        }
        totalGamesText.text = "Total: \(totalGames)"
        averageText.text = "Average: \(averageGames)"
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        // We still return true to allow the change to take place.
        if count(string) == 0 {
            return true
        }
        // Check to see if the text field's contents still fit the constraints
        // with the new content added to it.
        // If the contents still fit the constraints, allow the change
        // by returning true; otherwise disallow the change by returning false.
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        switch textField {
            
            // Allow only values that evaluate to proper numeric values in this field,
            // and limit its contents to between 0 and 450.
            case game1Text
                , game2Text
                , game3Text:
                if let gameScore = prospectiveText.toInt()
                {
                    if (gameScore >= 0) && (gameScore <= 450)
                    {
                        return true
                    }
                }
        default:
                return false
        }
        //
        return false
    }
    @IBAction func saveTapped(sender: AnyObject)
    {
        
        let game1 = game1Text.text.toInt() ?? 0
        let game2 = game2Text.text.toInt() ?? 0
        let game3 = game3Text.text.toInt() ?? 0
        //
        if existingScorecard != nil
        {
            if let eIP = existingIP
            {
                existingScorecard?.leagueName = lName
                existingScorecard?.leagueSeason = lSession
                existingScorecard?.bowlerName = bName
                existingScorecard?.bowlingDate = bowlingDatePicker.date
                existingScorecard?.gameScore1 = game1
                existingScorecard?.gameScore2 = game2
                existingScorecard?.gameScore3 = game3
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
                ,gameScore1: game1
                ,gameScore2: game2
                ,gameScore3: game3
            )
        }
        //
        // Navigate back to root vc
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
