//
//  SettingViewController.swift
//  Instagram
//
//  Created by 櫻井将太郎 on 2020/12/26.
//  Copyright © 2020 shoutarou.sakurai. All rights reserved.
//

import UIKit
import Firebase

final class SettingViewController: UIViewController {


	// MARK: IBOutlet -

	@IBOutlet weak var textField: UITextField!


	// MARK: Lifecycle -

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

	// MARK: IBAction -

	@IBAction func handleChangeNameButton(_ sender: UIButton) {
	}

	@IBAction func handleLogOutButtton(_ sender: UIButton) {
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
