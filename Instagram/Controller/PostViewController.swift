//
//  PostViewController.swift
//  Instagram
//
//  Created by 櫻井将太郎 on 2020/12/26.
//  Copyright © 2020 shoutarou.sakurai. All rights reserved.
//

import UIKit

final class PostViewController: UIViewController {

	// MARK: - IBOutlet
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var captionTextField: UITextField!

	// MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
