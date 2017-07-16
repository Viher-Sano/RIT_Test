//
//  ProfileTableViewController.swift
//  RIT_Test
//
//  Created by Alexander Ruduk on 14.07.17.
//  Copyright © 2017 Alexander Ruduk. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
import SDWebImage
import CoreData

class ProfileTableViewController: UITableViewController {

    let defaults = UserDefaults.standard
    
    // Google profile
    @IBOutlet weak var profileGoogleImage: UIImageView!
    @IBOutlet weak var profileNameGoogleLabel: UILabel!
    @IBOutlet weak var profileSonameGoogleLabel: UILabel!
    @IBOutlet weak var profileEmailGoogleLabel: UILabel!
    
    // Facebook profile
    @IBOutlet weak var profileFBImage: UIImageView!
    @IBOutlet weak var profileNameFBLabel: UILabel!
    @IBOutlet weak var profileSonameFBLabel: UILabel!
    @IBOutlet weak var profileEmailFBLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Login"
        
        let imageGoogleURL = defaults.url(forKey: Constant.User.imageURL)
        
        profileGoogleImage.layer.cornerRadius = profileGoogleImage.bounds.size.height / 2
        profileGoogleImage.sd_setImage(with: imageGoogleURL, placeholderImage: #imageLiteral(resourceName: "User"))
        profileGoogleImage.layer.masksToBounds = true
        
        profileNameGoogleLabel.text = defaults.object(forKey: Constant.User.givenName) as? String
        profileSonameGoogleLabel.text = defaults.object(forKey: Constant.User.familyName) as? String
        profileEmailGoogleLabel.text = defaults.object(forKey: Constant.User.email) as? String
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start { (connection, result, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            let fbDetals = result as! NSDictionary
            print(fbDetals)
            
            let userID = fbDetals["id"] as! String
            
            let imageFBURL = URL(string: "http://graph.facebook.com/\(userID)/picture?type=large")
            
            self.profileFBImage.layer.cornerRadius = self.profileFBImage.bounds.size.height / 2
            //self.profileFBImage.image = #imageLiteral(resourceName: "User")
            self.profileFBImage.sd_setImage(with: imageFBURL, placeholderImage: #imageLiteral(resourceName: "User"))
            self.profileFBImage.layer.masksToBounds = true
            
            self.profileNameFBLabel.text = fbDetals["first_name"] as? String
            self.profileSonameFBLabel.text = fbDetals["last_name"] as? String
            self.profileEmailFBLabel.text = fbDetals["email"] as? String
        
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Action
    
    @IBAction func logOutAction(_ sender: Any) {
        FBSDKLoginManager().logOut()
        GIDSignIn.sharedInstance().signOut()
        
        defaults.removeObject(forKey: Constant.User.userID)
        defaults.removeObject(forKey: Constant.User.idToken)
        defaults.removeObject(forKey: Constant.User.fullName)
        defaults.removeObject(forKey: Constant.User.givenName)
        defaults.removeObject(forKey: Constant.User.familyName)
        defaults.removeObject(forKey: Constant.User.email)
        defaults.removeObject(forKey: Constant.User.hasImage)
        defaults.removeObject(forKey: Constant.User.imageURL)
        
        defaults.synchronize()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch { 
            print ("There was an error") 
        }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let loginVC = sb.instantiateViewController(withIdentifier: "loginVC") as? UINavigationController {
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = loginVC
        }
    }
}
