//
//  Vertretungplan.swift
//  MK-App
//
//  Created by Max Gao on 20.12.15.
//  Copyright © 2015 Max Gao. All rights reserved.
//

import UIKit


public class Vertretungsplan {
    
    
    public var plaene =  [String:[String]]()
    
    
    init() {

        var i = 1
        var array = [1,2,3,4,5]
        
        while i <= 5 {
            
            
            if(plaene.keys.count == 2) {
                break
            }
            
            
            if(array.contains(i)) {
                var plan = [String]()
                
                let header = getHeader("\(i)")
                
                if(header.containsString("Seite")) {
                    let part = header.componentsSeparatedByString("(Seite ")[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                    let i1 = (part.componentsSeparatedByString("/")[0] as NSString).integerValue
                    let i2 = (part.componentsSeparatedByString("/")[1].componentsSeparatedByString(")")[0]as NSString).integerValue
                    if(i1 < i2) {
                        
                        let diff = i2 - i1 + 1
                        var i1 = 1
                        plan = loadData("\(i)")
                        while i1 <= diff{
                            plan += loadData("\(i1)")
                            array.removeAtIndex(array.indexOf(i1)!)
                            ++i1
                        }
                        plaene[header.componentsSeparatedByString(" ")[1]] = plan
                        
                        ++i
                    }
                    
                    
                    
                } else {
                    
                    
                    plan = loadData("\(i)")
                    array.removeAtIndex(array.indexOf(i)!)
                    plaene[header.componentsSeparatedByString(" ")[1]] = plan
                    
                    for s : String in plaene.keys {
                        
                        if(header.containsString(s)) {
                            break
                        }
                        
                    }
                    ++i
                }
                
                
            } else {
                ++i
            }
            
        }
        
        for s : String in plaene.keys {
            print(s)
        }
        
        
        
        
    }
    
    
    
    
    func filter(klassen: [String], data: [String]) -> [String] {
        
        var inhalt = data
        var end = [String]()
        
        for s : String in inhalt
        {
            
            for klasse : String in klassen {
                if(s.componentsSeparatedByString("tsep")[1].containsString(klasse)) {
                    end.append(s)
                }
            }
            
        }
        
        
        return end
    }
    
    func filter(klasse: String, data: [String]) -> [String] {
        
        var inhalt = data
        var end = [String]()
        for s : String in inhalt {

                if(!s.componentsSeparatedByString("tsep")[1].containsString(klasse)) {
                    end.append(s)
                }
            
            
        }
        
         return end
    }
    
    func getHeader(s : String) -> String {
        
        
        do {
            
            
            let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
            let logsPath = documentsPath.URLByAppendingPathComponent("info.txt")
            let data = try NSString(contentsOfFile: logsPath.path!, encoding: NSUTF8StringEncoding)
            let loginPage = "https://mk-bs.de/idesk/./"
            let dataPage = "https://mk-bs.de/idesk/plan/index.php/Schuelervertretungsplaene/subst_00" + s + ".htm"
            
            var hc = HttpClient(url: loginPage)
            
            hc.setMethod("POST")
            
            var dic = [String:String]()
            
            
            var username = data.componentsSeparatedByString(",")[0].fromBase64().componentsSeparatedByString("\n")[0]
            var pw = data.componentsSeparatedByString(",")[0].fromBase64().componentsSeparatedByString("\n")[1]
            dic["login_act"] = username
            
            
            dic["login_pwd"] = pw
            
            hc.addFormData(dic)
            
            if(hc.send().containsString("Hier geht es weiter")) {
                
                var array = [String]()
                
                hc.setUrl(dataPage)
                hc.setMethod("GET")
                hc.removeFormData()
                let data = hc.send()
                var dataarr = data.componentsSeparatedByString("\n")
                
                for var s : String in dataarr {
                    
                    if(s.containsString("<div class=\"mon_title\">")) {
                        
                        return s.componentsSeparatedByString("<div class=\"mon_title\">")[1].componentsSeparatedByString("<")[0]
                        
                    }
                    
                    
                }
                
            }
        } catch {
                
        }
                

        
        return ""
    
        
    }

    
    
    func loadData(s : String) -> [String] {
        
        do {
        
        
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        let logsPath = documentsPath.URLByAppendingPathComponent("info.txt")
        let data = try NSString(contentsOfFile: logsPath.path!, encoding: NSUTF8StringEncoding)
        let loginPage = "https://mk-bs.de/idesk/./"
        let dataPage = "https://mk-bs.de/idesk/plan/index.php/Schuelervertretungsplaene/subst_00" + s + ".htm"
        
        var hc = HttpClient(url: loginPage)
        
        hc.setMethod("POST")
        
        var dic = [String:String]()
            
            
        var username = data.componentsSeparatedByString(",")[0].fromBase64().componentsSeparatedByString("\n")[0]
        var pw = data.componentsSeparatedByString(",")[0].fromBase64().componentsSeparatedByString("\n")[1]
        let klasse = data.componentsSeparatedByString(",")[1]
        dic["login_act"] = username
        
        
        dic["login_pwd"] = pw
        
        hc.addFormData(dic)
        
        if(hc.send().containsString("Hier geht es weiter")) {
            
            var array = [String]()
            
            hc.setUrl(dataPage)
            hc.setMethod("GET")
            hc.removeFormData()
            let data = hc.send()
            var dataarr = data.componentsSeparatedByString("\n")
            
            for var s : String in dataarr {
                
                if(s.containsString("<tr class='list odd") || s.containsString("<tr class='list even")) {
                    
                    if(s.containsString("</table>")) {
                        dataarr[dataarr.indexOf(s)!] = s.componentsSeparatedByString("</table>")[0]
                        s = s.componentsSeparatedByString("</table>")[0]
                    }
                    
                    if(s.containsString("&nbsp;")) {
                        dataarr[dataarr.indexOf(s)!] = s.stringByReplacingOccurrencesOfString("&nbsp;", withString:" ")
                        s = s.stringByReplacingOccurrencesOfString("&nbsp;", withString:"---")
                    }
                    
                    var temparray = s.componentsSeparatedByString("<td ")
                    
                    let art = temparray[1].componentsSeparatedByString(">")[1].componentsSeparatedByString("<")[0]
                    let klasse = temparray[2].componentsSeparatedByString(">")[1].componentsSeparatedByString("<")[0]
                    let vertreter = temparray[3].componentsSeparatedByString(">")[1].componentsSeparatedByString("<")[0]
                    let lehrer = temparray[4].componentsSeparatedByString(">")[1].componentsSeparatedByString("<")[0]
                    let stunde = temparray[5].componentsSeparatedByString(">")[1].componentsSeparatedByString("<")[0]
                    let fach = temparray[6].componentsSeparatedByString(">")[1].componentsSeparatedByString("<")[0]
                    let raum = temparray[7].componentsSeparatedByString(">")[1].componentsSeparatedByString("<")[0]
                    
                    array.append(art + "tsep" + klasse + "tsep" + vertreter + "tsep" +  lehrer + "tsep" +  stunde + "tsep" +  fach + "tsep" +  raum)
                    
                    
                }
                
                
            }
            
            
            

            
            
            
            return array
            
            
            
        } else {
            return [String]()
        }
        } catch {
            
        }
        
        return [String]()
    }

    
    
    
    
    
    
    
}

