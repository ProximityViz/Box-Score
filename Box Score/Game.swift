//
//  Game.swift
//  Box Score
//
//  Created by Mollie on 4/10/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

let defaults = NSUserDefaults(suiteName: "group.com.proximityviz.Box-Score-Group")

class Game: NSObject, NSCoding
{
    
    var awayTeam:String!
    var homeTeam:String!
    var awayRuns:[Int]!
    var homeRuns:[Int]!
    var awayHits:Int!
    var homeHits:Int!
    var awayErrors:Int!
    var homeErrors:Int!
    var outs:Int!
    var currentInning:Int!
    var currentSide:String!
    var date:NSDate!
    
    required init(coder aDecoder: NSCoder)
    {
        self.awayTeam = aDecoder.decodeObjectForKey("awayTeam") as! String
        self.homeTeam = aDecoder.decodeObjectForKey("homeTeam") as! String
        self.awayRuns = aDecoder.decodeObjectForKey("awayRuns") as! [Int]
        self.homeRuns = aDecoder.decodeObjectForKey("homeRuns") as! [Int]
        self.awayHits = aDecoder.decodeIntegerForKey("awayHits") as Int
        self.homeHits = aDecoder.decodeIntegerForKey("homeHits") as Int
        self.awayErrors = aDecoder.decodeIntegerForKey("awayErrors") as Int
        self.homeErrors = aDecoder.decodeIntegerForKey("homeErrors") as Int
        self.outs = aDecoder.decodeIntegerForKey("outs") as Int
        self.currentInning = aDecoder.decodeIntegerForKey("currentInning") as Int
        self.currentSide = aDecoder.decodeObjectForKey("currentSide") as! String
        self.date = aDecoder.decodeObjectForKey("date") as! NSDate
    }
    
    override init()
    {
        super.init()
        
        awayTeam = "Away"
        homeTeam = "Home"
        awayRuns = [0]
        homeRuns = [Int]()
        awayHits = 0
        homeHits = 0
        awayErrors = 0
        homeErrors = 0
        outs = 0
        currentInning = 1
        currentSide = "away"
        date = NSDate()
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(awayTeam, forKey: "awayTeam")
        aCoder.encodeObject(homeTeam, forKey: "homeTeam")
        aCoder.encodeObject(awayRuns, forKey: "awayRuns")
        aCoder.encodeObject(homeRuns, forKey: "homeRuns")
        aCoder.encodeInteger(awayHits, forKey: "awayHits")
        aCoder.encodeInteger(homeHits, forKey: "homeHits")
        aCoder.encodeInteger(awayErrors, forKey: "awayErrors")
        aCoder.encodeInteger(homeErrors, forKey: "homeErrors")
        aCoder.encodeInteger(outs, forKey: "outs")
        aCoder.encodeInteger(currentInning, forKey: "currentInning")
        aCoder.encodeObject(currentSide, forKey: "currentSide")
        aCoder.encodeObject(date, forKey: "date")
    }
   
}
