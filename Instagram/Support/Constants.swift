//
//  Constants.swift
//  Instagram
//
//  Created by 櫻井将太郎 on 2020/12/26.
//  Copyright © 2020 shoutarou.sakurai. All rights reserved.
//

import Foundation


struct C {

	// MARK: - Asset name
	static let ASSET_LIKE_EXIST = "like_exist"
	static let ASSET_LIKE_NONE = "like_none"

	// MARK: - VC

	static let ID_LOGIN_VC = "Login"
	static let ID_HOME_VC = "Home"
	static let ID_IMAGE_SELECT_VC = "ImageSelect"
	static let ID_POST_VC = "Post"
	static let ID_SETTING_VC = "Setting"

	// MARK: - Firebase

	static let ImagePath = "images"
	static let PostPath = "posts"
	static let nameDataKey = "name"
	static let captionDataKey = "caption"
	static let dateDataKey = "date"
	static let likesDataKey = "likes"
}
