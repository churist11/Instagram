//
//  LoginViewController.swift
//  Instagram
//
//  Created by 櫻井将太郎 on 2020/12/26.
//  Copyright © 2020 shoutarou.sakurai. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

final class LoginViewController: UIViewController {


	// MARK: - IBOutlet


	@IBOutlet weak var mailAddressTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var displayNameTextField: UITextField!
	@IBOutlet weak var alertLabel: UILabel!


	// MARK: - LifeCycle


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


	// MARK: - IBAction


	@IBAction func handleLoginButton(_ sender: UIButton) {

		// Optional binding
		if let email = self.mailAddressTextField.text,
			let pass = self.passwordTextField.text {

			// Confirm field has any text
			guard (email.isEmpty == false) && (pass.isEmpty == false) else {
				print("DEBUG_PRINT: There is empty text field.")
				SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")

				// Do nothing , throughout method
				return
			}

			// Start progress animation
			SVProgressHUD.show(withStatus: "ユーザデータを照合中...")

			// Perform sign in
			Auth.auth().signIn(withEmail: email, password: pass) { (authResult, error) in

				// Error handling
				guard error == nil else {
					// <<Signin Failed>>
					// 1. Log error
					print("DEBUG_PRINT:  \(error!)")

					// Show error message to the progressHUD
					SVProgressHUD.showError(withStatus: "ログインに失敗しました")

					// 2. Display alert for user
					self.alertLabel.isHidden = false
					self.alertLabel.text = "ログインエラー: \(error!.localizedDescription)"

					// 3. Through out method
					return
				}

				// <<Signin Successed>>
				// 1. Log message
				print("DEBUG_PRINT:" + "Success login")

				// 2. Re-hide alert label
				self.alertLabel.isHidden = true

				// Stop the progress animation
				SVProgressHUD.showSuccess(withStatus: "ログインに成功しました")

				// 3. Close current scene
				self.dismiss(animated: true, completion: nil)
			}
		}
	}

	@IBAction func handleCreateAccountButton(_ sender: UIButton) {

		// Optional binding
		if let email = self.mailAddressTextField.text,
			let pass = self.passwordTextField.text,
			let name = self.displayNameTextField.text {

			// If There is empty textfield, do notihng
			guard (email.isEmpty == false) && (pass.isEmpty == false) && (name.isEmpty == false) else {
				print("DEBUG_PRINT: There is empty text field.")
				SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")

				// Do nothing, throughout method
				return
			}

			// Start progress animation
			SVProgressHUD.show(withStatus: "アカウント作成中...")

			// Confirm All text field is inputed, then create new account
			Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in

				// <<Fail creation>>
				// 1. Catch error
				guard error == nil else {

					// Show error message to the progressHUD
					SVProgressHUD.showError(withStatus: "作成に失敗しました")

					// 2. display alert for user
					self.alertLabel.isHidden = false
					self.alertLabel.text = "作成エラー: \(error!.localizedDescription)"

					print("DEBUG_PRINT: \(error!)")

					// 3. Do nothing
					return
				}


				// <<Success creation>>
				print("DEBUG_PRINT: into creation process")

				// 1. Re-hide alert label
				self.alertLabel.isHidden = true

				// 2. Setting display name
				// Unwrap user
				if let user = Auth.auth().currentUser {

					// Get reference to change request
					let changeRequest = user.createProfileChangeRequest()

					// Set display name
					changeRequest.displayName = name

					// Save profile update
					changeRequest.commitChanges { (error) in

						// Catch error and print description
						guard error == nil else {
							print("DEBUG_PRINT: \(error!)")
							return
						}

						// Log success
						print("DEBUG_PRINT: Set display name: \(user.displayName!)")

						// Stop the progress animation
						SVProgressHUD.showSuccess(withStatus: "ようこそ！")

						// Close current scene to TabBar scene
						self.dismiss(animated: true, completion: nil)
					}
				}
			}
		}
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
