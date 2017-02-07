//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Paul Donlan on 2/4/17.
//  Copyright © 2017 PDonlan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outPutLabel: UILabel!
    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    var runningNumber: String = ""
    @IBAction func onButtonTouch(_ sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outPutLabel.text = runningNumber
    }

}

