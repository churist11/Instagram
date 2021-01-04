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

	// MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

		// TODO: Write comment in document

		// Stop HUD animation
		SVProgressHUD.showSuccess(withStatus: "送信しました")
		// Close this VC
		self.presentingViewController?.dismiss(animated: true, completion: nil)
	}

	@IBAction func handleCancelButton(_ sender: UIButton) {

		// Close this VC
		self.presentingViewController?.dismiss(animated: true, completion: nil)
	}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
