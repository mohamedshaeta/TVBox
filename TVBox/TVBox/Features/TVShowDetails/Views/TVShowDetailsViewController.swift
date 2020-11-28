//
//  TVShowDetailsViewController.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import UIKit
class TVShowDetailsViewController: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tvShowImageView: UIImageView!
    @IBOutlet weak var tvShowTitleLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var averageVotingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var networksLabel: UILabel!
    @IBOutlet weak var homePageURButton: UIButton!
    @IBOutlet weak var postersCollectionView: UICollectionView!
    @IBOutlet weak var similarTVShowsCollectionView: UICollectionView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var rateButton: UIButton!
    
    //MARK: - Global Properties
    var tvShowDetailsPresenter: TVShowDetailsPresenter?
    var tvShow: TVShow?
    var photosCollectionViewDelegate: PhotosCollectionViewDelegate?
    var similerTVShowsCollectionViewDelegate: SimilerTVShowsCollectionViewDelegate?
    
    //MARK: - ViewController life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPostersCollectionView()
        setupsSimilarTVShowsCollectionView()
        setupPresenter()
        fetchInitialData()
        
    }
    
    // MARK: - Initialization
    class func instantiateTVShowDetailsViewController() -> TVShowDetailsViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: "TVShowDetailsViewController") as! TVShowDetailsViewController
    }
    
    func setupPresenter()  {
        tvShowDetailsPresenter = DependencyRegistry.sharedInstance.getTVShowDetailsPresenter()
        tvShowDetailsPresenter?.attach(to: self)
    }
    
    func fetchInitialData() {
        if let tvShow = tvShow {
            tvShowDetailsPresenter?.fetchInitialData(tvShow: tvShow)
        }
    }
    
    func registerPhotoCollectionViewCells() {
        let photoCell = UINib(nibName: PhotoCollectionViewCell.nibName, bundle: nil)
        self.postersCollectionView.register(photoCell, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier )
    }
    
    func registerSimilarTVShowsCells() {
        let tvshowCell = UINib(nibName: TVShowCollectionViewCell.nibName, bundle: nil)
        self.similarTVShowsCollectionView.register(tvshowCell, forCellWithReuseIdentifier: TVShowCollectionViewCell.identifier )
    }
    
    func setupPostersCollectionView() {
        registerPhotoCollectionViewCells()
        photosCollectionViewDelegate = PhotosCollectionViewDelegate()
        postersCollectionView.dataSource = photosCollectionViewDelegate
    }
    
    func setupsSimilarTVShowsCollectionView() {
        registerSimilarTVShowsCells()
        similerTVShowsCollectionViewDelegate = SimilerTVShowsCollectionViewDelegate()
        similerTVShowsCollectionViewDelegate?.delegate = self
        similarTVShowsCollectionView.delegate = similerTVShowsCollectionViewDelegate
        similarTVShowsCollectionView.dataSource = similerTVShowsCollectionViewDelegate
    }
    
    //MARK: - Helpers
    @IBAction func homeUrlDidPressed(sender: UIButton) {
        if let homeURl = tvShow?.homepage {
            openURL(url: homeURl)
        }
    }
    
    @IBAction func rateDidPressed(sender: UIButton) {
        if let tvShow = self.tvShow {
            tvShowDetailsPresenter?.rateTVShow(tvShow: tvShow, with: ratingView.rating)
        }
    }
    
    func openURL(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    func openTVShowDetails(tvShow: TVShow) {
        let tvShowDetailsView = TVShowDetailsViewController.instantiateTVShowDetailsViewController()
        tvShowDetailsView.tvShow = tvShow
        self.navigationController?.pushViewController(tvShowDetailsView, animated: true)
    }
    
    func populateTVShow(tvShow: TVShow) {
        if let posterPath = tvShow.posterPath {
            tvShowImageView.downloadImage(from: Keys.ImageBaseUrl + posterPath, completion: nil)
        }
        
        if let title = tvShow.name {
            tvShowTitleLabel.text = title
        }
        
        if let voteAverage = tvShow.voteAverage{
            averageVotingLabel.text = String(voteAverage)
        }
        
        if let episodeNumber = tvShow.lastEpisodeToAir?.episodeNumber{
            episodeNumberLabel.text = String(episodeNumber)
        }
        
        if let genres = tvShow.genres{
            genreLabel.text = genres.map({ (genre) -> String in
                genre.name ?? ""
            }).joined(separator: ", ")
        }
        
        if let homePageUrl = tvShow.homepage{
            homePageURButton.setTitle(String(homePageUrl), for: .normal) 
        }
        
        if let networks = tvShow.networks{
            networksLabel.text = networks.map({ (network) -> String in
                network.name ?? ""
            }).joined(separator: ", ")
        }
        
        if let overView = tvShow.overview{
            overviewLabel.text = String(overView)
        }
    }
}
//MARK: - Extensions
//MARK: Presenter
extension TVShowDetailsViewController: TVShowDetailsDelegate {
    func updateTVShowImages(tvShowImages: TVShowImages) {
        self.tvShow?.images = tvShowImages
        self.photosCollectionViewDelegate?.tvShowImages = tvShowImages
        DispatchQueue.main.async {
            self.postersCollectionView.reloadData()
        }
    }
    
    func updateTVShow(tvShow: TVShow) {
        self.tvShow = tvShow
        DispatchQueue.main.async {
            self.populateTVShow(tvShow: tvShow)
        }
    }
    
    func updateSimilarTVShow(tvShows: TVShows) {
        self.similerTVShowsCollectionViewDelegate?.tvShows = tvShows
        DispatchQueue.main.async {
            self.similarTVShowsCollectionView.reloadData()
        }
    }
    
    func didRatedSuccessfuly() {
       animateDisableRateButton()
    }
    
    func animateDisableRateButton() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.rateButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            }, completion: { _ in
                UIView.animate(withDuration: 0.6) { [self] in
                    self.rateButton.setTitle("", for: .normal)
                    self.rateButton.setImage(#imageLiteral(resourceName: "ic_thumb-up.png"), for: .normal)
                    self.rateButton.transform = CGAffineTransform.identity
                    rateButton.isEnabled = false
                    self.ratingView.isUserInteractionEnabled = false
                }
            })
        }
    }
}

extension TVShowDetailsViewController: SimilerTVShowsDelegate {
    func didSelectTVShow(tvShow: TVShow) {
        openTVShowDetails(tvShow: tvShow)
    }
}
