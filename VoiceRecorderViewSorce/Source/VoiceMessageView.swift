//
//  VoiceMessageView.swift
//  VoiceRecorderViewSorce
//
//  Created by Mohammad Fallah on 10/25/1397 AP.
//  Copyright © 1397 Mohammad Fallah. All rights reserved.
//

import UIKit
protocol VMVDelegate {
    func playButtonClicked()
    func stopButtonClicked()
    func pauseButtonClicked()
}
@IBDesignable
class VoiceMessageView: UIView {
    var delegate : VMVDelegate?
    @IBOutlet weak var bgPlayerButton: UIView!
    @IBOutlet weak var playBtnImage: UIImageView!
    var isPlaying = false
    @IBOutlet weak var timeLabel: UILabel!
    @IBAction func stopBtnClicked(_ sender: Any) {
        isPlaying = false
        delegate?.stopButtonClicked()
        let defVal = self.frame.origin
        self.frame.origin = CGPoint(x: self.frame.origin.x,
                                                  y: self.frame.origin.y + 30)
        UIView.animate(withDuration: 1, delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5, options:  UIView.AnimationOptions(), animations: {
                        self.frame.origin = defVal
        }, completion: nil)
        switchImageBtn(to: false)
    }
    @IBAction func playBtnClicked(_ sender: Any) {
        if (!isPlaying) {
            delegate?.playButtonClicked()
        }
        else {
            delegate?.pauseButtonClicked()
        }
        isPlaying = !isPlaying
        switchImageBtn(to: isPlaying)
        
    }
    @IBInspectable var tintColorShape : UIColor = UIColor.blue {
        didSet {
            waveSoundView?.lineColor = tintColorShape
            timeLabel.textColor = tintColorShape
            bgPlayerButton.backgroundColor = tintColorShape
        }
    }
    @IBInspectable var waveUnPlayedLineColor : UIColor = UIColor.gray {
        didSet {
            waveSoundView?.grayLightColor = waveUnPlayedLineColor
        }
    }
    @IBInspectable var waveLineWidth : Float = 3 {
        didSet {
            waveSoundView?.lineWidth = waveLineWidth
        }
    }
    @IBInspectable var waveMarginTopDown : CGFloat = 3 {
        didSet {
            waveSoundView?.marginTopDown = waveMarginTopDown
        }
    }
    @IBInspectable var waveMarginLeft : Float = 3 {
        didSet {
            waveSoundView?.marginLeft = waveMarginLeft
        }
    }
    var barOpacityCount : CGFloat = 9 {
        didSet {
            setNeedsDisplay()
        }
    }
    var waveRightOpacity = true {
        didSet {
              waveSoundView?.rightOpacity = waveRightOpacity
        }
    }
    var waveLeftOpacity = false {
        didSet {
             waveSoundView?.leftOpacity = waveLeftOpacity
        }
    }
    var playingMode = true {
        didSet {
            waveSoundView?.playingMode = playingMode
        }
    }
     var countBarPlayed = 15 {
        didSet {
             waveSoundView?.played = countBarPlayed
        }
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var waveSoundView: WaveSoundView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    func commonInit(){
        Bundle.main.loadNibNamed("VoiceMessageView", owner: self, options: [:])![0]
        addSubview(contentView)
        contentView?.frame = self.bounds
        contentView?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: -1, height: 1)
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOpacity = 0.05
    }
    
    
    var timer : Timer?
    var time: Float = 0
    var stopRepeat = 0
    var stopPassed : Int = 0
    var stopped = false
    func play (){
        if (stopped) {
            waveSoundView?.arrayOfBounds.removeAll()
            waveSoundView?.arrayOfBounds.append(100)
            stopped = false
        }
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(playTimerFunc), userInfo: nil, repeats: true)
        waveSoundView?.start()
    }
    func pause() {
        if (isPlaying){
         timer?.invalidate()
        }
    }
    func stop (){
        stopped = true
        timer?.invalidate()
        waveSoundView?.stop()
        time = 0
        stopRepeat = waveSoundView?.getDisatanceToEnd() ?? 0
        print(stopRepeat)
        if (stopRepeat > 0){
            timer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(stopTimerFunc), userInfo: nil, repeats: true)
        }
    }
    
    @objc func stopTimerFunc () {
        if (stopRepeat >= stopPassed){
            waveSoundView?.steppedStop()
           stopPassed += 1
        }
        else {
            stopPassed = 0
            timer?.invalidate()
        }
    }
    @objc func playTimerFunc () {
        let randomInt = Int.random(in: 20..<99)
        time += 0.1
        var timeSec = Int(time)
        var min : Int = 0
        waveSoundView?.addBar(percent: CGFloat(randomInt))
        min = (timeSec / 60)
        if (timeSec > 60) {
            timeSec = timeSec % 60
        }
        timeLabel.text = "\(String(format: "%02d", min)):\(String(format: "%02d", timeSec))"
    }
    func addWave (percent : CGFloat){
        waveSoundView?.addBar(percent: percent)
    }
    func switchImageBtn(to play:Bool) {
        if (!play) {
            playBtnImage.image = #imageLiteral(resourceName: "play")
        }
        else{
           playBtnImage.image = #imageLiteral(resourceName: "pause")
        }
    }
}
