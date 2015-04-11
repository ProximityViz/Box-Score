//
//  ScoringVC.swift
//  Box Score
//
//  Created by Mollie on 4/11/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

class ScoringVC: UIViewController
{
    
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var runsLabel: UILabel!
    @IBOutlet weak var hitsLabel: UILabel!
    @IBOutlet weak var errorsLabel: UILabel!
    @IBOutlet weak var lobLabel: UILabel!
    @IBOutlet weak var inningLabel: UILabel!
    @IBOutlet weak var runsStepper: UIStepper!
    @IBOutlet weak var hitsStepper: UIStepper!
    @IBOutlet weak var errorsStepper: UIStepper!
    @IBOutlet weak var lobStepper: UIStepper!
    @IBOutlet weak var inningButton: UIButton!
    
    var thisGame: Game!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // change this so it happens when you navigate from plus button
        thisGame = Game()
        
        awayTeamScoreLabel.text = "\(thisGame.awayTeam): \(thisGame.awayRuns.reduce(0, combine: +))"
        homeTeamScoreLabel.text = "\(thisGame.homeTeam): \(thisGame.homeRuns.reduce(0, combine: +))"
        inningLabel.text = "Inning: \(thisGame.currentInning)"
        
        
        // change this to use newAwayInning function
        if thisGame.currentSide == "away"
        {
            awayTeamScoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
            homeTeamScoreLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
            runsStepper.value = Double(thisGame.awayRuns.reduce(0, combine: +))
            runsLabel.text = "Runs: \(Int(runsStepper.value))"
            hitsStepper.value = Double(thisGame.awayHits)
            hitsLabel.text = "Hits: \(Int(hitsStepper.value))"
            errorsStepper.value = Double(thisGame.awayErrors)
            errorsLabel.text = "Errors: \(Int(errorsStepper.value))"
            lobStepper.value = Double(thisGame.awayLoB)
            lobLabel.text = "Left on Base: \(Int(lobStepper.value))"
        }
        else
        {
            awayTeamScoreLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
            homeTeamScoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
            runsStepper.value = Double(thisGame.homeRuns.reduce(0, combine: +))
            runsLabel.text = "Runs: \(Int(runsStepper.value))"
            hitsStepper.value = Double(thisGame.homeHits)
            hitsLabel.text = "Hits: \(thisGame.homeHits)"
            errorsStepper.value = Double(thisGame.homeErrors)
            errorsLabel.text = "Errors: \(thisGame.homeErrors)"
            lobStepper.value = Double(thisGame.homeLoB)
            lobLabel.text = "Left on Base: \(thisGame.homeLoB)"
        }
        
    }

    // all of these actions should save to the Game
    @IBAction func stepRuns(sender: UIStepper)
    {
        if thisGame.currentSide == "away"
        {
            // increased
            if Int(sender.value) > thisGame.awayRuns.reduce(0, combine: +)
            {
                thisGame.awayRuns[thisGame.currentInning - 1]++
            }
            // decreased
            else
            {
                thisGame.awayRuns[thisGame.currentInning - 1]--
            }
        }
        else
        {
            // increased
            if Int(sender.value) > thisGame.homeRuns.reduce(0, combine: +)
            {
                thisGame.homeRuns[thisGame.currentInning - 1]++
            }
                // decreased
            else
            {
                thisGame.homeRuns[thisGame.currentInning - 1]--
            }
        }
        runsLabel.text = "Runs: \(Int(runsStepper.value))"
        awayTeamScoreLabel.text = "\(thisGame.awayTeam): \(thisGame.awayRuns.reduce(0, combine: +))"
        homeTeamScoreLabel.text = "\(thisGame.homeTeam): \(thisGame.homeRuns.reduce(0, combine: +))"
    }
    
    @IBAction func stepHits(sender: UIStepper)
    {
        if thisGame.currentSide == "away"
        {
            thisGame.awayHits = Int(sender.value)
        }
        else
        {
            thisGame.homeHits = Int(sender.value)
        }
        hitsLabel.text = "Hits: \(Int(hitsStepper.value))"
    }
    
    @IBAction func stepErrors(sender: UIStepper)
    {
        if thisGame.currentSide == "away"
        {
            thisGame.awayErrors = Int(sender.value)
        }
        else
        {
            thisGame.homeErrors = Int(sender.value)
        }
        errorsLabel.text = "Errors: \(Int(errorsStepper.value))"
    }
    
    @IBAction func stepLoB(sender: UIStepper)
    {
        if thisGame.currentSide == "away"
        {
            thisGame.awayLoB = Int(sender.value)
        }
        else
        {
            thisGame.homeLoB = Int(sender.value)
        }
        lobLabel.text = "Left on Base: \(Int(lobStepper.value))"
    }
    
    @IBAction func changeTeam(sender: AnyObject)
    {
        if thisGame.currentSide == "away"
        {
            newHomeInning()
            thisGame.currentSide = "home"
        }
        else
        {
            thisGame.currentInning = thisGame.currentInning + 1
            inningLabel.text = "Inning: \(thisGame.currentInning)"
            newAwayInning()
            thisGame.currentSide = "away"
        }
        
    }
    
    func newAwayInning()
    {
        awayTeamScoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        homeTeamScoreLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
        // add space for the next inning
        if thisGame.awayRuns.count < thisGame.currentInning { thisGame.awayRuns.append(0) }
        // change stepper value
        runsStepper.value = Double(thisGame.awayRuns.reduce(0, combine: +))
        runsLabel.text = "Runs: \(Int(runsStepper.value))"
        hitsStepper.value = Double(thisGame.awayHits)
        hitsLabel.text = "Hits: \(thisGame.awayHits)"
        errorsStepper.value = Double(thisGame.awayErrors)
        errorsLabel.text = "Errors: \(thisGame.awayErrors)"
        lobStepper.value = Double(thisGame.awayLoB)
        lobLabel.text = "Left on Base: \(thisGame.awayLoB)"
    }
    
    func newHomeInning()
    {
        awayTeamScoreLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
        homeTeamScoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        if thisGame.homeRuns.count < thisGame.currentInning { thisGame.homeRuns.append(0) }
        // change stepper value
        runsStepper.value = Double(thisGame.homeRuns.reduce(0, combine: +))
        runsLabel.text = "Runs: \(Int(runsStepper.value))"
        hitsStepper.value = Double(thisGame.homeHits)
        hitsLabel.text = "Hits: \(thisGame.homeHits)"
        errorsStepper.value = Double(thisGame.homeErrors)
        errorsLabel.text = "Errors: \(thisGame.homeErrors)"
        lobStepper.value = Double(thisGame.homeLoB)
        lobLabel.text = "Left on Base: \(thisGame.homeLoB)"
    }
    
}