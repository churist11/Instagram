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
	}

	@IBAction func handleCancelButton(_ sender: UIButton) {
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
