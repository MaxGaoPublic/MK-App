//
//  PlanCell.swift
//  MK-App
//
//  Created by Max Gao on 21.12.15.
//  Copyright © 2015 Max Gao. All rights reserved.
//

import UIKit

class PlanCell: UICollectionViewCell {
    
    @IBOutlet weak var art: UIImageView!
    @IBOutlet weak var klasse: UILabel!
    @IBOutlet weak var stunde: UILabel!
    @IBOutlet weak var unterricht: UILabel!
    @IBOutlet weak var lehrer: UILabel!
    @IBOutlet weak var raum: UILabel!

    
    func prepareForVertretung(s: String) {
        art.image = UIImage(named: "Vertretung.png")!
        klasse.text = s.componentsSeparatedByString("tsep")[1]
        stunde.text = s.componentsSeparatedByString("tsep")[4]
        unterricht.text = s.componentsSeparatedByString("tsep")[5]
        lehrer.text = s.componentsSeparatedByString("tsep")[3]
        raum.text = s.componentsSeparatedByString("tsep")[6]
        
    }
    
    func prepareForEntfall(s : String) {
        art.image = UIImage(named: "Entfall.png")!
        klasse.text = s.componentsSeparatedByString("tsep")[1]
        stunde.text = s.componentsSeparatedByString("tsep")[4]
        unterricht.text = s.componentsSeparatedByString("tsep")[5]
        lehrer.text = s.componentsSeparatedByString("tsep")[3]
        raum.text = s.componentsSeparatedByString("tsep")[6]
    }
    
    func prepareForRaum(s: String) {
        art.image = UIImage(named: "Raumvertretung.png")!
        klasse.text = s.componentsSeparatedByString("tsep")[1]
        stunde.text = s.componentsSeparatedByString("tsep")[4]
        unterricht.text = s.componentsSeparatedByString("tsep")[5]
        lehrer.text = s.componentsSeparatedByString("tsep")[3]
        raum.text = s.componentsSeparatedByString("tsep")[6]
    }
    
    

}
