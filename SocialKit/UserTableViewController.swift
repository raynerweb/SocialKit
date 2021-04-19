//
//  UserTableViewController.swift
//  SocialKit
//
//  Created by rayner on 18/04/21.
//

import UIKit

class UserTableViewController: UITableViewController {

    private let kBaseURL = "https://jsonplaceholder.typicode.com"
    
    private var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View foi carregada")
    }
    
    // Melhor lugar pra fazer requisicao HTTP
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url = URL(string: "\(kBaseURL)/users") {
            let session = URLSession.shared
            let request = URLRequest(url: url)
            
            let task = session.dataTask(with: request) { (data, resp, error) in
                if let response = resp as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 {
                    
                    if let users = try? JSONDecoder().decode([User].self, from: data!) {
                        DispatchQueue.main.async {
                            self.users = users
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        let user = users[index]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! UserTableViewCell
        
        cell.user = user
//        cell.set(name: "\(user.name)", email: "\(user.email)")
        
        
        // Existe essa opção, mas não é recomendado,
        // pois se tiver uma View com a mesma tag, isso nao funciona.
        // if let nomeLabel = cell.viewWithTag(0) as? UILabel {
        //    nomeLabel.text = "Nome \(index)"
        // }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "onUserSegue" {
            
            if let userCell = sender as? UserTableViewCell, let user = userCell.user {
                
                if let destination = segue.destination as? PostTableViewController {
                    destination.title = user.name
                    destination.user = user
                }
                
            }
        }
    }

}

//extension UserTableViewController: UITableViewDataSource {
//
//}
//
//extension UserTableViewController: UITableViewDelegate {
//
//}
