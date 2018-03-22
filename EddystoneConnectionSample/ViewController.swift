//
//  ViewController.swift
//  EddystoneConnectionSample
//
//  Created by Edwin Alvarado on 3/22/18.
//  Copyright © 2018 Edwin Alvarado. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, BeaconScannerDelegate {
    
    var beaconScanner: BeaconScanner!
    
    // ContainerView
    let containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor.black
        return container
    }()
    
    let messageText: LabelMedium = LabelMedium(
        text: "Nothing Around",
        size: 14,
        lineSpacing: 7, aligment: .center)
    
    let distanceText: LabelMedium = LabelMedium(
        text: "0 mts",
        size: 14,
        lineSpacing: 7, aligment: .center)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.beaconScanner = BeaconScanner()
        self.beaconScanner!.delegate = self
        self.beaconScanner!.startScanning()
        
        self.addViews()
    }
    
    //----------------------------------Beacon method's----------------------------
    func didFindBeacon(beaconScanner: BeaconScanner, beaconInfo: BeaconInfo) {
        NSLog("FIND: %@", beaconInfo.description)
    }
    
    func didLoseBeacon(beaconScanner: BeaconScanner, beaconInfo: BeaconInfo) {
        NSLog("LOST: %@", beaconInfo.description)
    }
    
    func didUpdateBeacon(beaconScanner: BeaconScanner, beaconInfo: BeaconInfo) {
        NSLog("UPDATE: %@", beaconInfo.description)
        UI() {
            // everything in here will execute on the main thread
            self.setNearbyBeacon(beacon: beaconInfo.description, rssi: beaconInfo.RSSI, txPower: beaconInfo.txPower)
        }
    }
    
    func didObserveURLBeacon(beaconScanner: BeaconScanner, URL: NSURL, RSSI: Int) {
        NSLog("URL SEEN: %@, RSSI %d", URL, RSSI)
    }

    
    func addViews(){
        
        self.view.addSubview(self.containerView)
        
        self.containerView.buildingAnchorConstraint(
            referenceView: self.view,
            heightAnchorMultiplier: 1,
            widthAnchorMultiplier: 1,
            centerXAnchor: true,
            centerYAnchor: true
        )
        
        self.containerView.backgroundColor = .white
        self.containerView.layoutIfNeeded()
        
        self.containerView.addSubview(self.messageText)
        self.messageText.buildingAnchorConstraint(
            referenceView: self.containerView,
            topAnchorConstant: 44,
            widthAnchorMultiplier: 0.574,
            centerXAnchor: true,
            fixedHeight: 80)
        
        self.messageText.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.messageText.numberOfLines = 0

        self.containerView.addSubview(self.distanceText)
        self.distanceText.buildingAnchorConstraint(
            referenceView: self.containerView,
            topAnchorConstant: 100,
            widthAnchorMultiplier: 0.574,
            centerXAnchor: true,
            fixedHeight: 80)
        
        self.distanceText.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.distanceText.numberOfLines = 0

    }
    
    func setNearbyBeacon(beacon: String, rssi: Int, txPower: Int){
        
        self.messageText.setAttributedStringText(text: beacon)
        self.distanceText.setAttributedStringText(text: "Distance: " + " " + String(format:"%.1f", getDistance(rssi: rssi, txPower: txPower)))
        
        self.containerView.layoutIfNeeded()
    }
    
    func BG(_ block: @escaping ()->Void) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
    
    func UI(_ block: @escaping ()->Void) {
        DispatchQueue.main.async(execute: block)
    }
    
    func getDistance(rssi: Int, txPower: Int, eddy:Bool = true) -> Double {
        /*
         * RSSI = TxPower - 10 * n * lg(d)
         * n = 2 (in free space)
         *
         * d = 10 ^ ((TxPower - RSSI) / (10 * n))
         */
        
        let distance = pow(10, (Double((eddy ? txPower-41 : txPower) - rssi) / Double(10 * 2)))
    
        return distance
    }
    

}

