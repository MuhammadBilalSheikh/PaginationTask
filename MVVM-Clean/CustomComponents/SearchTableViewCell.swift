//
//  SearchTableViewCell.swift
//  MVVM-Clean
//
//  Created by MBS on 19/01/2023.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var TextLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData(avatar_URL: String, Login_Text: String, type_Text: String){
        avatarImage.sd_setImage(with: URL(string: avatar_URL))
        TextLabel.text = Login_Text
        typeLabel.text = type_Text
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
