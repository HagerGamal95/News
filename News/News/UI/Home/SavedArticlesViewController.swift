//
//  SavedArticlesViewController.swift
//  News
//
//  Created by hager gamal on 12/15/20.
//

import UIKit
import SafariServices

class SavedArticlesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = DataSource()
    var articles : [Article]?
    var articlesTableViewAdapter: ArticlesTableViewAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        self.navigationItem.title = NSLocalizedString("Favourite Articles", comment: "")
        if let articles = try? dataSource.loadArticles() {
            articlesTableViewAdapter = ArticlesTableViewAdapter(tableView: tableView, articles: articles, showSaveButton: false, delegate: self)
        }
    }
}

extension SavedArticlesViewController : ArticlesTableViewAdapterDelegate {
    func article(_ article: Article, clickedAtIndex index: Int) {
        if let articleURL = article.url {
            if let url = URL(string: articleURL) {
                let vc = SFSafariViewController(url: url)
                vc.delegate = self
                present(vc, animated: true)
            }
        }
    }
}

extension SavedArticlesViewController : SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
