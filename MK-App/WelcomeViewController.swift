//
//  WelcomeViewController.swift
//  MK-App
//
//  Created by Max Gao on 18.12.15.
//  Copyright © 2015 Max Gao. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var toButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.welcomeLabel.alpha = 0.0
        self.toButton.alpha = 0.0
        welcomeLabel.text = ""
        self.navigationController?.navigationBarHidden = true
        
        UIView.animateWithDuration(2.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.welcomeLabel.alpha = 0.0
            self.toButton.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                
                //Once the label is completely invisible, set the text and fade it back in
                self.welcomeLabel.text = "Willkommen bei der MK-App"
                
                // Fade in
                UIView.animateWithDuration(2.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.welcomeLabel.alpha = 1.0
                    self.toButton.alpha = 1.0
                    }, completion: nil)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.welcomeLabel.alpha = 0.0
            self.toButton.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                if let resultController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") as? LoginViewController {
                   self.navigationController?.pushViewController(resultController, animated: false)
                }
                
                
                
        })
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
