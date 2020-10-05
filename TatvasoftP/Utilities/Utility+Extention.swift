//
//  Utility+Extention.swift
//  PracticleVedSoft
//
//  Created by Jaydip's Mackbook on 07/08/20.
//  Copyright © 2020 Jaydip's Mackbook. All rights reserved.
//

import Foundation
import UIKit


let StoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
let SCREEN_SIZE = UIScreen.main.bounds
let APPDEL = UIApplication.shared.delegate as! AppDelegate
let imageCache = NSCache<NSString, UIImage>()



class Utilities {
    
    
    
    class func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}


extension UIImageView {
    
    func loadImageUsingCache(withUrl urlString : String) {
        let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL.init(string: encodedURL)
        let cc = urlString
        if url == nil {return}
        self.image = nil
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }
            
        }).resume()
    }
}

extension UIViewController{
    func showAlertView(_ message: String!,btnTitle: String? = "Ok",isCancelBtb: Bool? = false, completionHandler: @escaping (_ value: Bool) -> Void){
        let alertController = UIAlertController(title: "BacancyP", message: message, preferredStyle: .alert)
        let btnOKAction = UIAlertAction(title: btnTitle, style: .default) { (action) -> Void in
            completionHandler(true)
        }
        if isCancelBtb ?? false{
            let btnCancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) -> Void in
                completionHandler(false)
            }
            alertController.addAction(btnCancelAction)
        }
        alertController.addAction(btnOKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showLoader(){
        let loadingAlertController: UIAlertController = UIAlertController(title: "Loading", message: nil, preferredStyle: .alert)
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        loadingAlertController.view.addSubview(activityIndicator)
        
        let xConstraint: NSLayoutConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: loadingAlertController.view, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint: NSLayoutConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: loadingAlertController.view, attribute: .centerY, multiplier: 1.4, constant: 0)
        
        NSLayoutConstraint.activate([ xConstraint, yConstraint])
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        
        let height: NSLayoutConstraint = NSLayoutConstraint(item: loadingAlertController.view ?? UIView(), attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 80)
        loadingAlertController.view.addConstraint(height);
        
        self.present(loadingAlertController, animated: true, completion: nil)
    }
    func dissmissLoader(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension String{
    func trim() -> String{
        let strTrimmed = (NSString(string:self)).trimmingCharacters(in: CharacterSet.whitespaces)
        return strTrimmed
    }
    func isBlank() -> Bool{
        let strTrimmed = self.trim()//get trimmed string
        if(strTrimmed.count == 0)//check textfield is nil or not ,if nil then return false
        {
            return true
        }
        return false
    }
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        
    }
}

extension UIView{
    func setBorder(clr: UIColor? = UIColor.lightGray, cornerRadius: CGFloat? = 0.0) {
        self.layer.borderColor = clr?.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = cornerRadius ?? 0
    }
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0 , height: 2)
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: bounds.maxY - layer.shadowRadius,
                                                     width: bounds.width,
                                                     height: layer.shadowRadius)).cgPath
    }
    
    func addShadows(){
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset =  CGSize.zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2
        
    }
    
}

extension UIImage{
    func prepareImageForSaving() -> Data? {
        // create Data from UIImage
        guard let imageData = self.jpegData(compressionQuality: 1) else {
            // handle failed conversion
            print("jpg error")
            return nil
        }
        return imageData
    }
}
