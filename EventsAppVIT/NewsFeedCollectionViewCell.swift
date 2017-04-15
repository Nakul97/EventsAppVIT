//
//  NewsFeedCollectionViewCell.swift
//  EventsAppVIT
//
//  Created by Nakul on 15/01/17.
//  Copyright © 2017 TrueOneblahVIT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Firebase
import CoreData

class NewsFeedCollectionViewCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var EventsTableView: UITableView!
    
    let rootRef = FIRDatabase.database().reference()
    var count = 0
    var DataTaken = [AnyObject]()
        
    override func awakeFromNib() {
        EventsTableView.backgroundColor = UIColor(red: 234/255, green: 241/255, blue: 241/255, alpha: 1.0)
        EventsTableView.separatorStyle = .none;
        let view = NVActivityIndicatorView(frame: CGRect(x:EventsTableView.frame.midX, y : EventsTableView.frame.midY ,width:40,height:40), type: .ballPulse, color: UIColor.red, padding: 0)
        self.addSubview(view)
        view.startAnimating()
        let conditionRef = rootRef.child("events")
        conditionRef.observe(.value) {
            (snap: FIRDataSnapshot) in
            self.DataTaken = snap.value as! [AnyObject]
            //print(DataTaken[0]["ClubName"] as! String)
            self.count = self.DataTaken.count
            self.EventsTableView.reloadData()
            view.stopAnimating()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Events", for: indexPath) as! EventCardTableViewCell
        cell.ClubName.text = self.DataTaken[indexPath.row]["ClubName"] as? String
        cell.EventName.text = self.DataTaken[indexPath.row]["EventName"] as? String
        cell.TimeToGo.text = self.DataTaken[indexPath.row]["Time"] as? String
        return cell
    }
    
    
}
