//
//  ViewController.swift
//  testCalibrate
//
//  Created by Kerrin Arora on 3/11/16.
//  Copyright © 2016 Kerrin Arora. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController {
    
    var greenAudio : AVAudioPlayer?
    var orangeAudio : AVAudioPlayer?
    var redAudio : AVAudioPlayer?
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer? {
    
        let myPathString = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
//        if let myPathString = myPathString{
        let myPathURL = NSURL(fileURLWithPath:myPathString!)
        
            
            //2
            var audioPlayer:AVAudioPlayer?
            
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL:myPathURL)
            } catch {
                print("Player not available")
            }
        return audioPlayer
    }

    //slider
    @IBOutlet weak var calibrationSlider: UISlider!
    
    
    //Instance Variables
    
//    var currentMaxMagX: Double = 0.0
//    var currentMaxMagY: Double = 0.0
//    var currentMaxMagZ: Double = 0.0
//
//    var currentMaxRotX: Double = 0.0
//    var currentMaxRotY: Double = 0.0
//    var currentMaxRotZ: Double = 0.0
    
    var movementManager = CMMotionManager()
    
    //Outlets
        //magnetism
//    @IBOutlet weak var magX: UILabel!
//    @IBOutlet weak var magY: UILabel!
//    @IBOutlet weak var magZ: UILabel!
//    @IBOutlet weak var maxMagX: UILabel!
//    @IBOutlet weak var maxMagY: UILabel!
//    @IBOutlet weak var maxMagZ: UILabel!
    @IBOutlet weak var magZDisplay: UILabel!
//
    
        //rotation
//    @IBOutlet weak var rotX: UILabel!
//    @IBOutlet weak var rotY: UILabel!
//    @IBOutlet weak var rotZ: UILabel!
//    @IBOutlet weak var maxRotX: UILabel!
//    @IBOutlet weak var maxRotY: UILabel!
//    @IBOutlet weak var maxRotZ: UILabel!
   
    @IBOutlet var background: UIView!
    
    
//    @IBAction func resetButtonPressed(sender: UIButton) {
//        currentMaxMagX = 0
//        currentMaxMagY = 0
//        currentMaxMagZ = 0
//        
////        currentMaxRotX = 0
////        currentMaxRotY = 0
////        currentMaxRotZ = 0
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(calibrationSlider)
        
//        currentMaxMagX = 0
//        currentMaxMagY = 0
//        currentMaxMagZ = 0
        
//        currentMaxRotX = 0
//        currentMaxRotY = 0
//        currentMaxRotZ = 0
        
        
        if let greenAudio = self.setupAudioPlayerWithFile("geigerGreen", type:"mp3") {
            self.greenAudio = greenAudio
           
        }
        
        if let orangeAudio = self.setupAudioPlayerWithFile("geigerOrange", type:"mp3") {
            self.orangeAudio = orangeAudio
        }
        
        if let redAudio = self.setupAudioPlayerWithFile("geigerRed", type:"mp3") {
            self.redAudio = redAudio
        }
        
//        let myPathString = NSBundle.mainBundle().pathForResource("geigerGreen", ofType: "mp3")
//        if let myPathString = myPathString{
//            print(myPathString)
//            let myPathURL = NSURL(fileURLWithPath:myPathString)
//            
//            do {
//                try greenAudio = AVAudioPlayer(contentsOfURL:myPathURL)
//            } catch {
//                print("Player not available")
//            }
//        }
        
        movementManager.magnetometerUpdateInterval = 0.2
        
//        movementManager.gyroUpdateInterval = 0.2
//        movementManager.accelerometerUpdateInterval = 0.2
        
        // Start Recording Data
        


        movementManager.startMagnetometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: {(magnetometerData: CMMagnetometerData?, NSError) -> Void in
            
            self.outputMagData(magnetometerData!.magneticField)
//                print("x: \(magnetometerData!.magneticField.x), y: \(magnetometerData!.magneticField.y), z: \(magnetometerData!.magneticField.z)")
            })

        

        
        
