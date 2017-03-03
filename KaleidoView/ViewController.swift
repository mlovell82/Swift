//
//  ViewController.swift
//  KaleidoView
//
//  Created Dr. Dale Haverstock
//  Copyright © 2017 Guest User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let colorView = self.view as! KaleidoView
        
        colorView.startDrawing()
    }

   

}
