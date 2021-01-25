//
//  SpeedCompute.swift
//  GendTools
//
//  Created by Pascal Ormancey on 21/01/2021.
//

import Foundation

class Speed {
    var vitesseEnregistree: Int = 0
    var vitesseLimite:Int = 0
    
    init(vitesseEnregistree: Int, vitesseLimite:Int) {
        self.vitesseEnregistree = vitesseEnregistree
        self.vitesseLimite = vitesseLimite
    }
    
    var vitesseRetenue: Int {
        var speed: Int = 0
        if vitesseEnregistree > 100 {
            speed = (vitesseEnregistree - (vitesseEnregistree * 5) / 100)
        } else {
            speed = vitesseEnregistree - 5 }
        return speed
     }

   
    var retrait_Point:Int {
       
        var retraitPoint:Int = 0
        
        let deltaSpeed = vitesseRetenue - vitesseLimite
        
        if (deltaSpeed < 20 && deltaSpeed >= 1) {
            
         retraitPoint = 1
            
        }
        
        else if (deltaSpeed >= 20 && deltaSpeed <= 29) {
         
          retraitPoint = 2
        }
        
        else if (deltaSpeed >= 30 && deltaSpeed <= 39) {
          
            retraitPoint = 3
        }
        
        else if (deltaSpeed >= 40 && deltaSpeed <= 49) {
          
            retraitPoint = 4
        }
        
        else if (deltaSpeed >= 50) {
        
            retraitPoint = 6
        }
        
        else if (deltaSpeed <= 0) {
        
            retraitPoint = 0
        }
        
        else {
          
          }
        return retraitPoint
        
      
    }
   
   
}
