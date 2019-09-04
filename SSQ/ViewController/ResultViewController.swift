//
//  ResultViewController.swift
//  クイズ
//
//  Created by 島田　澪 on 2019/06/03.
//  Copyright © 2019 島田　澪. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var returnButton: UIButton!
    
    var scoreText: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("結果発表！！！")
        setUserData()
        setupUI()
        self.scoreLabel.text = scoreText
        view.backgroundColor = UIColor.activeColor(string: "FFF2CE", alpha: 1)
    }

    func setUserData() {
        let ud = UserDefaults.standard
        let username: String = ud.object(forKey: "user_name") as! String
        self.nameLabel.text = username + "さんの得点は…"
    }

    // uiデザイン
    func setupUI() {
        view.backgroundColor = UIColor.activeColor(string: "FFF2CE", alpha: 1)
        returnButton.layer.cornerRadius = 10.0
    }
}
