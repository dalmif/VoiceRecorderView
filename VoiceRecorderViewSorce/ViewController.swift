//
//  ViewController.swift
//  VoiceRecorderViewSorce
//
//  Created by Mohammad Fallah on 10/21/1397 AP.
//  Copyright © 1397 Mohammad Fallah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var waveSoundView: WaveSoundView!
    override func viewDidLoad() {
        super.viewDidLoad()
       Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
    }

    @objc func timerFunc () {
        let randomInt = Int.random(in: 20..<99)
        waveSoundView.addBar(percent: CGFloat(randomInt))
    }
}

