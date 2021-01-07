//
//  MyPlaneViewController.swift
//  Fitness22_Ex
//
//  Created by Tal talspektor on 07/01/2021.
//

import UIKit

class MyPlaneViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var sessionTitleLabel: UILabel!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var sessioDescriptionLabel: UILabel!
    @IBOutlet weak var sessionCollectionView: UICollectionView!
    @IBOutlet weak var checkCollectionView: UICollectionView!
    
    var model: SessionsListModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setCollectionViewLayout()
        
        setModel()
    }
    
    private func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300.0, height: 275.0)
        layout.minimumLineSpacing = 20
        sessionCollectionView.collectionViewLayout = layout
        
//        let checkLayout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        checkLayout.itemSize = CGSize(width: 50.0, height: 50.0)
//        checkLayout.minimumLineSpacing = 4
//        checkCollectionView.collectionViewLayout = checkLayout
    }
    
    //TODO: move it
    private func fetchData() -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: "sessions",
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
               return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    //TODO: move it
    private func setModel() {
        if let data = fetchData() {
            do {
                print("\(data)")
                let jsonData = try JSONDecoder().decode(SessionsListModel.self, from: data)
                model = jsonData
                print("decode success")
            } catch {
                print("decode error")
            }
        }
    }
    
    private func registerCells() {
        sessionCollectionView.register(SessionCell.getNib(), forCellWithReuseIdentifier: SessionCell.identifier)
        checkCollectionView.register(CheckCollectionViewCell.getNib(), forCellWithReuseIdentifier: CheckCollectionViewCell.identifier)
    }
    
    @IBAction func tapIntoButton(_ sender: Any) {
        let alert = UIAlertController(title: "Info", message: "This is an awsome info message", preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension MyPlaneViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tap on cell: \(indexPath)")
    }
}

extension MyPlaneViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model?.array.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == checkCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CheckCollectionViewCell.identifier, for: indexPath) as! CheckCollectionViewCell
            let chapter = "\(String(indexPath.item + 1))"
            cell.configure(with: chapter)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SessionCell.identifier, for: indexPath) as! SessionCell
        cell.delegate = self
        if let cellModel = model?.array[indexPath.item] {
            cell.configure(with: cellModel, index: indexPath.item + 1)
        }
        return cell
    }
}

extension MyPlaneViewController: SessionCellDelegate {
    func didTapStartButton(_ cell: SessionCell) {
        let alert = UIAlertController(title: "Start Session", message: "This is an awsome info message", preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .default) { (action) in
            cell.setState(.completed)
            if let indexPath = self.sessionCollectionView.indexPath(for: cell),
               let checkCell = self.checkCollectionView.cellForItem(at: indexPath) as? CheckCollectionViewCell {
                checkCell.setState(.completed)
            }
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
