//
//  DoodleView.swift
//  Doodlz
//
//  Created by Bossxuan on 16/11/17.
//  Copyright © 2016年 Bossxuan. All rights reserved.
//

import UIKit

class DoodleView: UIView
{
    var strokeWidth : CGFloat = 10.0
    var drawingColor : UIColor = UIColor.black
    fileprivate var finishedSquiggles: [Squiggle] = []
    fileprivate var currentSquiggles : [UITouch : Squiggle] = [:]
    var image : UIImage
        {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0.0)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
            //第一行函数会创建图形上下文，第一个参数是将要被创建的位图图片的尺寸，第二个参数是判断位图图片是否透明，最后一个参数是通过特定的像素点来缩放图像。设置为0.0表示图片和屏幕有同样的缩放比例。第二行，CALayer类的render方法接受一个图形上下文作为他的参数，并将UIView的内容渲染到图形上下文中，UIGraphicsGetCurrentContext函数会返回第一行创建的当前的图形上下文。第三行调用的函数，会返回一个真该绘制的图片对象。第四行是终止图形上下文，将资源返回给系统
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        for squiggle in finishedSquiggles
        {
            squiggle.stroke()
        }
        for squiggle in currentSquiggles.values
        {
            squiggle.stroke()
        }
    }
 
    required init?(coder eDecoder: NSCoder) {
        super.init(coder : eDecoder)
        self.isMultipleTouchEnabled = true
    }
    
    //MARK : touch 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let squiggle = Squiggle(color: drawingColor, strokeWidth: strokeWidth)
            squiggle.move(to: touch.location(in: self))
            currentSquiggles[touch] = squiggle
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            currentSquiggles[touch]?.addLine(to: touch.location(in: self))
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            if let squiggle = currentSquiggles[touch]
            {
                finishedSquiggles.append(squiggle)
            }
            currentSquiggles[touch] = nil
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentSquiggles.removeAll()
    }
    //MARK : other func
    
    func undo()
    {
        if finishedSquiggles.count > 0
        {
            finishedSquiggles.removeLast()
            self.setNeedsDisplay()
        }
    }
    
    func clear()
    {
        finishedSquiggles.removeAll()
        self.setNeedsDisplay()//告诉系统视图需要重新绘制
    }
}
