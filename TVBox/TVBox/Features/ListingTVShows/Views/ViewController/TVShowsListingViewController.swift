//
//  TVShowsListingViewController.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import UIKit

class TVShowsListingViewController: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tvShowsTableView: UITableView!
    
    //MARK: - Global Properties
    var tvShowsPresenter: TVShowsListingPresenter?
    var tvShows: TVShows?
    
    //MARK: - ViewCOntroller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTVShowsTableViewCell()
        setupTVShowsTableViewCell()
        setupPresenter()
        tvShowsPresenter?.fetchInitialData()
    }
    
    // MARK: - Initialization
    class func instantiateTVShowsListingViewController() -> TVShowsListingViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: "TVShowsListingViewController") as! TVShowsListingViewController
    }
    
    func setupPresenter()  {
        tvShowsPresenter = DependencyRegistry.sharedInstance.getTVShowsListingPresenter()
        tvShowsPresenter?.attach(to: self)
    }
    
    func setupTVShowsTableViewCell() {
        self.tvShowsTableView.delegate = self
        self.tvShowsTableView.dataSource = self
    }
    
    func registerTVShowsTableViewCell() {
        let tvShowCell = UINib(nibName: TVShowTableViewCell.nibName, bundle: nil)
        self.tvShowsTableView.register(tvShowCell, forCellReuseIdentifier: TVShowTableViewCell.identifier )
    }
    
    //MARK: - Helpers
    func openTVShowDetails(tvShow: TVShow) {
        let tvShowDetailsView = TVShowDetailsViewController.instantiateTVShowDetailsViewController()
        tvShowDetailsView.tvShow = tvShow
        self.navigationController?.pushViewController(tvShowDetailsView, animated: true)
    }
}

//MARK: - Extensions
//MARK TableViewDelegate

extension TVShowsListingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tvShow = self.tvShows?[indexPath.row] {
            openTVShowDetails(tvShow: tvShow)
        }
    }
}
//MARK TableViewDelegate
extension TVShowsListingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tvShows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tvShowCell = tableView.dequeueReusableCell(withIdentifier: TVShowTableViewCell.identifier) as! TVShowTableViewCell
        let tvShow = tvShows![indexPath.row]
        tvShowCell.populateTVShowCard(tvShow: tvShow)
        return tvShowCell
    }
}

//MARK: - Preseter
extension TVShowsListingViewController: TVShowsListingDelegate {
    func updateTVShows(tvShows: TVShows) {
        self.tvShows = tvShows
        DispatchQueue.main.async {
            self.tvShowsTableView.reloadData()
        }
    }
}

