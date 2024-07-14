//
//  ViewController.swift
//  movie_demo
//
//  Created by Jay on 12/07/24.
//

import UIKit
import Alamofire
import CoreData

class ViewController: UIViewController, UISearchBarDelegate {
    
    //MARK: ---------------------------- IBOUTLETS ----------------------------
    
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topmoviewLbl: UILabel!
    
    @IBOutlet weak var movieTable: UITableView!
    
    var modelmovie: [Results] = []
//    var currentPage = 1
//    var totalPages = 1
//    var isLoading = false
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: ---------------------------- VIEWDIDLOAD ----------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.searchBar.delegate = self
        self.movieTable.delegate = self
        self.movieTable.dataSource = self
        
        self.searchBar.isHidden = true
        self.searchBar.isEnabled = false
        
        self.apicall(page: 0)
    }

    //MARK: ---------------------------- IBACTIONS ----------------------------
    
    @IBAction func onclickSearchBtn(_ sender: UIButton) {
        self.topmoviewLbl.isHidden = true
        self.searchBar.isEnabled = true
        self.searchBar.isHidden = false
        self.searchBtn.isHidden = true
        self.searchBtn.isUserInteractionEnabled = false
        self.searchBar.isUserInteractionEnabled = true
    }
    
    //MARK: ---------------------------- FUNCTIONS ----------------------------
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.topmoviewLbl.isHidden = false
        self.searchBar.isHidden = false
        self.searchBtn.isUserInteractionEnabled = true
        self.searchBar.isUserInteractionEnabled = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(self.searchBar.text ?? "")
        self.searchBar.resignFirstResponder()
        self.topmoviewLbl.isHidden = false
        self.searchBar.isHidden = true
        self.searchBtn.isHidden = false
        self.searchBtn.isUserInteractionEnabled = true
        self.searchBar.isUserInteractionEnabled = false
    }
    
    func apicall(page: Int) {
        
//        guard !isLoading else { return }
//        isLoading = true
        
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=eac1991f504e08d0d5804d05c901787e&language=en-US&page=\(page)"
        let uurl = "https://api.themoviedb.org/3/movie/now_playing?api_key=eac1991f504e08d0d5804d05c901787e&language=en-US&page=1"
        AF.request(uurl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { resp in
            switch resp.result {
            case .success(let value):
                do {
                    let jsondata = try JSONDecoder().decode(movieModel.self, from: value!)
                    //print(jsondata)
                    let results = jsondata.results
                    DispatchQueue.main.async {
                        self.modelmovie = results!
                        self.movieTable.reloadData()
                    }
//                    self.isLoading = false
                } catch {
                    print(error.localizedDescription)
//                    self.isLoading = false
                }
            case .failure(let error):
                print(error.localizedDescription)
//                self.isLoading = false
            }
        }
    }
    
    func saveinCoredata(movies: [movieModel]) {
        let context = appdelegate.persistentContainer.viewContext
        
        for movie in movies {
            let movieEntity = NSEntityDescription.insertNewObject(forEntityName: "movieModel", into: context) as! movieModel
        }
//        let movieEntity =
    }
    
}

//MARK: ---------------------------- TABLEVIEW DELEGATES ----------------------------

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelmovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = self.modelmovie[indexPath.row]
//        print(movie)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        cell.contentView.clipsToBounds = true
        cell.contentView.layer.borderWidth = 10
        cell.contentView.layer.cornerRadius = 20
        
        cell.setdata(movieid: movie.id!, movieImg: movie.poster_path!, movietitle: movie.title!, moviedate: movie.release_date!, movierating: movie.vote_average!)
        
//        let padd:CGFloat = 30
//        let frame = cell.frame.inset(by: UIEdgeInsets(top: padd, left: 0, bottom: padd, right: 0))
//        cell.contentView.frame = frame
        
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == self.modelmovie.count - 1 {
//            apicall(page: currentPage + 1)
//        }
//    }
    
    
    
}
