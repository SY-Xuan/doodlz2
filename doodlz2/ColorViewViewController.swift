//
//  ColorViewViewController.swift
//  Doodlz
//
//  Created by Bossxuan on 16/11/17.
//  Copyright © 2016年 Bossxuan. All rights reserved.
//

import UIKit
protocol ColorViewControllerDelegate {
    func colorChanged(color : UIColor)
    
}
class ColorViewViewController: UIViewController {

    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var colorView: UIView!
    
    @IBAction func colorChanged(_ sender: UISlider)
    {
        colorView.backgroundColor = UIColor(displayP3Red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
        color = colorView.backgroundColor!
    }
    @IBAction func done(_ sender: UIButton) {
        self.dismiss(animated: true){
            self.delegate?.colorChanged(color: self.color)
            
        }
    }
    var color : UIColor = UIColor.black
    var delegate : ColorViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var red : CGFloat = 0.0
        var green : CGFloat = 0.0
        var blue : CGFloat = 0.0
        var alpha : CGFloat = 0.0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        alphaSlider.value = Float(alpha)
        colorView.backgroundColor = color
        
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
