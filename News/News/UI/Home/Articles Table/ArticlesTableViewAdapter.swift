//
//  ArticlesTableViewAdapter.swift
//  News
//
//  Created by hager gamal on 12/15/20.
//

import Foundation
import UIKit

@objc protocol ArticlesTableViewAdapterDelegate: class {
    func article(_ article: Article, clickedAtIndex index: Int)
    @objc optional func article(_ article: Article, saveButtonClickedAtIndex index: Int)
}

class ArticlesTableViewAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var tableView: UITableView?
    
    var articles : [Article] {
        didSet {
            tableView?.reloadData() {
                self.animateTable()
            }
        }
    }
    
    var showSaveButton: Bool
    weak var delegate: ArticlesTableViewAdapterDelegate?
    
    init(tableView: UITableView, articles : [Article], showSaveButton: Bool = true, delegate: ArticlesTableViewAdapterDelegate? = nil) {
        self.tableView = tableView
        self.articles = articles
        self.showSaveButton = showSaveButton
        self.delegate = delegate
        
        super.init()
        
        tableView.register(UINib(nibName: "HeadlineTableViewCell", bundle: nil), forCellReuseIdentifier: "HeadlineTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    func reload(rows: [Int]) {
        let indexPaths = rows.map { IndexPath(row: $0, section: 0) }
        tableView?.reloadRows(at: indexPaths, with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineTableViewCell", for: indexPath) as! HeadlineTableViewCell
        
        let article = self.articles[indexPath.row]
        
        if let imageSource = article.urlToImage {
            cell.myImage.kf.setImage(with: URL(string: imageSource), placeholder: UIImage(named: "placeholder"))
        }
        
        cell.titleLabel.text = article.title
        cell.shortDescription.text = article.articleDescription
        cell.sourceLabel.text = article.source?.name
        cell.publishedDateLabel.text = DateFormatter().getPublishedDateWithServiceFormat(date:  article.publishedAt ?? Date())
        
        cell.saveButton.isHidden = !showSaveButton
        if showSaveButton {
            cell.saveButton.tag = indexPath.row
            cell.saveButton.tintColor = article.isSaved ? UIColor(named: "accentColor")  : .gray
            cell.saveButton.addTarget(self, action: #selector(saveButtonClicked(_:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        delegate?.article(articles[index], clickedAtIndex: index)
    }
    
    @objc private func saveButtonClicked(_ button: UIButton) {
        let index = button.tag
        delegate?.article?(articles[index], saveButtonClickedAtIndex: index)
    }
    
    func animateTable() {
        guard let tableView = self.tableView else { return }
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
