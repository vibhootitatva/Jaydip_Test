//
//  MovieoverviewVC.swift
//  TatvasoftP
//
//  Created by Jaydip's Mackbook on 05/10/20.
//  Copyright © 2020 Jaydip's Macbook. All rights reserved.
//

import UIKit

class MovieoverviewVC: UIViewController {

    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieData: UILabel!
    @IBOutlet weak var lblMovieOverview: UILabel!
    @IBOutlet weak var lblMovieGeneric: UILabel!
    @IBOutlet weak var lblMovieDuration: UILabel!//
    @IBOutlet weak var lblMovieReleaseDate: UILabel!
    @IBOutlet weak var lblMovieProductionCom: UILabel!
    @IBOutlet weak var lblMovieProductionBudget: UILabel!//
    @IBOutlet weak var lblMovieRevenue: UILabel!
    @IBOutlet weak var lblMovieLanguage: UILabel!//
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var imgBackGround: UIImageView!
    
    
    var id = 0
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMoviewData()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- WS Call
    func getMoviewData(){
        viewModel.getMoviewData(objId: id) { (isSuccess, message) in
            if isSuccess {
                DispatchQueue.main.async {
                    self.setData()
                }
            }
        }
    }
    
    func setData(){
        let obj = viewModel.objMoviewData
        lblMovieName.text = obj.title
        lblMovieData.text = obj.tagline
        lblMovieOverview.text = obj.overView
        lblMovieName.text = obj.title
        lblMovieReleaseDate.text = obj.realesedate
        lblMovieRevenue.text = "$\(obj.revenue ?? 0)"
        lblMovieReleaseDate.text = obj.realesedate
        lblMovieProductionBudget.text = "$\(obj.budget ?? 0)"
        
        var arrLg = [String]()
        if obj.spoken_languages?.count ?? 0 > 1 {
            
            for obj in obj.spoken_languages ?? [] {
                arrLg.append(obj.name ?? "")
            }
            lblMovieLanguage.text = arrLg.joined(separator: ", ")
        }else{
            lblMovieLanguage.text = (obj.spoken_languages?.first)?.name ?? ""
        }
        
        var arrGenerc = [String]()
        if obj.generc?.count ?? 0 > 1 {
            
            for obj in obj.generc ?? [] {
                arrGenerc.append(obj.name ?? "")
            }
            lblMovieGeneric.text = arrGenerc.joined(separator: ", ")
        }else{
            lblMovieGeneric.text = (obj.generc?.first)?.name ?? ""
        }
        
        var arrPCompany = [String]()
        if obj.production_companies?.count ?? 0 > 1 {
            
            for obj in obj.production_companies ?? [] {
                arrPCompany.append(obj.name ?? "")
            }
            lblMovieProductionCom.text = arrPCompany.joined(separator: ", ")
        }else{
            lblMovieProductionCom.text = (obj.production_companies?.first)?.name ?? ""
        }
        
//        var arrPCountry = [String]()
//        if obj.production_countries?.count ?? 0 > 1 {
//
//            for obj in obj.production_countries ?? [] {
//                arrLg.append(obj.name ?? "")
//            }
//        }else{
//            lblMovieProductionCom.text = (obj.production_countries?.first)?.name ?? ""
//        }
    }
}
