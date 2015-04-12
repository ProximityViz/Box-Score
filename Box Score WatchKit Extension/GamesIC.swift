//
//  GamesIC.swift
//  Box Score
//
//  Created by Mollie on 4/11/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import WatchKit
import Foundation


var gameIndex = 0

class GamesTRC: NSObject
{
    
    @IBOutlet weak var gameTeamsLabel: WKInterfaceLabel!
    @IBOutlet weak var gameDateLabel: WKInterfaceLabel!
    
}

class GamesIC: WKInterfaceController
{
    
    private var gamesData = [Game]()

    @IBOutlet weak var table: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        gamesData = Games.mainData().getGamesList()
        println(gamesData.count)
        
        loadTableData()
        
    }
    
    func loadTableData()
    {
        
        table.setNumberOfRows(gamesData.count, withRowType: "GamesTRC")
        
        for (index, item) in enumerate(gamesData)
        {
            
            let row = table.rowControllerAtIndex(index) as! GamesTRC
            
            // label Today, Yesterday, Tomorrow
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            row.gameDateLabel.setText(dateFormatter.stringFromDate(gamesData[index].date))
            row.gameTeamsLabel.setText("\(gamesData[index].awayTeam) \(gamesData[index].awayRuns.reduce(0, combine: +)) @ \(gamesData[index].homeTeam) \(gamesData[index].homeRuns.reduce(0, combine: +))")
        }
        
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject?
    {
        
        gameIndex = rowIndex
        
        return nil
    }
    
    @IBAction func createNewGame()
    {
        
        Games.mainData().addGame(Game())
        gameIndex = 0
        pushControllerWithName("ScoringIC", context: nil)
    }

    override func willActivate()
    {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate()
    {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
