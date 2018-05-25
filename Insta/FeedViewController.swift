//
//  FeedViewController.swift
//  Insta
//
//  Created by jsood on 5/25/18.
//  Copyright © 2018 Jigyasaa Sood. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    var pickedImage: UIImage!
    var posts : [Post] = []
     var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 400
        
        getPosts()
        tableView.reloadData()
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.gray
        //action is what method is called and start enums by .
        refreshControl.addTarget(self, action: #selector(FeedViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        

        // Do any additional setup after loading the view.
    }
    @IBAction func didTapLogout(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.logOut()
    }
    
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
        
        getPosts()
        tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    
    @IBAction func tapCameraBtn(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        self.pickedImage = editedImage
        
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        
        dismiss(animated: true, completion: {
            // save image with the act
            // Do something here
            self.addImageToPost()
        })
        
    }
    
    func addImageToPost() {
        print("INSIDE SAVE IMAGE")
        performSegue(withIdentifier: "cameraSegue", sender: nil)
        
    }
    
    func getPosts(){
        print("inside getPosts............")
        self.posts = []
        let curUser = PFUser.current()
        let userId = curUser?.objectId
        /*Post.fetchUserPosts(userId: userId!) { (posts: [Post]?, error: Error?) in
            print("fetching....................")
            print(posts)
            var i = 0
            if error == nil && posts! == [] {
                print("no posts yet............")
            }
            else {
                //let count = posts?.count
                //self.posts = posts!
                
                while i < posts!.count {
                    let post = posts![i]
                    print("postCaption----------------", posts![i].caption)
                    print(post)
                    self.posts.append(post)
                    self.tableView.reloadData()
                    i = i + 1
                }
            }
    }*/
        
        Post.fetchPosts{ (posts: [Post]?, error: Error?) in
            print("fetching....................")
            print(posts)
            var i = 0
            if error == nil && posts! == [] {
                print("no posts yet............")
            }
            else {
                //let count = posts?.count
                //self.posts = posts!
                
                while i < posts!.count {
                    let post = posts![i]
                    print("postCaption----------------", posts![i].caption)
                    print(post)
                    self.posts.append(post)
                    self.tableView.reloadData()
                    i = i + 1
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell", for: indexPath) as! PostsTableViewCell
        let pfFileImage = posts[indexPath.row].media as! PFFile
        pfFileImage.getDataInBackground{(imageData, error) in
            if (error == nil) {
                if let imageData = imageData{
                    let img = UIImage(data: imageData)
                    cell.postImage.image = img
                    cell.captionLabel.text = self.posts[indexPath.row].caption
                    cell.numLikes.text = "\(self.posts[indexPath.row].likesCount)"
                    
                    let formatter = DateFormatter()
                    // initially set the format based on your datepicker date / server String
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    
                    let myString = formatter.string(from: Date()) // string purpose I add here
                    // convert your string to date
                    let yourDate = formatter.date(from: myString)
                    //then again set the date format whhich type of output you need
                    formatter.dateFormat = "dd-MMM-yyyy"
                    // again convert your date to string
                    let myStringafd = formatter.string(from: self.posts[indexPath.row].createdAt!)
                    
                    print(myStringafd)
                    cell.createdAtLabel.text = myStringafd
                }
                
            }
        }
       
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(posts.count != nil){
            return posts.count
        }
        else{
            return 0
        }
        
    }
    
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cameraSegue"{
            let compose = segue.destination as! ComposeViewController
            compose.postImage = self.pickedImage
        }
        else{
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell){
                let post = posts[indexPath.row]
                let postDetail = segue.destination as! PostDetailViewController
                postDetail.post = post
            }
            
        }
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

