//
//  GameVC.swift
//  Box Score
//
//  Created by Mollie on 4/10/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

class GameVC: UIViewController
{

    @IBOutlet weak var awayTeamTextField: UITextField!
    @IBOutlet weak var homeTeamTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
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
        awayTeamTextField.text = thisGame.awayTeam
        homeTeamTextField.text = thisGame.homeTeam
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        dateLabel.text = dateFormatter.stringFromDate(thisGame.date)
        awayRunsLabel.text = thisGame.awayRuns.reduce(0, combine: +).description
        homeRunsLabel.text = thisGame.homeRuns.reduce(0, combine: +).description
        awayHitsLabel.text = thisGame.awayHits.description
        homeHitsLabel.text = thisGame.homeHits.description
        awayErrorsLabel.text = thisGame.awayErrors.description
        homeErrorsLabel.text = thisGame.homeErrors.description
        // LoB
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
