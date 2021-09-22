//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggtimes = ["Soft":3,"Medium":420,"Hard":720]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var time_label: UILabel!
    @IBAction func eggPressed(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        totalTime = eggtimes[hardness]!
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
        time_label.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(updateTimer), userInfo: nil, repeats: true)
        }
    
    @objc func updateTimer()
    {

        if secondsPassed < totalTime
        {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            time_label.text = "COOKING"
        }
        else {
            timer.invalidate()
            time_label.text = "DONE!"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
