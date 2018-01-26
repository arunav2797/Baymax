//
//  SymptomsVC.swift
//  Baymax
//
//  Created by Rishabh Mittal on 28/10/17.
//  Copyright © 2017 Rishabh Mittal. All rights reserved.
//

import UIKit

class SymptomsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func unwindToCategories(segue: UIStoryboardSegue) {}
    
    var commonSymps = ["vomiting","fever","fatigue","diarrhea","pain chest"]
    var thumbnails = ["vomiting","fever","fatigue","diarrhea","pain chest"]
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var card2: UIView!
    @IBOutlet weak var card1: UIView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let colorTop =  UIColor(red: 51.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 15.0/255.0, green: 12.0/255.0, blue: 12.0/255.0, alpha: 1.0).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.9373, green: 0.6039, blue: 0.2588, alpha: 1.0)
        
        self.card1.layer.cornerRadius = 12.0
        self.card2.layer.cornerRadius = 12.0
        self.card1.clipsToBounds = true
        self.card2.clipsToBounds = true
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        // Do any additional setup after loading the view.
        setGradientBackground()
    }
    
    func setGradientBackground() {
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
        gradientLayer2.frame = self.card1.bounds
        self.card1.layer.insertSublayer(gradientLayer2, at:0)
        
        let gradientLayer3 = CAGradientLayer()
        gradientLayer3.colors = [ colorBottom, colorTop]
        gradientLayer3.startPoint = CGPoint(x: 0.3, y: 0)
        gradientLayer3.endPoint = CGPoint(x: 0.7, y: 1)
        gradientLayer3.frame = self.card2.bounds
        self.card2.layer.insertSublayer(gradientLayer3, at:0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commonSymps.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width*0.45, height: collectionView.bounds.size.width*0.45)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 0, 10)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CommonSympsCollectionViewCell
        cell.layer.cornerRadius = 15.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        cell.titleLabel.text = commonSymps[indexPath.row]
        
        if addedItems.contains(commonSymps[indexPath.row]){
            cell.layer.borderColor = UIColor.orange.cgColor
        }
        else {
            cell.layer.borderColor = UIColor(red: 16.0/255.0, green: 13.0/255.0, blue: 13.0/255.0, alpha: 1.0).cgColor
        }
        cell.backgroundColor = UIColor(red: 16.0/255.0, green: 13.0/255.0, blue: 13.0/255.0, alpha: 1.0)
        cell.layer.borderWidth = 1.0
        cell.clipsToBounds = true
        cell.thumbnail.image = UIImage(named: thumbnails[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !(addedItems.contains(commonSymps[indexPath.row])) {
            if addedItems.count<5 {
                addedItems.append(commonSymps[indexPath.row])
            }
            else {
                let alert = UIAlertController(title: "Hold on!", message: "You can only select upto 5 symptoms.", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "Alright!", style: .default, handler: nil)
                alert.addAction(confirm)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        else {
            let i = addedItems.index(of: commonSymps[indexPath.row])
            addedItems.remove(at: i!)
        }
        print("Added Items: ")
        print(addedItems)
        collectionView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPain" {
            let dvc = segue.destination as! SympSelectionViewController
            dvc.categoryReceived = "pain"
            dvc.data = pain
        }
        else if segue.identifier == "showActive" {
            let dvc = segue.destination as! SympSelectionViewController
            dvc.categoryReceived = "Movement"
            dvc.data = active
        }
        else if segue.identifier == "showPsycho" {
            let dvc = segue.destination as! SympSelectionViewController
            dvc.categoryReceived = "Psychological"
            dvc.data = psycho
        }
        else if segue.identifier == "showFluid" {
            let dvc = segue.destination as! SympSelectionViewController
            dvc.categoryReceived = "Fluid Discharge"
            dvc.data = fluid
        }
    }
    
    @IBAction func predictButton(_ sender: Any) {
        if addedItems.count != 5 {
            let alert = UIAlertController(title: "Hold on!", message: "You need to select atleast 5 symptoms.", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "Alright!", style: .default, handler: nil)
            alert.addAction(confirm)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            DataHandler.shared.postSymptoms()
            self.performSegue(withIdentifier: "showAnalysis2", sender: Any?.self)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToDashboard", sender: Any?.self)
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
