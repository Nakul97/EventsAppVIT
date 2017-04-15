//
//  EventTransition.swift
//  EventsAppVIT
//
//  Created by Nakul on 19/01/17.
//  Copyright © 2017 TrueOneblahVIT. All rights reserved.
//

import UIKit

class EventTransition: UIStoryboardSegue {
    
    override func perform(){
        let secondVC = self.destination as! DetailedEventViewController
        let firstVC = self.source as! ViewController
        let DestinationView = secondVC.view
        
    }

}
