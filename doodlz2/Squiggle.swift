//
//  Squiggle.swift
//  Doodlz
//
//  Created by Bossxuan on 16/11/17.
//  Copyright © 2016年 Bossxuan. All rights reserved.
//

import UIKit

class Squiggle: UIBezierPath
{
    var color : UIColor
    
    init(color : UIColor , strokeWidth : CGFloat)
    {
        self.color = color
        super.init()
        self.lineWidth = strokeWidth
        self.lineCapStyle = .round //路径末端点的外观
        self.lineJoinStyle = .round //路径的组件是如何被联系在一起的
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    override func stroke() {
        color.setStroke()
        super.stroke()
    }
    
}
