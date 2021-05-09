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
        return 1    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charcell", for: indexPath) as! CharacterCell
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.reloadData()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "charcell", for: indexPath) as! CharacterViewCell
        cell.imageView.kf.setImage(with: URL(string: "https://api.genshin.dev/characters/\(characters[indexPath.row])/icon"))
        return cell
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
