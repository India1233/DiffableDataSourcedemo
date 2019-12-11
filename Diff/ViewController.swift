//
//  ViewController.swift
//  Diff
//
//  Created by Sachin Dumal on 11/12/19.
//  Copyright © 2019 Sachin Dumal. All rights reserved.
//

import UIKit

struct User: Hashable{
    let name: String
}

//struct Manager: Hashable {
//    let name: String
//}

enum Section {
    case One
    case Two
}

let users:[User] = [User(name: "wam"), User(name: "gum"), User(name: "rum"), User(name: "jum")]

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
  private lazy var dataSource = makeDataSource()
    var snapShot = NSDiffableDataSourceSnapshot<Section, User>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableview.dataSource = dataSource
        self.tableview.delegate = self
        self.tableview.backgroundColor = .brown
        reloadData()
    }

    private func makeDataSource() -> UITableViewDiffableDataSource<Section, User> {
        return UITableViewDiffableDataSource(tableView: tableview) { (tableView, indexPath, user) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = user.name
            return cell
        }
    }
    
    private func reloadData() {
        snapShot.appendSections([.One, .Two])
        snapShot.appendItems([User(name: "Ronald")], toSection: .One)
        snapShot.appendItems([User(name: "Duck")], toSection: .One)
        snapShot.appendItems([User(name: "Jems")], toSection: .Two)
        snapShot.appendItems([User(name: "Brim")], toSection: .Two)
        snapShot.appendItems([User(name: "Ronal")], toSection: .One)
        snapShot.appendItems([User(name: "Duc")], toSection: .One)
        snapShot.appendItems([User(name: "Jem")], toSection: .Two)
        snapShot.appendItems([User(name: "Bri")], toSection: .Two)
        snapShot.appendItems([User(name: "Ronl")], toSection: .One)
        snapShot.appendItems([User(name: "Du")], toSection: .One)
        snapShot.appendItems([User(name: "Je")], toSection: .Two)
        snapShot.appendItems([User(name: "Br")], toSection: .Two)
        dataSource.apply(snapShot, animatingDifferences: true)
    }

}

//Mark:- TableViewDelagate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = dataSource.itemIdentifier(for: indexPath) else { return}
        
        var currentSnapShot = dataSource.snapshot()
        currentSnapShot.deleteItems([user])
        dataSource.apply(currentSnapShot)
    }
}
