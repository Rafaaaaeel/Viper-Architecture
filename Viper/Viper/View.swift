//
//  View.swift
//  Viper
//
//  Created by Rafael Oliveira on 05/07/22.
//

import Foundation
import UIKit

protocol AnyView{
    var presenter: AnyPresenter? { get set }
    
    func updade(with users: [User])
    func update(with error: String)
}


class UserViewController: UIViewController, AnyView, ViewFunctions, UITableViewDataSource, UITableViewDelegate{

    var presenter: AnyPresenter?
    
    var users: [User] = []
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
}

extension UserViewController{
    func updade(with users: [User]) {
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        self.label.text = error
    }
    
}

extension UserViewController{
    func setupHierarchy() {
        view.addSubview(label)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func additional() {
        view.backgroundColor = .systemBlue
    }
    
}

extension UserViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}
