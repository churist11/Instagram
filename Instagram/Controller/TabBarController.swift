//
//  TabBarController.swift
//  Instagram
//
//  Created by 櫻井将太郎 on 2020/12/26.
//  Copyright © 2020 shoutarou.sakurai. All rights reserved.
//

import UIKit
import Firebase


final class TabBarController: UITabBarController {


	// MARK: - LifeCycle


    override func viewDidLoad() {
        super.viewDidLoad()

		// Conform to protocol
		self.delegate = self

		// Set up tab menu appearance
		self.tabBar.tintColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)

		self.tabBar.barTintColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)

    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		// Check user have already login
		if Auth.auth().currentUser == nil {

			// Get reference to login scene from storyboard
			if let loginVC = self.storyboard?.instantiateViewController(identifier: C.ID_LOGIN_VC) as? LoginViewController {

				// Not logged in, present Login VC modally
				self.present(loginVC, animated: true, completion: nil)
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

} // MARK: EndLine


// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {

	// Ask delegate to activate switching on tab menu
	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

		// Confirm user selected item for imageSelect VC
		if viewController is ImageSelectViewController {

			// Get reference to imageSelect VC from storyboard
			if let imageSelectVC = self.storyboard?.instantiateViewController(identifier: C.ID_IMAGE_SELECT_VC) as? ImageSelectViewController {

				// Present modally
				self.present(imageSelectVC, animated: true, completion: nil)
			}

			// De-activate switching on tabbar
			return false

			// Selected Other button
		} else {

			// Activate swiching on tabbar
			return true
		}
	}

}
