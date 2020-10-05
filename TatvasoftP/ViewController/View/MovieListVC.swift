//
//  UserDetailVC.swift
//  MoonP
//
//  Created by Jaydip's Mackbook on 16/09/20.
//  Copyright © 2020 Jaydip's Macbook. All rights reserved.
//

import UIKit

class MovieListVC: UIViewController {

    //MARK:- Outlet
    
    @IBOutlet weak var tblView: UITableView!
    
    
    //MARK:- Variable
    var objData : DataModel?
    let viewModel = ViewModel()
    
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
        getMoviewList()
    }
    func setNavigationBar(){
        self.title = "Landing"
    }
    
    //MARK:- Action
    @IBAction func btnNextTapped(_ sender: UIButton){

    }
    //MARK: WS Call
    func getMoviewList(){
        viewModel.getMoviewList { (isSuccess, message) in
            if isSuccess {
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
            }
        }
    }
}

//MARK:- UITableView Delegate
extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrMoviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTCell") as! MovieListTCell
        let obj = viewModel.arrMoviewList[indexPath.row]
        cell.lblMovieName.text = obj.strTitle
        cell.lblMovieDate.text = obj.strDate
        cell.lblMovieDescription.text = obj.strOverview
        
        let strUrl = viewModel.strImageBaseUrl + (obj.strImage ?? "")
        
        cell.imageView?.loadImageUsingCache(withUrl: strUrl)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = viewModel.arrMoviewList[indexPath.row]
        let sBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "MovieoverviewVC") as! MovieoverviewVC
        
        vc.id = obj.id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }

}


//MARK:- UITablviewCell Class

class MovieListTCell: UITableViewCell {
    
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieDescription: UILabel!
    @IBOutlet weak var lblMovieDate: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    
    override func awakeFromNib() {
        lblMovieDescription.text = "Discover movies by different types of data like average rating, number of votes, genres and certifications. You can get a valid list of certifications from the  method."
    }
}
