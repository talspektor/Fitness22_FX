//
//  CheckCollectionViewCell.swift
//  Fitness22_Ex
//
//  Created by Tal talspektor on 07/01/2021.
//

import UIKit

class CheckCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sessionNumberLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    private var state: SessionCellState = .notCompleted {
        didSet {
            switch state {
            case .notCompleted:
                sessionNumberLabel.isHidden = false
                checkImageView.isHidden = true
            case .completed:
                sessionNumberLabel.isHidden = true
                checkImageView.isHidden = false
            }
        }
    }
    static let identifier = "\(CheckCollectionViewCell.self)"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static func getNib() -> UINib {
        return UINib(nibName: "CheckCollectionViewCell", bundle: nil)
    }
    
    public func configure(with sessionNumber: String) {
        sessionNumberLabel.text = sessionNumber
    }
    
    public func setState(_ state: SessionCellState) {
        self.state = state
    }
}
