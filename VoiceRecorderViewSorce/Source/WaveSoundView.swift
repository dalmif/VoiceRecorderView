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
    let barOpacityCount : CGFloat = 9
    var rightOpacity = true
    var leftOpacity = false
    let playingMode = true
    let played = 15
    let grayLightColor = UIColor(red: 213.0/255, green: 216.0/255, blue: 219.0/255, alpha: 1.0)
    @IBInspectable var lineWidth : Float = 4 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var lineColor :UIColor  = UIColor.blue {
        didSet {
              setNeedsDisplay()
        }
    }
    @IBInspectable var marginTopDown : CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var marginLeft : CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    var arrayOfBounds : [CGFloat] = [100]
    override func draw(_ rect: CGRect) {
        let height = rect.height - marginTopDown
        let width = rect.width
        let total = width / (marginLeft + CGFloat(lineWidth))
        if (arrayOfBounds.count > Int(total)) {
            rightOpacity = true
        }
        var diff = arrayOfBounds.count - Int(total)
        if diff < 0 {diff = 0}
        for i in 0 ... min(Int(total),arrayOfBounds.count)-1 {
            let currentX = CGFloat(i) * (marginLeft + CGFloat(lineWidth)) + marginLeft
            let spaceFromTopAndDown = (height - (height * arrayOfBounds[diff + i]/100))/2
            let linePath = UIBezierPath()
            linePath.lineCapStyle = .round
            linePath.lineWidth = CGFloat(lineWidth)
            linePath.move(to: CGPoint(x: currentX, y: spaceFromTopAndDown + marginTopDown))
            linePath.addLine(to: CGPoint(x: currentX, y: height-spaceFromTopAndDown))
            var alpha : CGFloat = 1
            if (leftOpacity && i < Int(barOpacityCount)) || (rightOpacity && i > Int(total - barOpacityCount)) {
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
