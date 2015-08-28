//
//  Scorecard.swift
//  
//
//  Created by Admin on 2015-08-27.
//
//

import Foundation
import CoreData

class Scorecard: NSManagedObject {

    @NSManaged var bowlerName: String
    @NSManaged var bowlingDate: NSDate
    @NSManaged var gameScore1: NSNumber
    @NSManaged var gameScore2: NSNumber
    @NSManaged var gameScore3: NSNumber
    @NSManaged var leagueName: String
    @NSManaged var leagueSeason: String

}
