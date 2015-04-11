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
    @IBOutlet weak var awayErrorsLabel: NSLayoutConstraint!
    @IBOutlet weak var homeRunsLabel: UILabel!
    @IBOutlet weak var homeHitsLabel: UILabel!
    @IBOutlet weak var homeErrorsLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
