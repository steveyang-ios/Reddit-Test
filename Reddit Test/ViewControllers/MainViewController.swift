//
//  MainViewController.swift
//  Reddit Test
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postArray = [Post]()
    var afterID = ""
    
    var currentPage = 1
    var ENTRIES_PER_PAGE = 25
    var LOAD_MORE_LEAD = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "RedditTableViewCell", bundle: nil) , forCellReuseIdentifier: "postCell")
        

        tableView.rowHeight = UITableView.automaticDimension
    
        loadData()

        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        let api = API()
        api.getPostsAfter(urlKey: .BASEAFTER, afterUser: afterID) { (result) in
            switch (result) {
            case .success(let object):
                guard let postsObject = object as? [String: [Post]], let posts = postsObject.first else {
                    self.alert(title: "Error!", message: "Unable to load posts!")
                    return
                }
                if self.afterID == "" {
                    self.postArray = posts.value
                } else {
                    self.postArray.append(contentsOf: posts.value)
                }
                self.afterID = posts.key
                self.reloadData()
            case .failure(let error):
                print("ERROR: \(error)")
                self.alert(title: "Error!", message: "Unable to load posts!")
                self.reloadData()
            }
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = Bundle.main.loadNibNamed("RedditTableViewCell", owner: self, options: nil)?.first as? RedditTableViewCell {
            let post = postArray[indexPath.row]
            cell.setUpCell(post: post)

            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay: UITableViewCell, forRowAt: IndexPath) {
        let refreshLimit = (currentPage * ENTRIES_PER_PAGE) - LOAD_MORE_LEAD
        if forRowAt.row >= refreshLimit {
            currentPage += 1
            self.loadData()
        }
    }
}
