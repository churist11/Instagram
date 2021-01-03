//
//  ImageSelectViewController.swift
//  Instagram
//
//  Created by 櫻井将太郎 on 2020/12/26.
//  Copyright © 2020 shoutarou.sakurai. All rights reserved.
//

import UIKit
import CLImageEditor

final class ImageSelectViewController: UIViewController, UINavigationControllerDelegate {

	// MARK: - Stored Property

	private var imagePickerController: UIImagePickerController!
	private var clImageEditor: CLImageEditor!

	// MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	// MARK: - IBAction

	@IBAction func handleLibraryButton(_ sender: UIButton) {

		// Check source type availability
		if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {

			// Initialize image picker controller
			self.imagePickerController = UIImagePickerController()

			// Conform to protocol
			self.imagePickerController.delegate = self

			// Designate source type
			self.imagePickerController.sourceType = .photoLibrary

			// Present image library modally
			self.present(self.imagePickerController, animated: true, completion: nil)
		}
	}

	@IBAction func handleCameraButton(_ sender: UIButton) {

		// Check source type availability
		if UIImagePickerController.isSourceTypeAvailable(.camera) {

			// Initialize image picker controller
			self.imagePickerController = UIImagePickerController()

			// Conform to protocol
			self.imagePickerController.delegate = self

			// Designate source type
			self.imagePickerController.sourceType = .camera

			// Present image library modally
			self.present(self.imagePickerController, animated: true, completion: nil)
		}

	}

	@IBAction func handleCancelButton(_ sender: UIButton) {

		// Close the image picker
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

} // MARK: EndLine

// MARK: - UIImagePickerControllerDelegate + CLImageEditorDelegate

extension ImageSelectViewController: UIImagePickerControllerDelegate, CLImageEditorDelegate {

	// MARK: UIImagePickerControllerDelegate

	// Did finish picking image
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

		// Get media info
		guard let image = info[.originalImage] as? UIImage else {
			return
		}

		// Log info
		print("DEBUG_PRINT: \(image)")

		// <Open image editor>

		// 1. Initialize with selected image
		self.clImageEditor = CLImageEditor(image: image)

		// 2. Confirm to protocol
		self.clImageEditor.delegate = self

		// 3. Configure modal style
		self.clImageEditor.modalPresentationStyle = .fullScreen

		// 4. Open editor over the image picker
		picker.present(self.clImageEditor, animated: true, completion: nil)
	}

	// Did handle 'cancel' button in picker
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

		// Close VCs and back to tab menu scene
		self.presentingViewController?.dismiss(animated: true, completion: nil)
	}

	// MARK: CLImageEditorDelegate

	// Did finish edit image
	func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {

		// Log Image object
		print("DEBUG_PRINT: \(image!)")

		// Get ref to PostVC
		guard let postVC = self.storyboard?.instantiateViewController(identifier: C.ID_POST_VC) as? PostViewController else {
			return
		}

		// Configure modal style
		postVC.modalPresentationStyle = .automatic
		postVC.modalTransitionStyle = .crossDissolve

		// Pass edited image to PostVC
		postVC.postingImage = image

		// Present Post scene modally
		editor.present(postVC, animated: true, completion: nil)
	}

	// Did handle "cancel" button in editor
	func imageEditorDidCancel(_ editor: CLImageEditor!) {

		// Close editor
		self.presentingViewController?.dismiss(animated: true, completion: nil)
	}

}
