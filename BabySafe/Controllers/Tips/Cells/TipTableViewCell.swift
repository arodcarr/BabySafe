//
//  TipTableViewCell.swift
//  BabySafe
//
//  Created by Anghi Rodriguez on 25/06/22.
//

import UIKit

protocol TipTableViewCellDelegate {
    func likeButtonPressed(indexPath: IndexPath?)
}

class TipTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var likesButton: UIButton!
    
    var delegate: TipTableViewCellDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.layer.borderWidth = 1
        selectionStyle = .none
        likesButton.layer.masksToBounds = true
        likesButton.layer.cornerRadius = 8
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        delegate?.likeButtonPressed(indexPath: self.indexPath)
    }
    
}
