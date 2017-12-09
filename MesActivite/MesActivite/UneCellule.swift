//
//  UneCellule.swift
//  MesActivite
//
//  Created by m2sar on 01/12/2017.
//  Copyright © 2017 UPMC. All rights reserved.
//

import UIKit

class UneCellule: NSObject{
    var label = ""
    var detail = ""
    var priorite = 0
    var prioImage = UIImageView()
    var image : UIImage?
    
    init(l: String, p: Int){
        label = l
        detail = "Priorité actuelle : \(p)"
        priorite = p
        switch priorite {
        case 0:
            prioImage.image = #imageLiteral(resourceName: "prio-0")
        case 1:
            prioImage.image = #imageLiteral(resourceName: "prio-1")
        case 2:
            prioImage.image = #imageLiteral(resourceName: "prio-2")
        case 3:
            prioImage.image = #imageLiteral(resourceName: "prio-3")
        case 4:
            prioImage.image = #imageLiteral(resourceName: "prio-4")
        default:
            prioImage.image = #imageLiteral(resourceName: "prio-0")
        }
    }
    
    func updateImage(d: UIImage){
        self.image = d
    }
    
    
    func updateTitle(prio : String){
        self.label = prio
    }
    
    func updatePrio(prio : Int){
        self.priorite = prio
        self.detail = "Priorité actuelle : \(prio)";
        switch priorite {
        case 0:
            prioImage.image = #imageLiteral(resourceName: "prio-0")
        case 1:
            prioImage.image = #imageLiteral(resourceName: "prio-1")
        case 2:
            prioImage.image = #imageLiteral(resourceName: "prio-2")
        case 3:
            prioImage.image = #imageLiteral(resourceName: "prio-3")
        case 4:
            prioImage.image = #imageLiteral(resourceName: "prio-4")
        default:
            prioImage.image = #imageLiteral(resourceName: "prio-0")
        }
    }
    
    
}
