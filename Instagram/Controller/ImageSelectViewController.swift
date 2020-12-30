//
//  ImageSelectViewController.swift
//  Instagram
//
//  Created by 櫻井将太郎 on 2020/12/26.
//  Copyright © 2020 shoutarou.sakurai. All rights reserved.
//

import UIKit

final class ImageSelectViewController: UIViewController, UINavigationControllerDelegate {

	// MARK: Stored Property -

	let imagePickerController = UIImagePickerController()

	// MARK: LifeCycle -

    override func viewDidLoad() {
        super.viewDidLoad()

        // Conform to protocol
		self.imagePickerController.delegate = self
    }

	// MARK: IBAction -

	@IBAction func handleLibraryButton(_ sender: UIButton) {

		//
	}

	@IBAction func handleCameraButton(_ sender: UIButton) {
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

} // MARK: endline

extension ImageSelectViewController: UIImagePickerControllerDelegate {

}
