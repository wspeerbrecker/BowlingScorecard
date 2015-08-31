//
//  StatisticsViewController.swift
//  BowlingScorecard
//
//  Created by Admin on 2015-08-29.
//  Copyright (c) 2015 infoshare. All rights reserved.
//

import UIKit
import CoreData

class StatisticsViewController: UIViewController {

    var mySCModel = ScorecardModel()
    
    @IBOutlet weak var totalSessionsText: UILabel!
    @IBOutlet weak var totalGamesText: UILabel!
    @IBOutlet weak var highSingleText: UILabel!
    @IBOutlet weak var highTripleText: UILabel!
    @IBOutlet weak var lowSingleText: UILabel!
    @IBOutlet weak var lowTripleText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let tbvc = self.tabBarController  as! ScorecardTabBarController
        mySCModel = tbvc.myScorecardModel
        //
        var ostats = mySCModel.calculateStats()
        //
        totalSessionsText.text = "Total Bowling Sessions: \(ostats.totalSessions)"
        totalGamesText.text = "Total No. of Games: \(ostats.totalGames)"
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var strDate = dateFormatter.stringFromDate(ostats.highestSingleDate)
        highSingleText.text = "High Single Game: \(ostats.highestSingle) (\(strDate))"
        strDate = dateFormatter.stringFromDate(ostats.highestTripleDate)
        highTripleText.text = "High Triple Games: \(ostats.highestTriple) (\(strDate))"
        strDate = dateFormatter.stringFromDate(ostats.lowestSingleDate)
        lowSingleText.text = "Low Single Game: \(ostats.lowestSingle) (\(strDate))"
        strDate = dateFormatter.stringFromDate(ostats.lowestTripleDate)
        lowTripleText.text = "Low Triple Games: \(ostats.lowestTriple) (\(strDate))"
    }
    
}
