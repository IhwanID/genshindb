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
    var weapons: [String] = []
    var elements: [String] = []
    let disposeBag = DisposeBag()
    
    enum HomeItem: Int {
        case character = 99
        case weapon = 100
        case element = 101
    }
    
    var items: [HomeItem] = [
        .character,
        .weapon,
        .element
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        subscribeData()
    }
    
    func subscribeData(){
        let reqCharacter = genshinProvider.rx.request(.characters).map([String].self)
        let reqWeapon = genshinProvider.rx.request(.weapons).map([String].self)
        let reqElement = genshinProvider.rx.request(.elements).map([String].self)
        let observable = Observable.zip(reqCharacter.asObservable(), reqWeapon.asObservable(), reqElement.asObservable()) {
            return ($0, $1, $2)
        }
        
        observable.subscribe { (event) in
            switch event {
            case .completed:
                print("parsing done")
                self.tableView.reloadData()
            case .error(let err):
                print(err.localizedDescription)
            case .next(let response):
                self.characters.append(contentsOf: response.0)
                self.weapons.append(contentsOf: response.1)
                self.elements.append(contentsOf: response.2)
                
            }
        }.disposed(by: disposeBag)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        switch item {
        case .character:
            let cell = tableView.dequeueReusableCell(withIdentifier: "charcell", for: indexPath) as! CharacterCell
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.tag = HomeItem.character.rawValue
            cell.collectionView.reloadData()
            return cell
        case .weapon:
            let cell = tableView.dequeueReusableCell(withIdentifier: "charcell", for: indexPath) as! CharacterCell
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.tag = HomeItem.weapon.rawValue
            cell.collectionView.reloadData()
            return cell
        case .element:
            let cell = tableView.dequeueReusableCell(withIdentifier: "charcell", for: indexPath) as! CharacterCell
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.tag = HomeItem.element.rawValue
            cell.collectionView.reloadData()
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let item = HomeItem(rawValue: collectionView.tag) {
            switch item {
            case .character:
                return characters.count
            case .weapon:
                return weapons.count
            case .element:
                return elements.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = HomeItem(rawValue: collectionView.tag) ?? .character
        switch item {
        case .character:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "charcell", for: indexPath) as! CharacterViewCell
            cell.imageView.kf.setImage(with: URL(string: "https://api.genshin.dev/characters/\(characters[indexPath.row])/icon"))
            return cell
        case .weapon:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "charcell", for: indexPath) as! CharacterViewCell
            cell.imageView.kf.setImage(with: URL(string: "https://api.genshin.dev/weapons/\(weapons[indexPath.row])/icon"))
            return cell
        case .element:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "charcell", for: indexPath) as! CharacterViewCell
            cell.imageView.kf.setImage(with: URL(string: "https://api.genshin.dev/elements/\(elements[indexPath.row])/icon"))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailCharacter") as! DetailCharacterTableViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
    }
    
}

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
}

class CharacterViewCell: UICollectionViewCell{
    @IBOutlet weak var imageView: UIImageView!
    
}
