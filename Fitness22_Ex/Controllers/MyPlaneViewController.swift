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
    
    private var layout: UICollectionViewFlowLayout!
    private var model: SessionsListModel? = nil
    private lazy var states: [SessionCellState] = {
        var states = [SessionCellState]()
        guard let array = model?.array else { return states }
        for state in array {
            states.append(.notCompleted)
        }
        return states
    }()
    private let cellScale: CGFloat = 0.8
    private let dataManager = DataManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setCollectionViewLayout()
        
        model = dataManager.getModel(resource: Files.sessions.rawValue, type: SessionsListModel.self)
    }
    
    private func setCollectionViewLayout() {
        layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300.0, height: 275.0)
        layout.minimumLineSpacing = 20
        sessionCollectionView.collectionViewLayout = layout
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
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = self.sessionCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left - (layout.minimumLineSpacing * 2), y: scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
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
            cell.setState(states[indexPath.item])
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SessionCell.identifier, for: indexPath) as! SessionCell
        cell.delegate = self
        if let cellModel = model?.array[indexPath.item] {
            cell.configure(with: cellModel, index: indexPath.item + 1)
            cell.setState(states[indexPath.item])
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
                self.states[indexPath.item] = .completed
            }
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
