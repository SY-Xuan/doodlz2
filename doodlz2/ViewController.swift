//
//  ViewController.swift
//  doodlz2
//
//  Created by Bossxuan on 16/12/3.
//  Copyright © 2016年 Bossxuan. All rights reserved.
//


import UIKit

class ViewController: UIViewController,ColorViewControllerDelegate ,StrokeViewControllerDelegate {
    //MARK : - IBAction and IBOutlet
    @IBAction func actionButtonPressed(_ sender: UIBarButtonItem)
    {
        //        let itemsToshare = ["Check out my doodle!",doodleView.image] as [Any]
        //        let activity = UIActivityViewController(activityItems: itemsToshare, applicationActivities: nil)
        //        present(activity, animated: true, completion: nil)
        let imagedata  = UIImagePNGRepresentation(doodleView.image)
        let imgobj = QQApiImageObject(data: imagedata, previewImageData: imagedata, title: "", description: "")
        let req = SendMessageToQQReq(content: imgobj)
        QQApiInterface.send(req)
        
        
        
        
    }
    
    @IBOutlet weak var doodleView: DoodleView!
    
    @IBAction func clearButtonPressed(_ sender: UIBarButtonItem)
    {
        displayEraseDialog()
    }
    @IBAction func undoButtonPressed(_ sender: UIBarButtonItem)
    {
        doodleView.undo()
    }
    //MARK : - other property
    
    
    //MARK : - other func
    func displayEraseDialog() -> Void {
        let alert = UIAlertController(title: "Are You Sure?", message: "Touch Delete to erase your doodle", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action) in
            self.doodleView.clear()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    //handle shake-to-erase
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake
        {
            displayEraseDialog()
        }
    }
    //MARK : - viewcontroller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK : - delegate
    
    func colorChanged (color: UIColor)
    {
        doodleView.drawingColor = color
    }
    func strokeWidthChanged(width: CGFloat)
    {
        doodleView.strokeWidth = width
    }
    
    
    //MARK : - prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showColorChooser"
        {
            let destination = segue.destination as! ColorViewViewController
            destination.color = doodleView.drawingColor
            destination.delegate = self
        }else if segue.identifier == "showStrokeWidthChooser"
        {
            let destination = segue.destination as! StrokeViewController
            destination.strokeWidth = doodleView.strokeWidth
            destination.delegate = self
        }
    }
}

