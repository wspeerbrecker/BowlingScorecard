//
//  Scorecard.swift
//  BowlingScorecard
//
//  Created by Admin on 2015-08-27.
//  Copyright (c) 2015 infoshare. All rights reserved.
//

import Foundation
import CoreData

class Scorecard: NSManagedObject {

    @NSManaged var bowlerName: String
    @NSManaged var leagueSession: String
    @NSManaged var leagueName: String
    @NSManaged var gameScore3: NSNumber
    @NSManaged var gameScore2: NSNumber
    @NSManaged var gameScore1: NSNumber
    @NSManaged var bowlingDate: NSDate

}
