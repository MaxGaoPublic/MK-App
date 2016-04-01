//
//  LoginViewController.swift
//  MK-App
//
//  Created by Max Gao on 18.12.15.
//  Copyright © 2015 Max Gao. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var pwLabel: UILabel!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        userNameField.delegate = self
        pwField.delegate = self
        userNameField.autocorrectionType = UITextAutocorrectionType.No
        pwField.autocorrectionType = UITextAutocorrectionType.No
        pwField.secureTextEntry = true
        self.userNameLabel.alpha = 0.0
        self.userNameField.alpha = 0.0
        self.pwLabel.alpha = 0.0
        self.pwField.alpha = 0.0
        self.activity.alpha = 0.0
        
        self.navigationItem.hidesBackButton = true
        UIView.animateWithDuration(1.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.userNameLabel.alpha = 1.0
            self.userNameField.alpha = 1.0
            self.pwLabel.alpha = 1.0
            self.pwField.alpha = 1.0
            self.userNameField.becomeFirstResponder()
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if(textField == userNameField) {
            pwField.becomeFirstResponder()
            
        } else {
            self.view.endEditing(true)
            if(!userNameField.text!.isEmpty && !pwField.text!.isEmpty) {
                self.activity.alpha = 1.0
                self.activity.startAnimating()
                checkData(userNameField.text!, pw: pwField.text!)
                    
                    
                
                
            }
        }
        
        
        
        return true
        
    }
    
    func checkData(name : String, var pw : String) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let loginPage = "https://mk-bs.de/idesk/./"
            
            var hc = HttpClient(url: loginPage)
            
            hc.setMethod("POST")
            
            var dic = [String:String]()
            dic["login_act"] = name
            dic["login_pwd"] = pw
            
            
            hc.addFormData(dic)
            
            if(hc.send().containsString("Hier geht es weiter")) {
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.activity.stopAnimating()
                    self.activity.alpha = 0.0
                    
                    do {
                        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
                        let logsPath = documentsPath.URLByAppendingPathComponent("info.txt")
                        let finaltext = name + "\n" + pw
                        try finaltext.toBase64().writeToFile(logsPath.path!, atomically: true, encoding: NSUTF8StringEncoding)
            
                    } catch {
                        print("Writting error")
                    }
                    
                });
                
                let dataPage = "https://mk-bs.de/idesk/info/groups/index.php"
                hc.removeFormData()
                hc.setUrl(dataPage)
                hc.setMethod("GET")
                let data = hc.send()
                var array = data.componentsSeparatedByString("\n")
                var text = ""
                
                for s : String in array{
                    
                    if(s.containsString("<h4>Klasse")) {
                        
                        if(text == "") {
                            text = text + s.componentsSeparatedByString("<h4>")[1].componentsSeparatedByString("</")[0]
                        } else {
                            text = text + ", " + s.componentsSeparatedByString("<h4>")[1].componentsSeparatedByString("</")[0]
                        }
                        
                        
                        
                    }
                    
                }
                
                let alert = UIAlertController(title: "Klasse", message: "Bist du in der \(text)" , preferredStyle: UIAlertControllerStyle.Alert)
                
                for s : String in text.componentsSeparatedByString(",") {
                    alert.addAction(UIAlertAction(title: s, style: UIAlertActionStyle.Default, handler: { action in
                        do {
                            
                            
                            let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
                            let logsPath = documentsPath.URLByAppendingPathComponent("info.txt")
                            
                            let data = try NSString(contentsOfFile: logsPath.path!, encoding: NSUTF8StringEncoding)
                            let finaltext = (data as String) + "," +  s.componentsSeparatedByString(" ")[1]
                            print(finaltext)
                            try finaltext.writeToFile(logsPath.path!, atomically: true, encoding: NSUTF8StringEncoding)
                            
                            
                            if let resultController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("plan") as? PlanViewController {
                                self.navigationController?.pushViewController(resultController, animated: false)
                            }
                            
                            
                        } catch {
                            print("Writting error")
                        }
                        
                        
                    }))
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.presentViewController(alert, animated: true, completion: nil)
                });
                
                
                
            
                
            } else {
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.activity.stopAnimating()
                    self.activity.alpha = 0.0
                });
                
                
                let alert = UIAlertController(title: "Error", message: "Deine Zugangsdaten sind falsch, wenn du dein Passwort vergessen hast, wende dich bitte an deinen Systemadministrator", preferredStyle: UIAlertControllerStyle.Alert)
                
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "Selbe Daten nocheinmal ausprobieren", style: UIAlertActionStyle.Default, handler: { action in
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.activity.startAnimating()
                        self.activity.alpha = 1.0
                    });
                    
                    self.checkData(name, pw: pw)
                    
                    
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.presentViewController(alert, animated: true, completion: nil)
                });
                
                // show the alert
                
            }
            
            

            
            
            dispatch_async(dispatch_get_main_queue(), {
                // update some UI
                });
            });
        
        
    }

}

extension String {
    
    
    /**
     Encode a String to Base64
     
     :returns:
     */
    func toBase64()->String{
        
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        
        return data!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
    }
    
    func fromBase64() -> String {
        
        let data = NSData(base64EncodedString: self, options:NSDataBase64DecodingOptions(rawValue: 0))
       return NSString(data: data!, encoding: NSUTF8StringEncoding) as!
        String
        
    }
    
}
