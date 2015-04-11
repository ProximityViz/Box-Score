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
    // is this needed?
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // scoring view
    @IBOutlet weak var scoringView: UIView!
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
    
    // detail view
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var awayTeamTextField: UITextField!
    @IBOutlet weak var homeTeamTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    // line score view
    @IBOutlet weak var lineScoreView: UIView!
    @IBOutlet weak var awayRunsLabel: UILabel!
    @IBOutlet weak var awayHitsLabel: UILabel!
    @IBOutlet weak var awayErrorsLabel: UILabel!
    @IBOutlet weak var homeRunsLabel: UILabel!
    @IBOutlet weak var homeHitsLabel: UILabel!
    @IBOutlet weak var homeErrorsLabel: UILabel!
    
    var gameIndex = 0
    var thisGame: Game!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        thisGame = Games.mainData().getGamesList()[gameIndex]
        
        title = "\(thisGame.awayTeam) @ \(thisGame.homeTeam)"
        
        // line score labels
        awayRunsLabel.text = thisGame.awayRuns.reduce(0, combine: +).description
        homeRunsLabel.text = thisGame.homeRuns.reduce(0, combine: +).description
        awayHitsLabel.text = thisGame.awayHits.description
        homeHitsLabel.text = thisGame.homeHits.description
        awayErrorsLabel.text = thisGame.awayErrors.description
        homeErrorsLabel.text = thisGame.homeErrors.description
        
        if thisGame.currentSide == "away"
        {
            displayAwayInning()
        }
        else
        {
            displayHomeInning()
        }
        
    }
    
    // MARK: Change Score

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
            if thisGame.homeRuns.count < thisGame.currentInning { thisGame.homeRuns.append(0) }
            displayHomeInning()
            thisGame.currentSide = "home"
        }
        else
        {
            thisGame.currentInning = thisGame.currentInning + 1
            inningLabel.text = "Inning: \(thisGame.currentInning)"
            // add space for the next inning
            if thisGame.awayRuns.count < thisGame.currentInning { thisGame.awayRuns.append(0) }
            displayAwayInning()
            thisGame.currentSide = "away"
        }
        
    }
    
    func displayAwayInning()
    {
        // scoring labels
        // TODO: rename "teamScore" labels
        awayTeamScoreLabel.text = "\(thisGame.awayTeam) Batting"
        homeTeamScoreLabel.text = "\(thisGame.homeTeam) Fielding"
        inningLabel.text = "Inning: T\(thisGame.currentInning)"
        awayTeamScoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        homeTeamScoreLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
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
    
    func displayHomeInning()
    {
        awayTeamScoreLabel.text = "\(thisGame.awayTeam) Fielding"
        homeTeamScoreLabel.text = "\(thisGame.homeTeam) Batting"
        inningLabel.text = "Inning: B\(thisGame.currentInning)"
        awayTeamScoreLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
        homeTeamScoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
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
    
    // MARK: UI
    
    @IBAction func changeView(sender: UISegmentedControl)
    {
        Games.mainData().saveGame(thisGame, atIndex: gameIndex)
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0: // detail
            detailView.hidden = false
            scoringView.hidden = true
        case 1:
            scoringView.hidden = false
            detailView.hidden = true
        default:
            break
        }
    }
    
    // minimize keyboard on tap outside
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
    }
    
    // temporary
    @IBAction func saveGame(sender: AnyObject)
    {
        Games.mainData().saveGame(thisGame, atIndex: gameIndex)
    }
    
}
