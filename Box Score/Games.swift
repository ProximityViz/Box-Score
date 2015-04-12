//
//  Games.swift
//  Box Score
//
//  Created by Mollie on 4/11/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

private let _mainData: Games = Games()

class Games: NSObject {
    
    private var gamesList = [Game]()
    
    class func mainData() -> Games
    {
    
        return _mainData
    }
    
    func getGamesList() -> [Game]
    {
        if retrieveGames() == nil
        {
            println("test")
            gamesList = []
        } else
        {
            gamesList = retrieveGames()!
        }
        return gamesList
    }
    
    func setGamesList()
    {
        saveGames(gamesList)
    }
    
    func addGame(gameData: Game)
    {
        gamesList.append(gameData)
        gamesList.sort({ $0.date.timeIntervalSinceNow > $1.date.timeIntervalSinceNow })
        
        saveGames(gamesList)
    }
    
    func saveGame(gameData: Game, atIndex index: Int)
    {
        deleteGame(index)
        addGame(gameData)
    }
    
    func deleteGame(index: Int)
    {
        gamesList.removeAtIndex(index)
        
        saveGames(gamesList)
    }
   
}

func saveGames(games: [Game])
{
    // for WatchKit
    NSKeyedArchiver.setClassName("Game", forClass: Game.self)
    
    let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(games as NSArray)
    defaults?.setObject(archivedObject, forKey: "games")
    defaults?.synchronize()
}

func retrieveGames() -> [Game]?
{
    
    if let unarchivedObject = defaults?.objectForKey("games") as? NSData {
        
        // WatchKit
        NSKeyedUnarchiver.setClass(Game.self, forClassName: "Game")
        
        return NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? [Game]
    }
    
    return nil
}
