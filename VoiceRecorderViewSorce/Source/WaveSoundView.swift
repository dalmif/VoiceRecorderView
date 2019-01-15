//
//  WaveSoundView.swift
//  VoiceRecorderViewSorce
//
//  Created by Mohammad Fallah on 10/21/1397 AP.
//  Copyright © 1397 Mohammad Fallah. All rights reserved.
//

import UIKit
@IBDesignable
class WaveSoundView: UIView {
    var barOpacityCountPrivate : CGFloat = 0
    var barOpacityCount : CGFloat = 9
    var stopping = false
    var rightOpacity = true
    var leftOpacity = false
    var playingMode = true {
        didSet {
            setNeedsDisplay()
        }
    }
    var played = 15
    var playedPrivate = 0
    var grayLightColor = UIColor(red: 213.0/255, green: 216.0/255, blue: 219.0/255, alpha: 1.0) {
        didSet {
            setNeedsDisplay()
        }
    }
    var lineWidth : Float = 4 {
        didSet {
            setNeedsDisplay()
        }
    }
    var lineColor :UIColor  = UIColor.blue {
        didSet {
              setNeedsDisplay()
        }
    }
    var marginTopDown : CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    var marginLeft : Float = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    var arrayOfBounds : [CGFloat] = [100]
    private var total : CGFloat = 0
    override func draw(_ rect: CGRect) {
        let height = rect.height - marginTopDown
        let width = rect.width
        total = width / CGFloat(marginLeft + lineWidth)
        if (arrayOfBounds.count > Int(total) && !stopping) {
           rightOpacity = true
        }
        var diff = arrayOfBounds.count - Int(total)
        if diff < 0 {diff = 0}
        for i in 0 ... min(Int(total),arrayOfBounds.count)-1 {
            let currentX : CGFloat = CGFloat(Float(i) * (marginLeft + lineWidth) + marginLeft)
            let disFromTopDown = (height - (height * arrayOfBounds[diff + i]/100))/2
            let linePath = UIBezierPath()
            linePath.lineCapStyle = .round
            linePath.lineWidth = CGFloat(lineWidth)
            linePath.move(to: CGPoint(x: currentX, y: disFromTopDown + marginTopDown))
            linePath.addLine(to: CGPoint(x: currentX, y: height-disFromTopDown))
            var alpha : CGFloat = 1
            if ((leftOpacity && i < Int(barOpacityCount))) || (rightOpacity && i > Int(total - barOpacityCount)) {
                alpha = (i < Int(barOpacityCount) ? CGFloat(i) : (total - CGFloat(i)))  * (1/barOpacityCount)
            }
            var currentColor = lineColor
            if playingMode && i > played {
                currentColor = grayLightColor
            }
            currentColor.withAlphaComponent(alpha).setStroke()
            linePath.stroke()
        }
    }
    func stop (){
        barOpacityCountPrivate = barOpacityCount
        playedPrivate = played
         stopping = true
    }
    func start (){
        if (stopping){
            stopping = false
            barOpacityCount = barOpacityCountPrivate
            played = playedPrivate
        }
    }
    func steppedStop(){
       
        if (barOpacityCount <= 2) {
            rightOpacity = false
        }
        
        if (played < Int(total)) {played += 1}
        if barOpacityCount>0 { barOpacityCount -= 1 }
        setNeedsDisplay()
    }
    func getDisatanceToEnd ()-> Int {
        return arrayOfBounds.count > Int(total) ? Int(total) - played : 0
    }
    func addBar(percent : CGFloat, at : Int = -1)
    {
        if (at == -1){
            arrayOfBounds.append(percent)
        }
        else {
              arrayOfBounds.insert(percent, at: at)
        }
        setNeedsDisplay()
    }

}
