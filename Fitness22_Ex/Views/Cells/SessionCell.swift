//
//  SessionCell.swift
//  Fitness22_Ex
//
//  Created by Tal talspektor on 07/01/2021.
//

import UIKit

protocol SessionCellDelegate: class {
    func didTapStartButton(_ cell: SessionCell)
}

enum SessionCellState: String {
    case completed = "Did it... :)"
    case notCompleted = "Start"
}

class SessionCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var intensityImageView: UIImageView!
    @IBOutlet weak var intensityLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var quoteAuthorLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    private var state: SessionCellState = .notCompleted {
        didSet {
            startButton.setTitle(state.rawValue, for: .normal)
        }
    }
    
    static let identifier = "\(SessionCell.self)"
    
    weak var delegate: SessionCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupIU()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        startButton.setTitle(state.rawValue, for: .normal)
    }
    
    private func setupIU() {
        startButton.layer.cornerRadius = startButton.frame.height / 2
        mainView.layer.cornerRadius = 8
        startButton.setTitle(state.rawValue, for: .normal)
    }

    static func getNib() -> UINib {
        return UINib(nibName: "SessionCell", bundle: nil)
    }
    
    public func configure(with model: SessionModel, index: Int) {
        titleLabel.text = "Session \(index)"
        timeLabel.text = "\(model.length ) min"
        intensityLabel.text = model.difficulty
        quoteLabel.text = model.quote
        quoteAuthorLabel.text = model.quoteAuthor
        setImage()
    }
    
    private func setImage() {
        switch intensityLabel.text {
        case "Easy":
            intensityImageView.image = UIImage(named: "intensity_1_dark")
        case "Medium":
            intensityImageView.image = UIImage(named: "intensity_2_dark")
        case "Hard":
            intensityImageView.image = UIImage(named: "intensity_3_dark")
        default:
            break
        }
    }
    
    public func setState(_ state: SessionCellState) {
        self.state = state
    }
    
    @IBAction func tapStatButton(_ sender: Any) {
        delegate?.didTapStartButton(self)
    }
}
