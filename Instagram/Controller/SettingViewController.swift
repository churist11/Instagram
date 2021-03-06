//
//  SettingViewController.swift
//  Instagram
//
//  Created by 櫻井将太郎 on 2020/12/26.
//  Copyright © 2020 shoutarou.sakurai. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

final class SettingViewController: UIViewController {


	// MARK: - IBOutlet 

	@IBOutlet weak var textField: UITextField!


	// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		// <Reflect displayname in text field>
		// 1-2. Get ref to the user
		guard let user = Auth.auth().currentUser else {
			return
		}

		// 2-2. Set display name into text field
		self.textField.text = user.displayName

	}

	// MARK: - IBAction

	@IBAction func handleChangeNameButton(_ sender: UIButton) {

		// Optional binding
		if let newName = self.textField.text {

			// Confirm the text field has text
			guard newName.isEmpty == false else {

				// Display error HUD
				SVProgressHUD.showError(withStatus: "表示名を入力して下さい")

				// Leave method
				return
			}

			// Start progress animation
			SVProgressHUD.show(withStatus: "変更中...")

			// <<Change name process>>
			if let user = Auth.auth().currentUser {

				// Get reference to change request
				let changeRequest = user.createProfileChangeRequest()

				// Set display name
				changeRequest.displayName = newName

				// Save profile update
				changeRequest.commitChanges { (error) in

					// Catch error and print description
					guard error == nil else {

						// Log the error
						print("DEBUG_PRINT: \(error!)")

						// Show error message on HUD
						SVProgressHUD.showError(withStatus: "表示名の変更に失敗しました")

						// Leave method
						return
					}

					// Log success
					print("DEBUG_PRINT: Set display name: \(user.displayName!)")

					// Stop the progress animation
					SVProgressHUD.showSuccess(withStatus: "変更完了")

					// Close keyboard
					self.textField.endEditing(true)
				}
			}
		}
	}

	@IBAction func handleLogOutButtton(_ sender: UIButton) {

		// Show signout progress
		SVProgressHUD.show()

		// Perform logout
		do {
			try Auth.auth().signOut()
		} catch let e {

			// Log error
			print("DEBUG_PRINT: \(e)")

			// Show error message on HUD
			SVProgressHUD.showError(withStatus: "ログアウト失敗")

			// Leave method
			return
		}

		// Get ref to LoginVC
		guard let loginVC = self.storyboard?.instantiateViewController(identifier: C.ID_LOGIN_VC) as? LoginViewController else {
			return
		}

		// Show message on HUD
		SVProgressHUD.showSuccess(withStatus: "ログアウトしました")

		// Present Login scene modally
		self.present(loginVC, animated: true, completion: nil)

		// Set tab menu to Home scene
		self.tabBarController?.selectedIndex = 0
	}
	

}// MARK: EndLine
