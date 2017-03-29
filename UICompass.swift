//
//  UICompass.swift
//  UICompass
//
//  Created by Jackson Utsch on 9/5/16.
//  Copyright © 2016 Jackson Utsch. All rights reserved.
//
import UIKit
import CoreLocation

/// UICompass - A UIView representaion of a compass which points north
/// - Author: Jackson Utsch
/// - NOTE: Generally keep the width and height equal
public class UICompass:UIView, CLLocationManagerDelegate {
    
    private let heading:enumNorth = .trueNorth
    private let innerRingColor:UIColor = UIColor.white
    private let pointerDiameter:Double = 40 // Set desired pointer diameter
    
    private var LM:CLLocationManager!
    private var northTick:UIView!
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = min(frame.width/2, frame.height/2)
        clipsToBounds = true
        layer.borderWidth = 3
        layer.borderColor = UIColor.gray.cgColor
        
        northTick = UIView(frame: CGRect(x: 0, y: 0, width: pointerDiameter, height: pointerDiameter))
        northTick.clipsToBounds = true
        northTick.backgroundColor = UIColor.black
        northTick.layer.cornerRadius = min(northTick.frame.width/2, northTick.frame.height/2)
        northTick.center.x = 0
        northTick.center.y = 0
        addSubview(northTick)
        
        let innerRing = UIView(frame: CGRect(x: 0, y: 0, width: frame.width - northTick.frame.width, height: frame.height - northTick.frame.height))
        innerRing.center.x += (frame.width - innerRing.frame.width)/2
        innerRing.center.y += (frame.height - innerRing.frame.height)/2
        innerRing.clipsToBounds = true
        innerRing.layer.cornerRadius = min(innerRing.frame.width/2, innerRing.frame.height/2)
        innerRing.layer.borderWidth = 3
        innerRing.layer.borderColor = UIColor.black.cgColor
        innerRing.backgroundColor = innerRingColor
        addSubview(innerRing)
        
        LM = CLLocationManager()
        LM.delegate = self
        LM.startUpdatingHeading() // Starts updating heading/direction, calls locationManager on change
    }
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if heading == .trueNorth {
            northTick.center.x = frame.width/2 // Centers x
            northTick.center.x += (CGFloat(cosd(degrees: -(newHeading.trueHeading + 90))) * (frame.width/2 - min(northTick.frame.width/2, northTick.frame.height/2) - layer.borderWidth))
            
            northTick.center.y = frame.height/2 // Centers y
            northTick.center.y += (CGFloat(sind(degrees: -(newHeading.trueHeading + 90))) * (frame.height/2 - min(northTick.frame.width/2, northTick.frame.height/2) - layer.borderWidth))
        }
        if heading == .magneticNorth {
            northTick.center.x = frame.width/2 // Centers x
            northTick.center.x += (CGFloat(cosd(degrees: -(newHeading.magneticHeading + 90))) * (frame.width/2 - min(northTick.frame.width/2, northTick.frame.height/2) - layer.borderWidth))
            
            northTick.center.y = frame.height/2 // Centers y
            northTick.center.y += (CGFloat(sind(degrees: -(newHeading.magneticHeading + 90))) * (frame.height/2 - min(northTick.frame.width/2, northTick.frame.height/2) - layer.borderWidth))
        }
    }
}

//
// Resources
//
public enum enumNorth {
    case trueNorth
    case magneticNorth
}

/// Cosine degrees
public func cosd(degrees:Double) -> Double {
    return cos(degrees * M_PI / 180.0)
}

/// Sine degrees
public func sind(degrees:Double) -> Double {
    return sin(degrees * M_PI / 180.0)
}
