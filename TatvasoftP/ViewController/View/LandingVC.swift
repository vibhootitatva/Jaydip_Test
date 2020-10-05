//
//  UserDetailVC.swift
//  MoonP
//
//  Created by Jaydip's Mackbook on 16/09/20.
//  Copyright © 2020 Jaydip's Macbook. All rights reserved.
//

import UIKit

class LandingVC: UIViewController {

    //MARK:- Outlet
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    
    //MARK:- Variable
    var objData : DataModel?
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        initWithData()
        setNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    //MARK:- Init Function
    func setLayout(){
    }
    func initWithData(){
        
    }
    func setNavigationBar(){
        self.title = "Landing"
    }
    
    //MARK:- Action
    @IBAction func btnNextTapped(_ sender: UIButton){
        
//        if txtField.text?.trim().isBlank() ?? false {
//            self.showAlertView("Please enter value") { (ok) in
//            }
//        }else{
//            let stroy = UIStoryboard.init(name: "Main", bundle: nil)
//
//            let gridVC = stroy.instantiateViewController(withIdentifier: "GridVC") as! GridVC
//            gridVC.viewModel.intNNumber = Int(txtField.text ?? "0")
//            self.navigationController?.pushViewController(gridVC, animated: true)
//        }
    }
}

//MARK:- UITextView Delegate
extension LandingVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
//        if textField == txtField {
//            let allowedCharacters = CharacterSet(charactersIn:"0123456789 ")
//            let characterSet = CharacterSet(charactersIn: string)
//            return allowedCharacters.isSuperset(of: characterSet)
//        }
        return true
    }
}
