//
//  ComposeViewController.swift
//  Insta
//
//  Created by jsood on 5/25/18.
//  Copyright © 2018 Jigyasaa Sood. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    var postImage : UIImage!
    
    @IBOutlet weak var composeImage: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeImage.image = postImage

        // Do any additional setup after loading the view.
    }

    @IBAction func tapPost(_ sender: Any) {
        Post.getPFFileFromImage(image: postImage)
        Post.postUserImage(image: postImage, withCaption: self.captionField.text, withCompletion: nil)
        self.dismiss(animated: true, completion: nil)
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
