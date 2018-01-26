//
//  SympSelectionViewController.swift
//  Baymax
//
//  Created by Rishabh Mittal on 29/10/17.
//  Copyright © 2017 Rishabh Mittal. All rights reserved.
//

import UIKit

class SympSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var categoryChosen: UILabel!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categoryReceived = ""
    var data = [symptomStruct]()
    
    let colorTop =  UIColor(red: 51.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 15.0/255.0, green: 12.0/255.0, blue: 12.0/255.0, alpha: 1.0).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryChosen.text = categoryReceived
        setGradientBackground()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func setGradientBackground() {
        let gradientLayer5 = CAGradientLayer()
        gradientLayer5.colors = [ colorTop, colorBottom]
        gradientLayer5.startPoint = CGPoint(x: 0.2, y: 0)
        gradientLayer5.endPoint = CGPoint(x: 0.8, y: 1)
        gradientLayer5.frame = self.backgroundView.bounds
        self.backgroundView.layer.insertSublayer(gradientLayer5, at:0)
        
        let gradientLayer6 = CAGradientLayer()
        gradientLayer6.colors = [colorBottom, colorTop]
        gradientLayer6.startPoint = CGPoint(x: 0.2, y: 0)
        gradientLayer6.endPoint = CGPoint(x: 0.8, y: 1)
        gradientLayer6.frame = self.card.bounds
        self.card.layer.insertSublayer(gradientLayer6, at:0)
        self.card.layer.cornerRadius = 12.0
        self.card.clipsToBounds = true
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width*0.29, height: collectionView.bounds.size.height*0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 0, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SympSelCollectionViewCell
        cell.layer.cornerRadius = 12.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        
        cell.titleLabel.text = data[indexPath.row].name
        
        if addedItems.contains(data[indexPath.row].name){
            cell.layer.backgroundColor = UIColor.orange.cgColor
            cell.titleLabel.textColor = UIColor.black
            data[indexPath.row].selected = "yes"
        }
        else {
            cell.layer.backgroundColor = UIColor(red: 16.0/255.0, green: 13.0/255.0, blue: 13.0/255.0, alpha: 1.0).cgColor
            cell.clipsToBounds = true
            cell.titleLabel.textColor = UIColor.white
            data[indexPath.row].selected = "no"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if data[indexPath.row].selected == "no" {
            if addedItems.count<5 {
                self.data[indexPath.row].selected = "yes"
                addedItems.append(data[indexPath.row].name)
            }
            else {
                let alert = UIAlertController(title: "Hold on!", message: "You can only select upto 5 symptoms.", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "Alright!", style: .default, handler: nil)
                alert.addAction(confirm)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        else {
            data[indexPath.row].selected = "no"
            let i = addedItems.index(of: data[indexPath.row].name)
            addedItems.remove(at: i!)
        }
        print("Added Items: ")
        print(addedItems)
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            self.performSegue(withIdentifier: "showAnalysis1", sender: Any?.self)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToCategories", sender: Any?.self)
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
