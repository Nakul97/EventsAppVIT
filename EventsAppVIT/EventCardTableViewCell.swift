//
//  EventCardTableViewCell.swift
//  EventsAppVIT
//
//  Created by Nakul on 17/01/17.
//  Copyright © 2017 TrueOneblahVIT. All rights reserved.
//

import UIKit
import CoreData

class EventCardTableViewCell: UITableViewCell {

    @IBOutlet weak var EventImage: UIImageView!
    @IBOutlet weak var ClubImage: UIImageView!
    @IBOutlet weak var ClubName: UILabel!
    @IBOutlet weak var LineForEvent: UILabel!
    @IBOutlet weak var TimeToGo: UILabel!
    @IBOutlet weak var NewsFeedCard: UIView!
    
    @IBOutlet weak var EventName: UILabel!
    
    @IBOutlet weak var LikeImage: UIImageView!
    @IBOutlet weak var LikeButton: UIButton!
    let otherHeartImage: UIImage = #imageLiteral(resourceName: "LickedClicked")
    let unlickedHeartImage:UIImage = #imageLiteral(resourceName: "NotLiked")
    var likes = [NSManagedObject]()
    override func awakeFromNib() {
        super.awakeFromNib()
        NewsFeedCard.layer.cornerRadius = 8
        EventImage.layer.masksToBounds = true
        EventImage.layer.cornerRadius = 8
        ClubImage.layer.masksToBounds = true
        ClubImage.layer.cornerRadius = 20
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(likeButtonPressed(img:)))
        LikeImage.isUserInteractionEnabled = true
        LikeImage.addGestureRecognizer(tapGestureRecognizer)
        //addGradient()
//        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.frame = EventImage.frame
//        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
//        gradient.locations = [0.0, 0.1]
//        EventImage.layer.insertSublayer(gradient, at: 0)
        
        // Initialization code
    }
    func likeButtonPressed(img: AnyObject)
    {
        if(LikeImage.image != otherHeartImage)
        {
        LikeImage.image = otherHeartImage
        saveLike(saveLike: EventName.text!)
            retrieveLikes(clubName: ClubName.text!)
        }
        else{
            disLike(objectToDelete: EventName.text!)
            LikeImage.image = unlickedHeartImage
        }
    }
    
    
    func addGradient()
    {
        let gradient = CAGradientLayer()
        gradient.frame = EventImage.bounds
        //gradient.bounds.width += 100
        let startColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        let endColor = UIColor.gray.cgColor
        gradient.colors = [startColor, endColor]
        gradient.startPoint = CGPoint(x:0.0, y:0.5)
        gradient.endPoint = CGPoint(x:0.0, y:1.0)
        EventImage.layer.insertSublayer(gradient, at: 0)
    }
    
    func disLike(objectToDelete: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        var temp = 0
        for i in 0..<likes.count
        {
            if(likes[i].value(forKey: "eventName") as? String == objectToDelete)
            {
                temp = i
                break
            }
        }
        moc.delete(likes[temp])
        appDelegate.saveContext()
        likes.remove(at: temp)
        
    }

    func saveLike(saveLike: String){
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
         let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entity(forEntityName: "Likes",
                                                 in:managedContext)
        let person = NSManagedObject(entity: entity!,
                                     insertInto: managedContext)
        person.setValue(saveLike, forKey: "eventName")
        print("    \(saveLike)     ")
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    func retrieveLikes(clubName: String){
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Likes")
        
        //3
        do {
            let results =
                try managedContext.fetch(fetchRequest)
           
            likes = results as! [NSManagedObject]
            //print(likes[0].value(forKey: "eventName"))
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        ClubName.text = nil
        EventName.text = nil
        TimeToGo.text = nil

    }

}
