//
//  PostViewController.swift
//  Instagram
//
//  Created by 櫻井将太郎 on 2020/12/26.
//  Copyright © 2020 shoutarou.sakurai. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

final class PostViewController: UIViewController {

	// MARK: - Stored Property

	internal var postingImage: UIImage!

	// MARK: - IBOutlet

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var captionTextField: UITextField!

	// MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

		// Set edited image to image view
		self.imageView.image = self.postingImage
    }

	// MARK: - IBAction

	@IBAction func handlePostButton(_ sender: UIButton) {

		// Convert the image into filetype .jpg
		guard let jpgData = self.postingImage.jpegData(compressionQuality: 0.75) else {
			return
		}

		// Declare posting ref and image ref at Firebase
		let postRef = Firestore.firestore().collection(C.PostPath).document()
		let imageRef = Storage.storage().reference().child(C.ImagePath).child(postRef.documentID + ".jpg")

		// Start progress animation
		SVProgressHUD.setStatus("投稿中...")

		// <<Upload image to Storage>>

		// 1. Create metadata, then set type of data
		let metaData = StorageMetadata()
		metaData.contentType = "image/jpeg"

		// 2. Put data on the ref
		imageRef.putData(jpgData, metadata: metaData) { (metadata, error) in

			// <Fail uploading>

			guard error == nil else {

				// 1. Log the error
				print("DEBUG_PRINT: \(error!)")

				// 2. Show error on progress HUD
				SVProgressHUD.showError(withStatus: "画像のアップロードに失敗しました")

				// 3. Cancel postiong process, back to first screen
				UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)

				// 4. Leave this method
				return
			}

			// <Success uploading>

			// 1.Get user's dislay name
			guard let name = Auth.auth().currentUser?.displayName else {
				print("DEBUG_PRINT: This user has no display name")
				return
			}

			// 2. Declare dictionary describes posting components
			let postDic: [String : Any] = [
				C.nameDataKey: name,
				C.captionDataKey: self.captionTextField.text!,
				C.dateDataKey: FieldValue.serverTimestamp()
			]

			// 3. Store posting to Firestore
			postRef.setData(postDic)

			// 4. Show completion on progress HUD
			SVProgressHUD.showSuccess(withStatus: "投稿しました")

			// 5. Finish postiong process, back to first screen
			UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
		}
	}

	@IBAction func handleCancelButton(_ sender: UIButton) {

		// Close this VC then back to edit screen
		self.dismiss(animated: true, completion: nil)
	}
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}// MARK: EndLine
