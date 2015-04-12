//
//  ScoringIC.swift
//  Box Score
//
//  Created by Mollie on 4/11/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import WatchKit
import Foundation


class ScoringIC: WKInterfaceController
{
    
    var thisGame: Game!
    
    @IBOutlet weak var inningLabel: WKInterfaceLabel!
    @IBOutlet weak var runsButton: WKInterfaceButton!
    @IBOutlet weak var hitsButton: WKInterfaceButton!
    @IBOutlet weak var errorsButton: WKInterfaceButton!
    @IBOutlet weak var outsButton: WKInterfaceButton!

    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        
        thisGame = Games.mainData().getGamesList()[gameIndex]
        if thisGame.currentSide == "away"
        {
            displayAwayInning()
        }
        else
        {
            displayHomeInning()
        }
        outsButton.setTitle("Outs: \n\(thisGame.outs.description)")
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func incrementRuns()
    {
        if thisGame.currentSide == "away"
        {
            thisGame.awayRuns[thisGame.currentInning - 1]++
            runsButton.setTitle("Runs: \n\(thisGame.awayRuns.reduce(0, combine: +).description)")
        }
        else
        {
            thisGame.homeRuns[thisGame.currentInning - 1]++
            runsButton.setTitle("Runs: \n\(thisGame.homeRuns.reduce(0, combine: +).description)")
        }
        Games.mainData().saveGame(thisGame, atIndex: gameIndex)
    }
    
    @IBAction func incrementHits()
    {
        if thisGame.currentSide == "away"
        {
            thisGame.awayHits = thisGame.awayHits + 1
            hitsButton.setTitle("Hits: \n\(thisGame.awayHits.description)")
        }
        else
        {
            thisGame.homeHits = thisGame.homeHits + 1
            hitsButton.setTitle("Hits: \n\(thisGame.homeHits.description)")
        }
        Games.mainData().saveGame(thisGame, atIndex: gameIndex)
    }
    
    @IBAction func incrementErrors()
    {
        if thisGame.currentSide == "away"
        {
            thisGame.homeErrors = thisGame.homeErrors + 1
            errorsButton.setTitle("Hits: \n\(thisGame.homeErrors.description)")
        }
        else
        {
            thisGame.awayErrors = thisGame.awayErrors + 1
            errorsButton.setTitle("Hits: \n\(thisGame.awayErrors.description)")
        }
        Games.mainData().saveGame(thisGame, atIndex: gameIndex)
    }
    
    @IBAction func incrementOuts()
    {
        thisGame.outs = thisGame.outs + 1
        if thisGame.outs == 3
        {
            if thisGame.currentSide == "away"
            {
                if thisGame.homeRuns.count < thisGame.currentInning { thisGame.homeRuns.append(0) }
                displayHomeInning()
                thisGame.currentSide = "home"
            }
            else
            {
                thisGame.currentInning = thisGame.currentInning + 1
                // add space for the next inning
                if thisGame.awayRuns.count < thisGame.currentInning { thisGame.awayRuns.append(0) }
                displayAwayInning()
                thisGame.currentSide = "away"
            }
            thisGame.outs = 0
        }
        outsButton.setTitle("Outs: \n\(thisGame.outs.description)")
        Games.mainData().saveGame(thisGame, atIndex: gameIndex)
    }
    
    func displayAwayInning()
    {
        inningLabel.setText("T\(thisGame.currentInning): \(thisGame.awayTeam)")
        runsButton.setTitle("Runs: \n\(thisGame.awayRuns.reduce(0, combine: +).description)")
        hitsButton.setTitle("Hits: \n\(thisGame.awayHits.description)")
        errorsButton.setTitle("Errors: \n\(thisGame.homeErrors.description)")
    }
    
    func displayHomeInning()
    {
        inningLabel.setText("B\(thisGame.currentInning): \(thisGame.homeTeam)")
        runsButton.setTitle("Runs: \n\(thisGame.homeRuns.reduce(0, combine: +).description)")
        hitsButton.setTitle("Hits: \n\(thisGame.homeHits.description)")
        errorsButton.setTitle("Errors: \n\(thisGame.awayErrors.description)")
    }

}
