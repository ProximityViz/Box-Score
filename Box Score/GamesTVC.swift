//
//  GamesTVC.swift
//  Box Score
//
//  Created by Mollie on 4/10/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

class GamesTVC: UITableViewController {
    
    private var gamesData = [Game]()
    
    var index = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Games"
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        
        gamesData = Games.mainData().getGamesList()
        
        // need datasource & delegate?
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return gamesData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle

        cell.textLabel?.text = dateFormatter.stringFromDate(gamesData[indexPath.row].date)
        cell.detailTextLabel?.text = "\(gamesData[indexPath.row].awayTeam) \(gamesData[indexPath.row].awayRuns.reduce(0, combine: +)) @ \(gamesData[indexPath.row].homeTeam) \(gamesData[indexPath.row].homeRuns.reduce(0, combine: +))"

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        index = indexPath.row
        let vc = storyboard?.instantiateViewControllerWithIdentifier("ScoringVC") as! ScoringVC
        vc.gameIndex = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?
    {
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete")
            { (action, indexPath) -> Void in
            
            tableView.editing = false
            
            Games.mainData().deleteGame(indexPath.row)
            self.gamesData = Games.mainData().getGamesList()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        return [deleteAction]
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "newGame"
        {
            Games.mainData().addGame(Game())
            let vc = segue.destinationViewController as! ScoringVC
            vc.gameIndex = 0
        }
//        else if segue.identifier == "showDetail"
//        {
//            let vc = segue.destinationViewController as! ScoringVC
//            vc.gameIndex = index
//        }
    }

}
