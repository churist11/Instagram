//
//  CommentViewController.swift
//  Instagram
//
//  Created by 櫻井将太郎 on 2021/01/04.
//  Copyright © 2021 shoutarou.sakurai. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class CommentViewController: UIViewController {

	// MARK: - IBOutlet
	@IBOutlet weak var commentTextField: UITextField!

	// MARK: - Stored property
	internal var postID: String!

	// MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	// MARK: - IBAction
	@IBAction func handleSubmitButton(_ sender: UIButton) {

		// Conditional unwrap
		guard let comment = self.commentTextField.text else {
			return
		}

		// If There is empty textfield, do notihng
		guard (comment.isEmpty == false) else {

			print("DEBUG_PRINT: There is empty text field.")
			SVProgressHUD.showError(withStatus: "コメントを入力して下さい")

			// Do nothing, leave method
			return
		}

		// Log comment
		print("DEBUG_PRINT: \(comment)")

		// Start progress animation
		SVProgressHUD.setStatus("送信中...")

		// <Write the comment in document corresponding the cell>

		// 1. Fetch current user's display name
		guard let myName = Auth.auth().currentUser?.displayName else {
			SVProgressHUD.showError(withStatus: "送信に失敗しました")
			print("DEBUG_PRINT: authのユーザ情報にアクセスできません")

			// Leave this method
			return
		}

		// 2. Create update data
			let updateValue = FieldValue.arrayUnion(["\(myName): \(comment)"])

		// 3. Get document that specified by post id
		let postRef = Firestore.firestore().collection(C.PostPath).document(self.postID)

		// 4. Update the post data
		postRef.updateData([C.commentDataKey: updateValue])


		// Stop HUD animation
		SVProgressHUD.showSuccess(withStatus: "送信しました")
		// Close this VC
		self.presentingViewController?.dismiss(animated: true, completion: nil)
	}

	@IBAction func handleCancelButton(_ sender: UIButton) {

		// Close this VC
		self.presentingViewController?.dismiss(animated: true, completion: nil)
	}


} // MARK: EndLine
