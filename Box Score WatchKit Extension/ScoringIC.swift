//
//  ScoringIC.swift
//  Box Score
//
//  Created by Mollie on 4/11/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import WatchKit
import Foundation


class ScoringIC: WKInterfaceController {
    
    var thisGame: Game!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        thisGame = Games.mainData().getGamesList()[gameIndex]
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
