//
//  ViewController.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    var searchController : UISearchController!

    var articles : [Article]?
    var settings: Setting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        settings = LocalStore.loadSettings()
        fetchHeadlines()

    }
    func addSearchBar(){
        self.searchController = UISearchController(searchResultsController:  nil)
            
               self.searchController.searchResultsUpdater = self
               self.searchController.delegate = self
               self.searchController.searchBar.delegate = self
            
               self.searchController.hidesNavigationBarDuringPresentation = false
               self.searchController.dimsBackgroundDuringPresentation = true
            
               self.navigationItem.titleView = searchController.searchBar
            
               self.definesPresentationContext = true
    }
    func setupUI(){
        self.navigationItem.title = NSLocalizedString("Home", comment: "")
        
        tableView.register(UINib(nibName: "HeadlineTableViewCell", bundle: nil), forCellReuseIdentifier: "HeadlineTableViewCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        addSearchBar()
        
    }
    @IBAction func filterClicked(_ sender: Any) {
        presentSettings()
    }
    private func presentSettings() {
        guard let settingsViewController = createViewControlller(controllerId: "SettingsViewController") as? SettingsViewController else { return }
        if let settings = self.settings {
            settingsViewController.settings = settings
        }
        settingsViewController.delegate = self
        self.present(settingsViewController, animated: true)
    }
    func fetchHeadlines(){
        self.errorView.isHidden = true
        self.tableView.isHidden = true
        self.activityIndicator.startAnimating()
 
        let headlinesRequest = DataSource().fetchHeadlines(country: settings?.country, categories: settings?.categories, pageSize: 20) {[unowned self] (articles) in
            self.activityIndicator.stopAnimating()
            self.errorView.isHidden = true
            self.tableView.isHidden = false
            self.articles = articles
            self.tableView.reloadData {
                self.animateTable()
            }
        } onFailure: { error in
            self.errorLabel.text = NSLocalizedString("error", comment: "")
            self.activityIndicator.stopAnimating()
            self.errorView.isHidden = false
            self.tableView.isHidden = true

        }

    }
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }
}
extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineTableViewCell", for: indexPath) as! HeadlineTableViewCell
        if let articles = self.articles {
            let currentArticle = articles[indexPath.row]
            if let imageSource = currentArticle.urlToImage {
                cell.myImage.kf.setImage(with: URL(string: imageSource), placeholder: UIImage(named: "placeholder"))
            }
            cell.titleLabel.text = currentArticle.title
            cell.shortDescription.text = currentArticle.articleDescription
            cell.sourceLabel.text = currentArticle.source?.name
            cell.publishedDateLabel.text = getPublishedDateWithServiceFormat(date:  currentArticle.publishedAt ?? Date())
        }
        return cell
    }
    private func getPublishedDateWithServiceFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        let dateStr = dateFormatter.string(fromDate: date, withFormate: DateFormatter.Formats.yyyyMMddhhmma, local: Locale(identifier: "en"))
        return dateStr
    }
    
}
extension HomeViewController :  UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        print("hiiii")
    }
}
extension HomeViewController: SettingsViewControllerDelegate {
    func selectionsConfirmed(settings: Setting) {
        self.dismiss(animated: true)
        self.settings = settings
        fetchHeadlines()
    }
}
