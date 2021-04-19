//
//  PostTableViewController.swift
//  SocialKit
//
//  Created by rayner on 19/04/21.
//

import UIKit

class PostTableViewController: UITableViewController {

    private let kBaseURL = "https://jsonplaceholder.typicode.com"
    
    var user: User?
    
    private var postUsers = [PostUser]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // Melhor lugar pra fazer requisicao HTTP
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let userId = user?.id {
            
            if let url = URL(string: "\(kBaseURL)/users/\(userId)/posts") {
                let session = URLSession.shared
                let request = URLRequest(url: url)
                
                let task = session.dataTask(with: request) { (data, resp, error) in
                    if let response = resp as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 {
                        
                        if let postUsers = try? JSONDecoder().decode([PostUser].self, from: data!) {
                            DispatchQueue.main.async {
                                self.postUsers = postUsers
                            }
                        }
                        
                    }
                }
                task.resume()
                
    //            usersCancellationToken = session.dataTaskPublisher(for: request)
    //                .tryMap(session.map(_:))
    //                .decode(type: [User].self, decoder: JSONDecoder())
    //                .breakpointOnError()
    //                .receive(on: DispatchQueue.main)
    //                .sink(receiveCompletion: sinkError(_:)) { self.users = $0 }

                
            }
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        let post = postUsers[index]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultPostCell", for: indexPath) as! PostTableViewCell
        
        cell.post = post
        return cell
    }

}
