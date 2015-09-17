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
    //
    struct overallStats {
        var totalGames = 0
        var totalSessions = 0
        var seasonTotal = 0
        var seasonAvg = 0
        var highestTriple = 0
        var highestTripleDate : NSDate = NSDate()
        var highestSingle = 0
        var highestSingleDate : NSDate = NSDate()
        var lowestTriple = 999
        var lowestTripleDate : NSDate = NSDate()
        var lowestSingle = 999
        var lowestSingleDate : NSDate = NSDate()
    }
    
    // Reference to our app delegate
    var appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    func FetchAllEntityRecs(eName: String) -> [Scorecard]
    {
        // Reference moc
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        //
        let freq = NSFetchRequest(entityName: eName)
        freq.sortDescriptors = [NSSortDescriptor(key: "bowlingDate", ascending: false)]
        //
        var results = context.executeFetchRequest(freq, error: nil)
        //
        return results as! [Scorecard]
    }
    
    func saveData(leagueName: String
        ,leagueSeason: String
        ,bowlerName: String
        ,bowlingDate: NSDate
        ,gameScore1: NSNumber?
        ,gameScore2: NSNumber?
        ,gameScore3: NSNumber?)
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
        if gameScore1 != nil
        { newItem.gameScore1 = gameScore1! }
        if gameScore2 != nil
        { newItem.gameScore2 = gameScore2! }
        if gameScore3 != nil
        { newItem.gameScore3 = gameScore3! }
        // Save our contents
        context.save(nil)
    }
    //
    func updateData()
    {
        // Reference moc
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        // Save our contents
        context.save(nil)
    }
    func deleteData(existingSCindexPath: NSIndexPath)
    {
        // Reference moc
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        // Delete the managed object
        context.deleteObject(myScorecardList[existingSCindexPath.row])
        // Delete item from array of managed objects
        myScorecardList.removeAtIndex(existingSCindexPath.row)
    }
    func calculateStats() -> overallStats
    {
        var ostats = overallStats()
        //
        // Reference to our app delegate
        for myScorecardRec in myScorecardList
        {
            var tempTriple = 0
            ostats.totalSessions += 1
            if let game1 = myScorecardRec.gameScore1 as? Int
            {
                tempTriple += game1
                ostats.totalGames += 1
                ostats.seasonTotal += game1
                if game1 >= ostats.highestSingle
                {
                    ostats.highestSingle = game1
                    ostats.highestSingleDate = myScorecardRec.bowlingDate
                }
                if game1 < ostats.lowestSingle
                {
                    ostats.lowestSingle = game1
                    ostats.lowestSingleDate = myScorecardRec.bowlingDate
                }
            }
            //
            if let game2 = myScorecardRec.gameScore2 as? Int
            {
                tempTriple += game2
                ostats.totalGames += 1
                ostats.seasonTotal += game2
                if game2 >= ostats.highestSingle
                {
                    ostats.highestSingle = game2
                    ostats.highestSingleDate = myScorecardRec.bowlingDate
                }
                if game2 < ostats.lowestSingle
                {
                    ostats.lowestSingle = game2
                    ostats.lowestSingleDate = myScorecardRec.bowlingDate
                }
            }
            //
            if let game3 = myScorecardRec.gameScore3 as? Int
            {
                tempTriple += game3
                ostats.totalGames += 1
                ostats.seasonTotal += game3
                if game3 >= ostats.highestSingle
                {
                    ostats.highestSingle = game3
                    ostats.highestSingleDate = myScorecardRec.bowlingDate
                }
                if game3 < ostats.lowestSingle
                {
                    ostats.lowestSingle = game3
                    ostats.lowestSingleDate = myScorecardRec.bowlingDate
                }
            }
            //
            if tempTriple > ostats.highestTriple
            {
                ostats.highestTriple = tempTriple
                ostats.highestTripleDate = myScorecardRec.bowlingDate
            }
            //
            if tempTriple < ostats.lowestTriple
            {
                ostats.lowestTriple = tempTriple
                ostats.lowestTripleDate = myScorecardRec.bowlingDate
            }
        }
        if ( (ostats.seasonTotal != 0) && (ostats.totalGames != 0) )
        {
            ostats.seasonAvg = ostats.seasonTotal / ostats.totalGames
        }
        //
        return ostats
    }
}

