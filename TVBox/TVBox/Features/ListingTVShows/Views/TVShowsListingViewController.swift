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
        tvShowsPresenter?.fetchTVShows()
    }
    
    // MARK: - Initialization
    class func instantiateTVShowsListingViewController() -> TVShowsListingViewController {
        let tvShowsListingViewController = TVShowsListingViewController()
        return tvShowsListingViewController
    }
    
    func setupPresenter()  {
        tvShowsPresenter = DependencyRegistry.sharedInstance.getTVShowsListingPresenter()
        tvShowsPresenter?.attach(to: self)
    }
    
    func setupTVShowsTableViewCell() {
        self.tvShowsTableView.delegate = self
        self.tvShowsTableView.dataSource = self
    }
    
    func registerTVShowsTableViewCell(){
        let tvShowCell = UINib(nibName: TVShowTableViewCell.nibName, bundle: nil)
        self.tvShowsTableView.register(tvShowCell, forCellReuseIdentifier: TVShowTableViewCell.identifier )
    }
}

//MARK: - Extensions
//MARK TableViewDelegate

extension TVShowsListingViewController: UITableViewDelegate {
    
}
//MARK TableViewDelegate
extension TVShowsListingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tvShows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tvShowCell = tableView.dequeueReusableCell(withIdentifier: TVShowTableViewCell.identifier) as! TVShowTableViewCell
        tvShowCell.selectionStyle = .none
        
        let tvShow = tvShows![indexPath.row]
        tvShowCell.populateTVShowCard(tvShow: tvShow)
        return tvShowCell
    }
}

//MARK: - Preseter
extension TVShowsListingViewController: TVShowsListingPresenterDelegate {
    func updateTVShows(tvShows: TVShows) {
        self.tvShows = tvShows
        DispatchQueue.main.async {
            self.tvShowsTableView.reloadData()
        }
    }
}
