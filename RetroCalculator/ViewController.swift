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
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Equal = "="
        case Empty = ""
    }
    var currentOperation = Operation.Empty
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
    
    @IBAction func dividePressed(_ sender: UIButton) {
//        playSound()
        mathOperation(operation: .Divide)
    }
    
    @IBAction func multiplyPressed(_ sender: UIButton) {
//        playSound()
        mathOperation(operation: .Multiply)
    }
    
    @IBAction func subtractPressed(_ sender: UIButton) {
//        playSound()
        mathOperation(operation: .Subtract)
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
//        playSound()
        mathOperation(operation: .Add)
    }
    
    @IBAction func equalPressed(_ sender:UIButton) {
//        playSound()
        mathOperation(operation: currentOperation)
        currentOperation = Operation.Empty  //clear the registers whith equal sign
    }
    
    @IBAction func clearPressed(_ sender:UIButton) {
        currentOperation = Operation.Empty
        outPutLabel.text = "Wombat!"
        runningNumber = ""
    }
    
    var runningNumber: String = ""
    @IBAction func onButtonTouch(_ sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outPutLabel.text = runningNumber
    }
    var rightHandNum: String = "0"
    var leftHandNum: String = "0"
    var result: String = "0"

    func mathOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightHandNum = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Divide {
                    result = "\(Double(leftHandNum)! / Double(rightHandNum)!)"
                } else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftHandNum)! * Double(rightHandNum)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftHandNum)! + Double(rightHandNum)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftHandNum)! - Double(rightHandNum)!)"
                }
                leftHandNum = result
                outPutLabel.text = result
        
            }
            currentOperation = operation
        } else {
            leftHandNum = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

}

