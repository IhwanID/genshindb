//
//  DetailCharacterTableViewController.swift
//  GenshinDB
//
//  Created by Ihwan on 07/05/21.
//

import UIKit

class DetailCharacterTableViewController: UITableViewController {
    
    enum CharacterItem: Int {
        case profile = 99
        case passiveSkill = 100
        case constellation = 102
    }
    var items: [CharacterItem] = [
        .profile,
        .passiveSkill,
        .constellation
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch item {
        case .profile:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! UITableViewCell
            return cell
            //init
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell", for: indexPath) as! UITableViewCell
            return cell
        }
    }
   
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }

}
