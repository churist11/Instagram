//
//  PostData.swift
//  Instagram
//
//  Created by 櫻井将太郎 on 2021/01/03.
//  Copyright © 2021 shoutarou.sakurai. All rights reserved.
//

import UIKit
import Firebase

class PostData: NSObject {

	// MARK: - Stored Property
	var id: String
	var name: String?
	var caption: String?
	var date: Date?
	var likes: [String] = []
	var isLiked: Bool = false

	// MARK: - Initializer
	init(document: QueryDocumentSnapshot) {

		// Retrieve ID from stored document
		self.id = document.documentID

		// Get ref to posting data
		let postDic = document.data()

		// Retrieve values to assign to properties
		self.name = postDic[C.nameDataKey] as? String
		self.caption = postDic[C.captionDataKey] as? String
		let timestamp = postDic[C.dateDataKey] as? Timestamp
		self.date = timestamp?.dateValue()

		// Check "likes" key has array value or not
		if let likes = postDic[C.likesDataKey] as? [String] {
			self.likes = likes
		}

		// Get user id
		if let myid = Auth.auth().currentUser?.uid {

			// Check likes array contains myid
			if self.likes.firstIndex(of: myid) != nil {

				// Set true
				self.isLiked = true
			}
		}
	}


}// MARK: EndLine
