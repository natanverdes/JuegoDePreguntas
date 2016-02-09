//
//  WinnerViewController.swift
//  JuegoDePreguntas
//
//  Created by  on 4/11/15.
//  Copyright © 2015 Natán Verdés. All rights reserved.
//

import UIKit

class WinnerViewController: UIViewController {

    var puntuacion: Int!
    @IBOutlet weak var puntuacionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Record puntuación
        
        if(NSUserDefaults.standardUserDefaults().stringForKey("Puntuacion") == nil){
            NSUserDefaults.standardUserDefaults().setValue("0", forKey: "Puntuacion")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        
        if(Int(NSUserDefaults.standardUserDefaults().stringForKey("Puntuacion")!)! < self.puntuacion){
            NSUserDefaults.standardUserDefaults().setValue(String(self.puntuacion), forKey: "Puntuacion")
            NSUserDefaults.standardUserDefaults().synchronize()
        }        
        
        puntuacionLabel.text = "¡Has acertado " + String(self.puntuacion) + " preguntas sobre 5 (" + String(self.puntuacion * 100 / 5) + "%)!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(animated: Bool) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(self.puntuacion, forKey: "Puntuacion")
    }

    @IBAction func returnButtonTouchUpInside(sender: AnyObject) {
        let presentingViewController :UIViewController! = self.presentingViewController;
        
        self.dismissViewControllerAnimated(false) {
            presentingViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
}
