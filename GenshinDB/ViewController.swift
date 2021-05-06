//
//  ViewController.swift
//  GenshinDB
//
//  Created by Ihwan on 04/05/21.
//

import UIKit
import Kingfisher
import RxSwift

class ViewController: UITableViewController {
    
    var characters: [String] = []
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 132
        tableView.tableFooterView = UIView()
        
        subscribeData()
    }
    
    func subscribeData(){
        genshinProvider.rx.request(.characters).map([String].self).subscribe { (event) in
            switch event{
            case .success(let response):
                self.characters.append(contentsOf: response)
                
                self.tableView.reloadData()
                
            case .error(let error):
                print(error)
            }
        }.disposed(by: disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charcell", for: indexPath) as! CharacterCell
        cell.configure(name: characters[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailCharacter") as! DetailCharacterTableViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    func configure(name: String){
        characterName.text = name
        icon.kf.setImage(with: URL(string: "https://api.genshin.dev/characters/\(name)/icon"))
    }
}
