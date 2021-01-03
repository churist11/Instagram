//
//  HomeViewController.swift
//  Instagram
//
//  Created by 櫻井将太郎 on 2020/12/26.
//  Copyright © 2020 shoutarou.sakurai. All rights reserved.
//

import UIKit
import Firebase

final class HomeViewController: UIViewController {

	// MARK: - IBOutlet

	@IBOutlet weak var tableView: UITableView!

	// MARK: - Stored Property

	private var postArray: [PostData] = []

	// MARK: - LifeCycle

	override func viewDidLoad() {
        super.viewDidLoad()
		// FIXME: For testing
		//		try! Auth.auth().signOut()

		// Conform to porotocol
		self.tableView.dataSource = self
		self.tableView.delegate = self

		// <Register custom cell>

		// Initialize NIB
		let nib = UINib(nibName: C.POST_NIB_NAME, bundle: nil)

		// Register the nib
		self.tableView.register(nib, forCellReuseIdentifier: C.POST_CELL_ID)
    }

	// MARK: -

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}// MARK: EndLine

// MARK: - UITableViewDataSource + UITableViewDelegate Mehtod

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

	// MARK: - DataSource

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return self.postArray.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		// Get custom cell
		guard let cell = tableView.dequeueReusableCell(withIdentifier: C.POST_CELL_ID, for: indexPath) as? PostTableViewCell else {
			return UITableViewCell()
		}

		// Invoke setting method
		cell.setPostData(self.postArray[indexPath.row])

		return cell
	}

}