//        movementManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
//            
//                self.outputAccData(accelerometerData!.acceleration)
//                if(NSError != nil) {
//                    print("\(NSError)")
//            }
//        }
        
//        movementManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: { (gyroData: CMGyroData?, NSError) -> Void in
//            self.outputRotData(gyroData!.rotationRate)
//            if (NSError != nil){
//                print("\(NSError)")
//            }
//            
//            
//        })
    }
    
    
    func outputMagData(magneticField: CMMagneticField){
    
//        magX?.text = "\(magneticField.x).2fg"
//        if fabs(magneticField.x) > fabs(currentMaxMagX)
//        {
//            
//            currentMaxMagX = magneticField.x
//        }
//        
//        magY?.text = "\(magneticField.y).2fg"
//        if fabs(magneticField.y) > fabs(currentMaxMagY)
//        {
//            currentMaxMagY = magneticField.y
//        }
//        
//        magZ?.text = "\(magneticField.z).2fg"
//        if fabs(magneticField.z) > fabs(currentMaxMagZ)
//        {
//            currentMaxMagZ = magneticField.z
//        }
        
        
        var totalMagneticField = Int(fabs(magneticField.z)) + Int(calibrationSlider.value)
        
        
        magZDisplay?.text = String(totalMagneticField)
        
        
        
        
        
//        maxMagX?.text = "\(currentMaxMagX).2f"
//        maxMagY?.text = "\(currentMaxMagY).2f"
//        maxMagZ?.text = "\(currentMaxMagZ).2f"
        
        if totalMagneticField >= 510 && totalMagneticField < 600 {
            background.backgroundColor = UIColor.greenColor()
            greenAudio!.volume = 0.3
            greenAudio?.play()
        }
        else if totalMagneticField >= 600 && totalMagneticField < 800 {
            background.backgroundColor = UIColor.orangeColor()
            orangeAudio!.volume = 0.5
            orangeAudio?.play()
        }
        
        else if totalMagneticField > 800 {
            background.backgroundColor = UIColor.redColor()
            redAudio!.volume = 0.8
            redAudio?.play()
        }
        else if totalMagneticField < 510 {
            background.backgroundColor = UIColor.whiteColor()
            
        }
        
    }
    
    
    
//    func outputAccData(acceleration: CMAcceleration){
//
//        accX?.text = "\(acceleration.x).2fg"
//        if fabs(acceleration.x) > fabs(currentMaxAccelX)
//        {
//            
//            currentMaxAccelX = acceleration.x
//        }
//
//        accY?.text = "\(acceleration.y).2fg"
//        if fabs(acceleration.y) > fabs(currentMaxAccelY)
//        {
//            currentMaxAccelY = acceleration.y
//        }
//        
//        accZ?.text = "\(acceleration.z).2fg"
//        if fabs(acceleration.z) > fabs(currentMaxAccelZ)
//        {
//            currentMaxAccelZ = acceleration.z
//        }
//
//
//        maxAccX?.text = "\(currentMaxAccelX).2f"
//        maxAccY?.text = "\(currentMaxAccelY).2f"
//        maxAccZ?.text = "\(currentMaxAccelZ).2f"
//
//    }
    
    
//    func outputRotData(rotation: CMRotationRate){
//
//
//        rotX?.text = "\(rotation.x).2fr/s"
//        if fabs(rotation.x) > fabs(currentMaxRotX)
//        {
//            currentMaxRotX = rotation.x
//        }
//        
//        rotY?.text = "\(rotation.y).2fr/s"
//        if fabs(rotation.y) > fabs(currentMaxRotY)
//        {
//            currentMaxRotY = rotation.y
//        }
//        
//        rotZ?.text = "\(rotation.z).2fr/s"
//        if fabs(rotation.z) > fabs(currentMaxRotZ)
//        {
//            currentMaxRotZ = rotation.z
//        }
//
//        maxRotX?.text = "\(currentMaxRotX).2f"
//        maxRotY?.text = "\(currentMaxRotY).2f"
//        maxRotZ?.text = "\(currentMaxRotZ).2f"
//        
//    
//    }
//    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

