//
//  AboutViewController.swift
//  Baymax
//
//  Created by Rishabh Mittal on 29/10/17.
//  Copyright © 2017 Rishabh Mittal. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        // Do any additional setup after loading the view.
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 51.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 15.0/255.0, green: 12.0/255.0, blue: 12.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.2, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 1)
        gradientLayer.frame = self.backgroundView.bounds
        self.backgroundView.layer.insertSublayer(gradientLayer, at:0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToDashboard", sender: Any?.self)
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
