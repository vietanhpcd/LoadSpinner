//
//  ViewController.swift
//  LoadSpinner
//
//  Created by vietanh on 1/19/18.
//  Copyright © 2018 vietanh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var spinnerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var loadingView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var arrayUrl = ["https://www.wallpaperup.com/uploads/wallpapers/2014/11/17/519385/82b58deee6b45bfbcf86c42837e8e812.jpg", "https://www.wallpaperup.com/uploads/wallpapers/2013/06/17/103939/aacab500845f96df64496793afdb2f89.jpg", "https://www.wallpaperup.com/uploads/wallpapers/2013/07/26/124333/20d7fd8458bfdb91d5de9d55bebab128.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        spinnerView.isHidden = true
    }

    @IBAction func buttonIMGOne(_ sender: UIButton) {
        spinnerView.isHidden = true
        spinner.stopAnimating()
        showActivityIndicatory(uiView: view)
        let url = URL(string: arrayUrl[0])
        DispatchQueue.global(qos: .userInitiated).async {
            if let imageData = NSData(contentsOf: url!) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData as Data)
                    self.activityIndicator.stopAnimating()
                    self.loadingView.removeFromSuperview()
                }
            }
        }
    }
    
    @IBAction func buttonIMGTwo(_ sender: UIButton) {
        activityIndicator.stopAnimating()
        loadingView.removeFromSuperview()
        spinner.stopAnimating()
        spinnerView.isHidden = false
        let url = URL(string: arrayUrl[1])
        DispatchQueue.global(qos: .userInitiated).async {
            if let imageData = NSData(contentsOf: url!) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData as Data)
                    self.spinnerView.isHidden = true
                }
            }
        }
    }

    @IBAction func buttonIMGThree(_ sender: UIButton) {
        spinnerView.isHidden = true
        activityIndicator.stopAnimating()
        loadingView.removeFromSuperview()
        spinner.startAnimating()
        let url = URL(string: arrayUrl[2])
        DispatchQueue.global(qos: .userInitiated).async {
            if let imageData = NSData(contentsOf: url!) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData as Data)
                    self.spinner.stopAnimating()
                }
            }
        }
    }
    

    // Tạo View và load Spinner bằng code
    func showActivityIndicatory(uiView: UIView) {
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(hex: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        // Spinner
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.bounds.width / 2, y: loadingView.bounds.height / 2)
        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
        activityIndicator.startAnimating()
    }
}

// Bổ xung dữ liệu màu cho UIColor
extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

