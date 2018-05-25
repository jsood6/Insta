//
//  Post.swift
//  Insta
//
//  Created by jsood on 5/25/18.
//  Copyright © 2018 Jigyasaa Sood. All rights reserved.
//

import UIKit
import Parse

class Post: PFObject, PFSubclassing {

    @NSManaged var media : PFFile
    @NSManaged var author: PFUser
    @NSManaged var caption: String
    @NSManaged var likesCount: Int
    @NSManaged var commentsCount: Int
    
    var username: PFUser!
    /* Needed to implement PFSubclassing interface */
    class func parseClassName() -> String {
        return "Post"
    }
    
    /**
     * Other methods
     */
    
    class func fetchPosts (completion: @escaping ([Post]?, Error?) -> Void) {
        print("inside fetchPosts..........")
        let query = PFQuery(className: "Post")
        query.includeKey("caption")
        query.includeKey("_p_author")
        query.includeKey("media") //this is the image in the post
        query.includeKey("_id")
        query.includeKey("_created_at")
        //query.addDescendingOrder("_created_at")
        query.addDescendingOrder("_created_at")
        return query.findObjectsInBackground { (activities: [PFObject]? , error: Error?) in
            completion(activities as? [Post], nil)
        }
    }
    
    //fetching posts for each specific user
    /*class func fetchUserPosts(userId: String, completion: @escaping ([Post]?, Error?) -> Void ){
        let query = PFQuery(className: "Post")
        query.includeKey("_p_author")
        query.includeKey("caption")
        query.includeKey("_id")
        query.includeKey("media") //this is the image in the post
        query.includeKey("_created_at")
        query.limit = 20 //so that the user can only see up to 20 posts
        query.addDescendingOrder("_created_at") //for latest posts
        query.whereKey("author", equalTo: "_User$" + userId)
        return query.findObjectsInBackground { (lists: [PFObject]? , error: Error?) in
            completion(lists as? [Post], nil)
        }
    }*/
    
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // use subclass approach
        let post = Post()
        
        // Add relevant fields to the object
        post.media = getPFFileFromImage(image: image)! // PFFile column type
        post.author = PFUser.current()! // Pointer column type that points to PFUser
        post.caption = caption!
        post.likesCount = 0
        post.commentsCount = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}

