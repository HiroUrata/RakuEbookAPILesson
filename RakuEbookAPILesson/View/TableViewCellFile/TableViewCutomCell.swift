//
//  TableViewCutomCell.swift
//  RakuEbookAPILesson
//
//  Created by UrataHiroki on 2021/11/09.
//

import UIKit

class TableViewCutomCell: UITableViewCell {

    
    @IBOutlet weak var mediumImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var itemCaptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mediumImageView.image = UIImage(named: "")
        titleLabel.text = ""
        authorLabel.text = ""
        itemCaptionTextView.text = ""
    }
}
