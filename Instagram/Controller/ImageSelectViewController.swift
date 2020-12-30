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

	private var imagePickerController = UIImagePickerController()

	// MARK: LifeCycle -

    override func viewDidLoad() {
        super.viewDidLoad()

        // Conform to protocol
		self.imagePickerController.delegate = self
    }

	// MARK: IBAction -

	@IBAction func handleLibraryButton(_ sender: UIButton) {

		// Check source type availability
		if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {

			// Designate source type
			self.imagePickerController.sourceType = .photoLibrary

			// Present image library modally
			self.present(self.imagePickerController, animated: true, completion: nil)
		}
	}

	@IBAction func handleCameraButton(_ sender: UIButton) {

		// Check source type availability
		if UIImagePickerController.isSourceTypeAvailable(.camera) {

			// Designate source type
			self.imagePickerController.sourceType = .camera

			// Present image library modally
			self.present(self.imagePickerController, animated: true, completion: nil)
		}

	}

	@IBAction func handleCancelButton(_ sender: UIButton) {

		// Close scene
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

} // MARK: endline

// MARK: UIImagePickerControllerDelegate -

extension ImageSelectViewController: UIImagePickerControllerDelegate {

	// Did finish picking image
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

		// Get media info
		guard let image = info[.originalImage] as? UIImage else {
			return
		}

		// Log info
		print("DEBUG_PRINT: \(image)")

		// TODO: Navigate to edit screen

	}

	// Did handle 'cancel' button in picker
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

		// Close VCs and back to tab menu scene
		self.presentingViewController?.dismiss(animated: true, completion: nil)
	}

}
