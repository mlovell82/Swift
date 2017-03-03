// This file creates the KaleidoView rectangles
//  KaleidoView.swift
//  KaleidoView
//
//  Created by Dr. Dale Haverstock
//  Copyright © 2017 Guest User. All rights reserved.
// move() and getFrame() modified by Mick Lovell

import UIKit

class KaleidoView: UIView {

    var colorMin : CGFloat = 0.0
    var colorMax : CGFloat = 1.0
    var alphaMin : CGFloat = 0.0
    var alphaMax : CGFloat = 1.0
    
    var useAlpha = false
    
    // Speed, the smaller the delay the greater the speed
    var delay : TimeInterval = 1.0
    
    // Needed for animation
    var timer : Timer?
    
    var views : [UIView] = Array()
    var currentView = 0
    var viewCount = 40
    
    func move() {
        if views.count < viewCount + 4 {
            addNewView()
            addNewView()
            addNewView()
            addNewView()
            currentView = views.count - 4
        }
        
        // Construct the frame
        var newFrame = getFrame()
        
        views[currentView].frame = newFrame[0]
        currentView += 1
        views[currentView].frame = newFrame[1]
        currentView += 1
        views[currentView].frame = newFrame[2]
        currentView += 1
        views[currentView].frame = newFrame[3]
        
        views[currentView].backgroundColor = getRandomColor()
        views[currentView - 1].backgroundColor = views[currentView].backgroundColor
        views[currentView - 2].backgroundColor = views[currentView].backgroundColor
        views[currentView - 3].backgroundColor = views[currentView].backgroundColor
        
        
        currentView += 1
        if currentView >= views.count {
            currentView = 0
        }
    }
    
    func addNewView() {
        // Construct the frame
        
        let colorSubView = UIView()
        views.append(colorSubView)
        
        self.addSubview(colorSubView)
    }
    
    func getFrame() -> [CGRect] {
        // Get values for the frame
        let randX = getRandomFrom(min:160.0, thruMax:frame.size.width - 40)
        let randY = getRandomFrom(min:240.0, thruMax:frame.size.height - 40)
        let randWidth = getRandomFrom(min: 20, thruMax: 60)
        let randHeight = getRandomFrom(min: 30, thruMax: 80)
        
        let other = CGPoint(x: randX, y: randY)
        let otherX = offSetX(name: other.x) // call of helper function 1
        let otherY = offSetY(name: other.y) // call of helper function 2
        // Construct the frame
        var newFrame : [CGRect] = []
        newFrame.append(CGRect(x: randX, y: randY, width: randWidth, height: randHeight))
        newFrame.append(CGRect(x: 160.0 - (otherX), y: randY, width: randWidth, height: randHeight))
        newFrame.append(CGRect(x: 160.0 - (otherX), y: 240.0 - (otherY), width: randWidth, height: randHeight))
        newFrame.append(CGRect(x: randX, y: 240.0 - (otherY), width: randWidth, height: randHeight))
        
        return (ul:newFrame)
    }
    
    func startDrawing()
    {
        // Set timer, Target/Action pattern used here
        timer = Timer(timeInterval: delay,
                      target    : self,
                      selector  : #selector(KaleidoView.move),
                      userInfo  : nil,
                      repeats   : true)
        
        // Get the runloop, add timer to runloop
        let runLoop = RunLoop.current
        runLoop.add(timer!,
                    forMode:RunLoopMode(rawValue:"NSDefaultRunLoopMode"))
    }
    
    func getRandomColor() -> UIColor
    {
        // Random values for color RGB and possible alpha
        let randRed   = getRandomFrom(min:colorMin, thruMax:colorMax)
        let randGreen = getRandomFrom(min:colorMin, thruMax:colorMax)
        let randBlue  = getRandomFrom(min:colorMin, thruMax:colorMax)
        
        var alpha : CGFloat = 1.0
        
        // If using a random alpha is specified
        if useAlpha
        { alpha = getRandomFrom(min:alphaMin, thruMax:alphaMax) }
        
        // Create the color
        let color = UIColor(    red:randRed,
                                green:randGreen,
                                blue:randBlue,
                                alpha:alpha)
        
        return color
    }
    
    func getRandomFrom(min:CGFloat, thruMax max:CGFloat)-> CGFloat
    {
        // We need this to avoid division by 0
        guard max > min else {
            return min
        }
        
        // arc4random returns unsigned 64 bit value, so divide by 2
        let randomNum = Int(arc4random() / 2)
        
        // Three decimal places, ex: 0.999 becomes 999.0
        let accuracy : CGFloat = 1000.0
        
        // Basically a left shift of 3 digits
        let scaledMin : CGFloat = min * accuracy
        let scaledMax : CGFloat = max * accuracy
        
        // Put the value in the specified range of values
        let randomInRange = CGFloat(randomNum % Int(scaledMax - scaledMin))
        
        // Effectively a right shift, then put the min back
        let randomResult = randomInRange / accuracy + min
        
        return randomResult
    }
    
    func offSetX(name:CGFloat) -> CGFloat // helper function 1
    {
        let centerX = CGPoint(x: 160.0, y: 0) // the x value of the screen's center
        let offSetX = name - centerX.x
        return offSetX
    }
    
    func offSetY(name:CGFloat) -> CGFloat // helper function 2
    {
        let centerY = CGPoint(x: 0, y: 240.0) // the x value of the screen's center
        let offSetY = name - centerY.y
        return offSetY
    }
    
    


}
