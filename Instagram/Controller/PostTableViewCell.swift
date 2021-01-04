//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 櫻井将太郎 on 2021/01/03.
//  Copyright © 2021 shoutarou.sakurai. All rights reserved.
//

import UIKit
import FirebaseUI

final class PostTableViewCell: UITableViewCell {

	// MARK: - IBOutlet

	@IBOutlet weak var postImageView: UIImageView!
	@IBOutlet weak var likeButton: UIButton!
	@IBOutlet weak var likeLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var captionLabel: UILabel!
	@IBOutlet weak var commentButton: UIButton!
	

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	// MARK: - Custom Method

	internal func setPostData(_ postData: PostData) -> Void {

		// <Display image>

		// 1. Configure loading animation
		self.postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray

		// 2. Get ref to the image at Storage
		let imageRef = Storage.storage().reference().child(C.ImagePath).child(postData.id + ".jpg")

		// 3. Set retrieved image
		self.postImageView.sd_setImage(with: imageRef)

		// <Display likes>

		// 1. Get number of elements in likes array
		let numberOfLikes: Int = postData.likes.count

		// 2. Set number as text
		self.likeLabel.text = String(numberOfLikes)

		// <Display date>

		// 1. Initialize
		self.dateLabel.text = ""

		// 2. Unwrap
		if let date = postData.date {

			// 3. Create data formatter
			let formatter = DateFormatter()
			formatter.dateFormat = "yyyy-MM-dd HH:mm"

			// 4. Format date into string
			let dateString: String = formatter.string(from: date)

			// 5. Set the string
			self.dateLabel.text = dateString
		}

		// <Display caption>

		// Set text
		self.captionLabel.text = "\(postData.name!): \(postData.caption!)"

		// <Display Button image>
		if postData.isLiked {

			// Create image
			let image = UIImage(named: C.ASSET_LIKE_EXIST)

			// Set it to button
			self.likeButton.setImage(image, for: .normal)
		} else {

			// Create image
			let image = UIImage(named: C.ASSET_LIKE_NONE)

			// Set it to button
			self.likeButton.setImage(image, for: .normal)
		}

	}

} // MARK: ENDLINE
