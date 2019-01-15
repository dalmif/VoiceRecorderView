//
//  ViewController.swift
//  VoiceRecorderViewSorce
//
//  Created by Mohammad Fallah on 10/21/1397 AP.
//  Copyright © 1397 Mohammad Fallah. All rights reserved.
//

import UIKit

class ViewController: UIViewController , VMVDelegate {
    func playButtonClicked() {
        voiceMessageView?.play()
    }
    
    func pauseButtonClicked() {
        voiceMessageView?.pause()
    }
    func stopButtonClicked() {
        voiceMessageView?.stop()
    }

    @IBOutlet weak var voiceMessageView: VoiceMessageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        voiceMessageView.delegate = self
    }
    
    
}

