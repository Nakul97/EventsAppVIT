//
//  ViewController.swift
//  EventsAppVIT
//
//  Created by Nakul on 12/01/17.
//  Copyright © 2017 TrueOneblahVIT. All rights reserved.
//

import UIKit
import Firebase
import SJFluidSegmentedControl

class ViewController: UIViewController, SJFluidSegmentedControlDataSource,SJFluidSegmentedControlDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    let rootRef = FIRDatabase.database().reference()
    
    
    @IBOutlet weak var FluidSegment: SJFluidSegmentedControl!
    @IBOutlet weak var FeedCollectionView: UICollectionView!
    
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        return 3
    }
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, titleForSegmentAtIndex index: Int) -> String? {
        if(index == 0)
        {
            return "Upcoming"
        }
        else if(index == 1){
            return "Feed"
        }
        else{
            return "Today"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        FeedCollectionView.backgroundColor = UIColor(red: 234/255, green: 241/255, blue: 241/255, alpha: 1.0)
        //self.view.backgroundColor =  UIColor(colorLiteralRed: 68/255.0, green: 66/255.0, blue: 86/255.0, alpha: 1.0)
        let conditionRef = rootRef.child("events")
        conditionRef.observe(.value) {
            (snap: FIRDataSnapshot) in
            let DataTaken = snap.value as! [AnyObject]
            print(DataTaken[0]["ClubName"] as! String)
            
        }
        print("Hello \(rootRef)")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didScrollWithXOffset offset: CGFloat) {
        
        FeedCollectionView.contentOffset.x = self.view.frame.width * 3 * offset/FluidSegment.frame.width
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Feed", for: indexPath) as! NewsFeedCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(FeedCollectionView.frame.height)
        return CGSize(width: self.view.frame.width - 20, height: FeedCollectionView.frame.height-40);
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView == FeedCollectionView)
        {
           // FluidSegment.
        }
    }

}

