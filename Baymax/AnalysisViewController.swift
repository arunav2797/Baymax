//
//  AnalysisViewController.swift
//  Baymax
//
//
//  Copyright ©  . All rights reserved.
//

import UIKit

class AnalysisViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!

    let colorTop =  UIColor(red: 51.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 15.0/255.0, green: 12.0/255.0, blue: 12.0/255.0, alpha: 1.0).cgColor
    
    @IBOutlet var backgroundView: UIView!

    
    var data = [""]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        setGradientBackground()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 7, execute: {
            if analysedCollection.count == 0 {
                let backHandler = { (action:UIAlertAction!) -> Void in
                    addedItems.removeAll()
                    self.performSegue(withIdentifier: "unwindCompletely", sender: Any?.self)
                }
                let alert = UIAlertController(title: "Alert", message: "No matching diseases found!", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "Alright!", style: .default, handler: backHandler)
                alert.addAction(confirm)
                self.present(alert, animated: true, completion: nil)
            }
            self.collectionView.reloadData()
        })
        // Do any additional setup after loading the view.
    }
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.2, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 1)
        gradientLayer.frame = self.backgroundView.bounds
        self.backgroundView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return analysedCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width*0.4, height: collectionView.bounds.size.width*0.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 0, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AnalysisCollectionViewCell
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
        
        cell.diseaseLabel.text = analysedCollection[indexPath.row].name
        cell.percentage.text = analysedCollection[indexPath.row].percentage + "%"
        cell.clipsToBounds = true
        if analysedCollection[indexPath.row].name == diseaseTBroadcast
        {
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.orange.cgColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var searchTerm = analysedCollection[indexPath.row].name
        searchTerm = searchTerm.replacingOccurrences(of: " ", with: "%20")
        UIApplication.shared.openURL(NSURL(string:"http://www.google.com/#q=\(searchTerm)%20preventive%20measures")! as URL)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func homeButton(_ sender: Any) {
        addedItems.removeAll()
        self.performSegue(withIdentifier: "unwindCompletely", sender: Any?.self)
    }
    
    @IBAction func reloadButton(_ sender: Any) {
        self.collectionView.reloadData()
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
