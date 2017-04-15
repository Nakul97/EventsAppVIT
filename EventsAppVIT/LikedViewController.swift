//
//  LikedViewController.swift
//  EventsAppVIT
//
//  Created by Nakul on 16/01/17.
//  Copyright © 2017 TrueOneblahVIT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Firebase
import CoreData

class LikedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var LikesTableView: UITableView!
    
    let rootRef = FIRDatabase.database().reference()
    var count = 0
    var DataTaken = [AnyObject]()
    var likes = [NSManagedObject]()
    var LikedEvents = [AnyObject]()
    
    override func viewWillAppear(_ animated: Bool)  {
        let view = NVActivityIndicatorView(frame: CGRect(x:self.view.frame.width/2, y : self.view.frame.height/2 ,width:40,height:40), type: .pacman, color: UIColor.red, padding: 0)
        self.view.addSubview(view)
        view.startAnimating()
        let conditionRef = rootRef.child("events")
        conditionRef.observe(.value) {
            (snap: FIRDataSnapshot) in
            self.DataTaken = snap.value as! [AnyObject]
            //print(DataTaken[0]["ClubName"] as! String)
            //self.count = self.DataTaken.count
            self.retrieveLikes()
            self.buildLikedEventsList()
            self.count = self.likes.count
            print(self.count)
            self.LikesTableView.reloadData()
            view.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
    func retrieveLikes(){
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Likes")
        
        do {
            let results =
                try managedContext.fetch(fetchRequest)
            
            likes = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func buildLikedEventsList(){
        for i in 0..<self.likes.count
        {
            for j in 0..<DataTaken.count
            {
                if((likes[i].value(forKey: "eventName") as! String) == (DataTaken[j]["EventName"] as! String))
                {
                    LikedEvents.append(DataTaken[j])
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Liked", for: indexPath)
        cell.textLabel?.text = LikedEvents[indexPath.row]["EventName"] as? String
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
