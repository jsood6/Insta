//
//  PostDetailViewController.swift
//  Insta
//
//  Created by jsood on 5/25/18.
//  Copyright © 2018 Jigyasaa Sood. All rights reserved.
//

import UIKit
import Parse

class PostDetailViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var numLikesLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var post : Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = post {
            self.usernameLabel.text = "JJStar"
            self.captionLabel.text = post.caption
            self.numLikesLabel.text = "\(post.likesCount)"
            let pfFileImage = post.media
            pfFileImage.getDataInBackground{(imageData, error) in
                if (error == nil) {
            if let imageData = imageData{
                    let img = UIImage(data: imageData)
                    self.postImageView.image = img
                }
            }
            
           }
        }
                
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date / server String
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let myString = formatter.string(from: Date()) // string purpose I add here
            // convert your string to date
            let yourDate = formatter.date(from: myString)
            //then again set the date format whhich type of output you need
            formatter.dateFormat = "dd-MMM-yyyy"
            // again convert your date to string
            let myStringafd = formatter.string(from: post.createdAt!)
            self.dateLabel.text = myStringafd
            
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
