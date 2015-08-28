//
//  ScorecardModel.swift
//  BowlingScorecard
//
//  Created by Admin on 2015-08-27.
//  Copyright (c) 2015 infoshare. All rights reserved.
//

import UIKit
import CoreData

class ScorecardModel: NSObject
{

    var myScorecardList : [Scorecard] = []
    // Reference to our app delegate
    var appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    func saveData(leagueName: String
        ,leagueSeason: String
        ,bowlerName: String
        ,bowlingDate: NSDate
        ,gameScore1: NSNumber
        ,gameScore2: NSNumber
        ,gameScore3: NSNumber)
    {
        // Reference moc
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        // Create instance of our data model and initilize
        var newItem = NSEntityDescription.insertNewObjectForEntityForName("Scorecard", inManagedObjectContext: context) as! Scorecard
        // Map our properties
        newItem.leagueName = leagueName
        newItem.leagueSeason = leagueSeason
        newItem.bowlerName = bowlerName
        newItem.bowlingDate = bowlingDate
        newItem.gameScore1 = gameScore1
        newItem.gameScore2 = gameScore2
        newItem.gameScore3 = gameScore3
        // Save our contents
        context.save(nil)
    }
}

