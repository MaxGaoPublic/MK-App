//
//  Entfall.swift
//  MK-App
//
//  Created by Max Gao on 17.12.15.
//  Copyright © 2015 Max Gao. All rights reserved.
//

import UIKit


class Entfall {
    
    var art : String
    var klasse : String
    var vertreter : String
    var lehrer : String
    var stunde : String
    var fach : String
    var raum : String
    
    
    
    
    init(art : String, klasse : String, vertreter : String, lehrer : String, stunde : String, fach : String, raum : String) {
      
        self.art = art
        self.klasse = klasse
        self.vertreter = vertreter
        self.lehrer = lehrer
        self.stunde = stunde
        self.fach = fach
        self.raum = raum
        
    }
    
}

class Vertretung {
    
    var art : String
    var klasse : String
    var vertreter : String
    var lehrer : String
    var stunde : String
    var fach : String
    var raum : String
    
    
    init(art : String,klasse : String, vertreter : String, lehrer : String, stunde : String, fach : String, raum : String) {
        
        self.art = art
        self.klasse = klasse
        self.vertreter = vertreter
        self.lehrer = lehrer
        self.stunde = stunde
        self.fach = fach
        self.raum = raum
        
    }
    
}

