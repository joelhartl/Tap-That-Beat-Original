//
//  TapTheBeatInterfaceController.swift
//  Tap The Beat WatchKit Extension
//
//  Created by JHartl on 8/10/18.
//  Copyright © 2018 Ecerea. All rights reserved.
//

import WatchKit
import Foundation

class TapTheBeatInterfaceController: WKInterfaceController {
    
    //MARK: - Outlets
    @IBOutlet var BPMLabel: WKInterfaceLabel!
    @IBOutlet var beatButton: WKInterfaceButton!
    
    //MARK: - Properties
    var timeIntervals: [TimeInterval] = []
    var currentDate: Date?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        BPMLabel.setText("          ")
        
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    
    @IBAction func beatTapped() {
        //1. Upon second tap stops current date object and stores TimeInterval. If this is nil, will not execute.
        let now = Date()
        if let timeInterval = currentDate?.timeIntervalSince(now) {
            timeIntervals.append(-timeInterval)
        }
        
        //2. Creates new date object at present time
        currentDate = Date()
        
        //3. When 5 taps have happened, displays calculated BPM in label and resets tapCount.
        if (timeIntervals.count) > 5 {
            let sumArray = timeIntervals.reduce(0, +)
            let averageTime = sumArray / Double(timeIntervals.count)
            let beatsPerMin = 60 / averageTime
            let beatString = String(Int(beatsPerMin))
            BPMLabel.setText("\(beatString) BPM")
            timeIntervals = []
        }
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        timeIntervals = []
        currentDate = nil
        BPMLabel.setText("        ")
    }
    
}
