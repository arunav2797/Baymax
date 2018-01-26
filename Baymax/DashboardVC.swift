//
//  DashboardVC.swift
//  Baymax
//
//  Created by Rishabh Mittal on 28/10/17.
//  Copyright © 2017 Rishabh Mittal. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    static var dash: DashboardVC = DashboardVC()

    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    @IBAction func unwindToDashboard(segue: UIStoryboardSegue) {}

    @IBOutlet weak var bottomCard: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var masterCard: UIView!
    
    var cases = ["Dengue","Malaria", "Typhoid", "Swine Flu", "Pox"]
    var numbers = ["10","05","11","02","04"]

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let colorTop =  UIColor(red: 51.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 15.0/255.0, green: 12.0/255.0, blue: 12.0/255.0, alpha: 1.0).cgColor
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor(red: 1, green: 0.6039, blue: 0, alpha: 1.0)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        masterCard.layer.cornerRadius = 12
        masterCard.clipsToBounds = true
        
        masterCard.layer.shadowOpacity = 0.3
        masterCard.layer.shadowRadius = 6
        masterCard.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom, colorTop]
        gradientLayer.startPoint = CGPoint(x: 0.2, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 1)
        gradientLayer.frame = self.cardView.bounds
        self.cardView.layer.insertSublayer(gradientLayer, at:0)
        self.cardView.layer.cornerRadius = 12.0
        self.cardView.clipsToBounds = true
        
        let gradientLayer7 = CAGradientLayer()
        gradientLayer7.colors = [colorBottom, colorTop]
        gradientLayer7.startPoint = CGPoint(x: 0.2, y: 0)
        gradientLayer7.endPoint = CGPoint(x: 0.8, y: 1)
        gradientLayer7.frame = self.bottomCard.bounds
        self.bottomCard.layer.insertSublayer(gradientLayer7, at:0)
        self.bottomCard.clipsToBounds = true
        
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
        
        let gradientLayer2 = CAGradientLayer()
        gradientLayer2.colors = [ colorBottom, colorTop]
        gradientLayer2.startPoint = CGPoint(x: 0.3, y: 0)
        gradientLayer2.endPoint = CGPoint(x: 0.7, y: 1)
        gradientLayer2.frame = self.masterCard.bounds
        self.masterCard.layer.insertSublayer(gradientLayer2, at:0)
    }
    
    func displayAlert() {
        let alert = UIAlertController(title: "Emergency", message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Ola!", style: .default, handler: nil)
        alert.addAction(confirm)
        self.present(alert, animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width*0.5, height: collectionView.bounds.size.width*0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 0, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DashboardCollectionViewCell
        cell.layer.cornerRadius = 12.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        
        let gradientLayer4 = CAGradientLayer()
        gradientLayer4.colors = [colorBottom, colorTop]
        gradientLayer4.startPoint = CGPoint(x: 0.2, y: 0)
        gradientLayer4.endPoint = CGPoint(x: 0.8, y: 1)
        gradientLayer4.frame = cell.layer.bounds
        cell.layer.insertSublayer(gradientLayer4, at:0)
        
        cell.clipsToBounds = true
        
        cell.diseaseLabel.text = cases[indexPath.row]
        cell.number.text = numbers[indexPath.row]
        
        return cell
    }

    @IBAction func findHosps(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string:"http://www.google.com/#q=hospitals%20near%20me")! as URL)
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
