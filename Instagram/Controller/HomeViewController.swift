//
//  HomeViewController.swift
//  Instagram
//
//  Created by 櫻井将太郎 on 2020/12/26.
//  Copyright © 2020 shoutarou.sakurai. All rights reserved.
//

import UIKit
import Firebase

final class HomeViewController: UIViewController {

	// MARK: - IBOutlet

	@IBOutlet weak var tableView: UITableView!

	// MARK: - Stored Property

	/// Its elements is used for cell creation
	private var postArray: [PostData] = []

	/// Firebase Listener
	private var listener: ListenerRegistration!

	// MARK: - LifeCycle

	override func viewDidLoad() {
        super.viewDidLoad()
		// For testing
		//		try! Auth.auth().signOut()

		// Conform to porotocol
		self.tableView.dataSource = self
		self.tableView.delegate = self

		// <Register custom cell>

		// Initialize NIB
		let nib = UINib(nibName: C.POST_NIB_NAME, bundle: nil)

		// Register the nib
		self.tableView.register(nib, forCellReuseIdentifier: C.POST_CELL_ID)
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		// Notify invoked this method
		print("DEBUG_PRINT: viewWillAppear")

		// Divide case that user is login or not
		if Auth.auth().currentUser != nil {
			// <<status: Login>>

			// Check already not registered the listener
			if self.listener == nil {

				// Get Ref to documents
				let postsRef = Firestore.firestore().collection(C.PostPath).order(by: C.dateDataKey, descending: true)

				// Register snapshot to listener with query
				self.listener = postsRef.addSnapshotListener { (querySnapshot, error) in

					// Error handling
					guard error == nil else {

						// Log m
						print("DEBUG_PRINT: snapshotの取得が失敗しました。\(error!)")

						// Leave method
						return
					}

					// Retrieve data from snapshot
					guard let dataArray = querySnapshot?.documents else {

						// Log m
						print("DEBUG_PRINT: documentがありません。")

						return
					}

					// Prepare post array with retrieved data
					self.postArray = dataArray.map { (document) -> PostData in

						// Log message
						print("DEBUG_PRINT: document取得 \(document.documentID)")

						// Return post data made with document
						return PostData(document: document)
					}

					// Reflesh table view data
					self.tableView.reloadData()
				}
			}
		} else {
			// <<status: Logout>>

			// Confirm the listener already registered
			if self.listener != nil {

				// Clear the listener
				self.listener.remove()
				self.listener = nil

				// Clear the array
				self.postArray = []

				// Reflesh table view data
				self.tableView.reloadData()
			}
		}
	}

	// MARK: - Objc Custom Method

	// Did touchup inside the cell's like buttton
	@objc func handleLikeButton(_ sender: UIButton, forEvent event: UIEvent) -> Void {

		// Log message
		print("DEBUG_PRINT: likeボタンがタップされました。")

		// Look for index path of table view depends on touch location
		let touch = event.allTouches?.first
		let point = touch!.location(in: self.tableView)
		guard let indexPath: IndexPath = self.tableView.indexPathForRow(at: point) else {
			print("DEBUG_PRINT: Couldn't get indexpath")
			return
		}

		// Take out data in handled cell
		let postData = self.postArray[indexPath.row]

		// Update likes
		if let myid = Auth.auth().currentUser?.uid {

			// Declare update data
			var updateValue: FieldValue
			if postData.isLiked {

				// Already liked, create removing update data
				updateValue = FieldValue.arrayRemove([myid])

			} else {

				// Not liked, create adding update data
				updateValue = FieldValue.arrayUnion([myid])
			}

			// <Write the update data into likes>

			// 1. Get document that specified by post id
			let postRef = Firestore.firestore().collection(C.PostPath).document(postData.id)

			//2. Update the post data
			postRef.updateData([C.likesDataKey: updateValue])
		}
	}

	@objc func handleCommentButton(_ sender: UIButton, forEvent event: UIEvent) -> Void {

		// Log message
		print("DEBUG_PRINT: commentボタンがタップされました。")

		// Look for index path of table view depends on touch location
		let touch = event.allTouches?.first
		let point = touch!.location(in: self.tableView)
		guard let indexPath: IndexPath = self.tableView.indexPathForRow(at: point) else {
			print("DEBUG_PRINT: Couldn't get indexpath")
			return
		}

		// Take out data in handled cell
		let postData = self.postArray[indexPath.row]

		// Get instance of commentVC
		guard let commentVC = self.storyboard?.instantiateViewController(identifier: C.ID_COMMENT_VC) as? CommentViewController else {
			print("DEBUG_PRINT: Coudn't find commentVC on storyboard")
			return
		}

		// Set id in post data
		commentVC.postID = postData.id

		// Show Comment VC
		self.show(commentVC, sender: self)

	}


}// MARK: EndLine

// MARK: - UITableViewDataSource + UITableViewDelegate Mehtod

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

	// MARK: - DataSource

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return self.postArray.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		// Get custom cell
		guard let cell = tableView.dequeueReusableCell(withIdentifier: C.POST_CELL_ID, for: indexPath) as? PostTableViewCell else {
			return UITableViewCell()
		}

		// Invoke setting method
		cell.setPostData(self.postArray[indexPath.row])

		// Set to invoke custom method by handling button in the cell
		cell.likeButton.addTarget(self, action: #selector(self.handleLikeButton(_:forEvent:)), for: .touchUpInside)
		cell.commentButton.addTarget(self, action: #selector(self.handleCommentButton(_:forEvent:)), for: .touchUpInside)

		return cell
	}

}
