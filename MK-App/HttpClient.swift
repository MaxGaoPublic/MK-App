
//
//  HttpClient.swift
//  MK-App
//
//  Created by Max Gao on 17.12.15.
//  Copyright © 2015 Max Gao. All rights reserved.
//

import Foundation
public class HttpClient {
    
    private var session: NSURLSession
    private var request: NSMutableURLRequest
    
    public init(url: String) {
        self.session = NSURLSession.sharedSession()
        session.configuration.HTTPShouldSetCookies = true
        session.configuration.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicy.OnlyFromMainDocumentDomain
        session.configuration.HTTPCookieStorage?.cookieAcceptPolicy = NSHTTPCookieAcceptPolicy.OnlyFromMainDocumentDomain
        self.request = NSMutableURLRequest(URL: NSURL(string: url)!)
    }
    
    public func send() -> String {
        var ready = false
        var content: String!
        
        var task = session.dataTaskWithRequest(self.request) {
            (data, response, error) -> Void in
            content = NSString(data: data!, encoding: NSASCIIStringEncoding) as! String
            ready = true
        }
        task.resume()
        while !ready {
            usleep(10)
        }
        if content != nil {
            return content
        } else {
            return ""
        }
    }
    
    public func setUrl(url: String) -> HttpClient {
        self.request.URL = NSURL(string: url)
        return self
    }
    
    public func getMethod() -> String {
        return self.request.HTTPMethod
    }
    
    public func setMethod(method: String) -> HttpClient {
        self.request.HTTPMethod = method
        return self
    }
    
    public func addFormData(data: Dictionary<String, String>) -> HttpClient {
        var params: String = ""
        var ctHeader: String? = self.request.valueForHTTPHeaderField("Content-Type")
        let ctForm: String = "application/x-www-form-urlencoded"
        
        if(data.count > 0) {
            for(name, value) in data {
                params += name + "=" + value + "&"
            }
            
            params = params.substringToIndex(params.endIndex.predecessor())
            self.request.HTTPBody = params.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
            
            if ctHeader != nil {
                self.request.setValue(ctForm, forHTTPHeaderField: "Content-Type")
            }
        }
        
        return self
    }
    
    public func removeFormData() -> HttpClient {
        self.request.setValue("text/html", forHTTPHeaderField: "Content-Type")
        self.request.HTTPBody = "".dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
        
        return self
    }
}