//
//  StrokeViewController.swift
//  Doodlz
//
//  Created by Bossxuan on 16/11/17.
//  Copyright © 2016年 Bossxuan. All rights reserved.
//

import UIKit
protocol StrokeViewControllerDelegate {
    func strokeWidthChanged(width : CGFloat)
}
class SampleLineView: UIView {
    var sampleLine = UIBezierPath()
    
    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        let y = frame.height / 2
        sampleLine.move(to: CGPoint(x: 10, y: y))
        sampleLine.addLine(to: CGPoint(x: frame.width - 10, y: y))
        
    }
    override func draw(_ rect: CGRect) {
        UIColor.black.setStroke()
        sampleLine.stroke()
    }
}
class StrokeViewController: UIViewController {
    
    
    @IBOutlet weak var strokeWidthSlider: UISlider!
    @IBOutlet weak var strokeWidthView: SampleLineView!
    @IBAction func lineWidthChanged(_ sender: UISlider) {
        strokeWidth = CGFloat(sender.value)
        strokeWidthView.sampleLine.lineWidth = strokeWidth
        strokeWidthView.setNeedsDisplay()
    }
    @IBAction func done(_ sender: UIButton)
    {
        dismiss(animated: true, completion: {
            self.delegate?.strokeWidthChanged(width: self.strokeWidth)
        })
    }
    var strokeWidth : CGFloat = 10.0
    var delegate : StrokeViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        strokeWidthSlider.value = Float(strokeWidth)
        strokeWidthView.sampleLine.lineWidth = strokeWidth
        strokeWidthView.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
