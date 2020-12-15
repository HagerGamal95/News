//
//  ViewController.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit
import Kingfisher
import SafariServices

enum ViewState {
    case loading
    case content
    case error(message: String)
}

class HomeViewController: UIViewController {
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    var searchController : UISearchController!
    var articlesTableViewAdapter: ArticlesTableViewAdapter?
    
    private var state: ViewState = .loading {
        didSet {
            updateViews()
        }
    }
    
    let dataSource = DataSource()
    var articles : [Article]?
    var settings: Setting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        settings = dataSource.loadSettings()
        fetchHeadlines()
    }
    
    private func updateViews() {
        switch state {
        case .loading:
            self.activityIndicator.startAnimating()
            self.errorView.isHidden = true
            self.tableView.isHidden = true
        case .content:
            self.activityIndicator.stopAnimating()
            self.errorView.isHidden = true
            self.tableView.isHidden = false
        case .error(let message):
            errorLabel.text = message
            self.activityIndicator.stopAnimating()
            self.errorView.isHidden = false
            self.tableView.isHidden = true
        }
    }
    
    func addSearchBar() {
        self.searchController = UISearchController(searchResultsController:  nil)
        self.searchController.automaticallyShowsCancelButton = false
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.titleView = searchController.searchBar
        self.definesPresentationContext = true
    }
    
    func setupUI(){
        self.navigationItem.title = NSLocalizedString("Home", comment: "")
        addSearchBar()
    }
    
    @IBAction func refreshClicked(_ sender: Any) {
        fetchHeadlines()
    }
    
    @IBAction func favouriteClicked(_ sender: Any) {
        guard let articles = try? dataSource.loadArticles(), !articles.isEmpty else {
            let alert = UIAlertController(title: "Alert", message: "No saved articles yet.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let favouriteArticlesViewController = createViewControlller(controllerId: "SavedArticlesViewController") as? SavedArticlesViewController else { return }
        navigationController?.pushViewController(favouriteArticlesViewController, animated: true)
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
    
    func fetchHeadlines() {
        state = .loading
        
        dataSource.fetchHeadlines(country: settings?.country, categories: settings?.categories, pageSize: 20) { [unowned self] (articles) in
            self.articles = articles
            
            if articles.isEmpty {
                state = .error(message: "No Articles Found")
            } else {
                state = .content
                articlesTableViewAdapter = ArticlesTableViewAdapter(tableView: tableView, articles: articles, showSaveButton: true, delegate: self)
            }
        } onFailure: { [unowned self] error in
            state = .error(message: error.localizedDescription)
        }
    }
    
    func fetchSearchResult(query : String) {
        state = .loading
        
        guard let language = settings?.language?.rawValue else { return }
        
        dataSource.fetchSearchResult(query: query, language: language, pageSize: 20) { [unowned self] articles in
            self.articles = articles
            
            if articles.isEmpty {
                state = .error(message: "No Articles Found")
            } else {
                state = .content
                articlesTableViewAdapter = ArticlesTableViewAdapter(tableView: tableView, articles: articles, showSaveButton: true, delegate: self)
            }
        } onFailure: { [unowned self] error in
            state = .error(message: error.localizedDescription)
        }
    }
}

extension HomeViewController : ArticlesTableViewAdapterDelegate {
    func article(_ article: Article, clickedAtIndex index: Int) {
        if let articleURL = article.url {
            if let url = URL(string: articleURL) {
                let vc = SFSafariViewController(url: url)
                vc.delegate = self
                present(vc, animated: true)
            }
        }
    }
    
    func article(_ article: Article, saveButtonClickedAtIndex index: Int) {
        try? dataSource.save(article: article)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let result = searchController.searchBar.text?.trimmingCharacters(in: .whitespaces), !result.isEmpty {
            fetchSearchResult(query: result)
        }
    }
}

extension HomeViewController : SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}

extension HomeViewController: SettingsViewControllerDelegate {
    func selectionsConfirmed(settings: Setting) {
        self.dismiss(animated: true)
        self.settings = settings
        fetchHeadlines()
    }
}
