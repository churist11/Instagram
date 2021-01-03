//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 櫻井将太郎 on 2021/01/03.
//  Copyright © 2021 shoutarou.sakurai. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

	// MARK: - IBOutlet

	@IBOutlet weak var postImageView: UIImageView!
	@IBOutlet weak var likeButton: UIButton!
	@IBOutlet weak var likeLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var captionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
