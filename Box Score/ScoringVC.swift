//
//  ScoringVC.swift
//  Box Score
//
//  Created by Mollie on 4/11/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

class ScoringVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    // is this needed?
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // scoring view
    @IBOutlet weak var scoringView: UIView!
    @IBOutlet weak var inningLabel: UILabel!
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var runsLabel: UILabel!
    @IBOutlet weak var hitsLabel: UILabel!
    @IBOutlet weak var errorsLabel: UILabel!
    @IBOutlet weak var outsLabel: UILabel!
    @IBOutlet weak var runsStepper: UIStepper!
    @IBOutlet weak var hitsStepper: UIStepper!
    @IBOutlet weak var errorsStepper: UIStepper!
    @IBOutlet weak var inningButton: UIButton!
    
    // detail view
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var awayTeamTextField: UITextField!
    @IBOutlet weak var homeTeamTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    // line score view
    @IBOutlet weak var lineScoreView: UIView!
    @IBOutlet weak var awayCollectionView: UICollectionView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
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
        
        awayCollectionView.delegate = self
        awayCollectionView.dataSource = self
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        // FIXME: may not need this
        awayCollectionView.reloadData()
        homeCollectionView.reloadData()

        thisGame = Games.mainData().getGamesList()[gameIndex]
        
        title = "\(thisGame.awayTeam) @ \(thisGame.homeTeam)"
        
        // detail view
        awayTeamTextField.text = thisGame.awayTeam == "Away" ? nil : thisGame.awayTeam
        homeTeamTextField.text = thisGame.homeTeam == "Home" ? nil : thisGame.homeTeam
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        dateLabel.text = dateFormatter.stringFromDate(thisGame.date)
        
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
            awayCollectionView.reloadData()
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
            homeCollectionView.reloadData()
        }
        runsLabel.text = "Runs: \(Int(runsStepper.value))"
        awayRunsLabel.text = thisGame.awayRuns.reduce(0, combine: +).description
        homeRunsLabel.text = thisGame.homeRuns.reduce(0, combine: +).description
        Games.mainData().saveGame(thisGame, atIndex: gameIndex)
    }
    
    @IBAction func stepHits(sender: UIStepper)
    {
        if thisGame.currentSide == "away"
        {
            thisGame.awayHits = Int(sender.value)
            awayHitsLabel.text = Int(sender.value).description
        }
        else
        {
            thisGame.homeHits = Int(sender.value)
            homeHitsLabel.text = Int(sender.value).description
        }
        hitsLabel.text = "Hits: \(Int(hitsStepper.value))"
        Games.mainData().saveGame(thisGame, atIndex: gameIndex)
    }
    
    // NOTE: ERRORS WORK OPPOSITE OF OTHER STATS BECAUSE THEY GO TO THE OTHER TEAM
    @IBAction func stepErrors(sender: UIStepper)
    {
        if thisGame.currentSide == "away"
        {
            thisGame.homeErrors = Int(sender.value)
            homeErrorsLabel.text = Int(sender.value).description
        }
        else
        {
            thisGame.awayErrors = Int(sender.value)
            awayErrorsLabel.text = Int(sender.value).description
        }
        errorsLabel.text = "Errors: \(Int(errorsStepper.value))"
        Games.mainData().saveGame(thisGame, atIndex: gameIndex)
    }
    
    @IBAction func stepOuts(sender: UIStepper)
    {
        thisGame.outs = Int(sender.value)
        if thisGame.outs == 3
        {
            if thisGame.currentSide == "away"
            {
                awayCollectionView.reloadData()
                if thisGame.homeRuns.count < thisGame.currentInning { thisGame.homeRuns.append(0) }
                displayHomeInning()
                thisGame.currentSide = "home"
            }
            else
            {
                homeCollectionView.reloadData()
                thisGame.currentInning = thisGame.currentInning + 1
                inningLabel.text = "Inning: \(thisGame.currentInning)"
                // add space for the next inning
                if thisGame.awayRuns.count < thisGame.currentInning { thisGame.awayRuns.append(0) }
                displayAwayInning()
                thisGame.currentSide = "away"
            }
            thisGame.outs = 0
            sender.value = 0
            // refresh collection views
        }
        outsLabel.text = "Outs: \(Int(thisGame.outs))"
        Games.mainData().saveGame(thisGame, atIndex: gameIndex)
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
        errorsStepper.value = Double(thisGame.homeErrors)
        errorsLabel.text = "Errors: \(thisGame.homeErrors)"
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
        errorsStepper.value = Double(thisGame.awayErrors)
        errorsLabel.text = "Errors: \(thisGame.awayErrors)"
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
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        println("touch")
        view.endEditing(true)
        thisGame.awayTeam = awayTeamTextField.text == "" ? "Away" : awayTeamTextField.text
        thisGame.homeTeam = homeTeamTextField.text == "" ? "Home" : homeTeamTextField.text
        
        title = "\(thisGame.awayTeam) @ \(thisGame.homeTeam)"
        Games.mainData().saveGame(thisGame, atIndex: gameIndex)
    }
    
    // MARK: Collection Views
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return thisGame.awayRuns.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        var runs = ""
        if collectionView == awayCollectionView
        {
            runs = thisGame.awayRuns[indexPath.row].description
        }
        else
        {
            if thisGame.homeRuns.count > indexPath.row
            {
                runs = thisGame.homeRuns[indexPath.row].description
            }
        }
        
//        cell.backgroundColor = UIColor.grayColor()
        
        let label = UILabel(frame: CGRectMake(1, 1, 14, 21))
        label.textAlignment = NSTextAlignment.Right
        label.backgroundColor = UIColor.whiteColor()
        label.adjustsFontSizeToFitWidth = true
        label.text = runs
        cell.addSubview(label)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        if (indexPath.row + 1) % 3 == 0
        {
            return CGSizeMake(22, 23)
        }
        else
        {
            return CGSizeMake(16, 23)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
}
