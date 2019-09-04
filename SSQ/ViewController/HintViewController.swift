//
//  HintViewController.swift
//  Quiz
//
//  Created by 島田　澪 on 2019/06/20.
//  Copyright © 2019 島田　澪. All rights reserved.
//

import UIKit

class HintViewController: UIViewController {

    @IBOutlet weak var HintText : UILabel!
    //QuizViewControllerからの値を格納
    var recieveValue: String = ""
    var hintText : [Int : Any] = [:]
    var inputNo : Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.Hint()
        self.displayHint()
        view.backgroundColor = UIColor.activeColor(string: "FFF2CE", alpha: 1)
    }

    //表示の中身
    private func Hint() {
        self.hintText[1] = ["hint":"もう一度入学するくらいなら\n死んだほうがマシ"]
        self.hintText[2] = ["hint":"吉本入るしか...!"]
        self.hintText[3] = ["hint":"甘じょっぱくて美味しい"]
        self.hintText[4] = ["hint":"じっとしていられないタイプ"]
        self.hintText[5] = ["hint":"FF14がマイブーム"]
        self.hintText[6] = ["hint":"世界一かっこいいハゲ"]
    }

    //表示する型
    private func displayHint() {
        let hintText : [String : Any] = self.hintText[self.inputNo] as! [String : Any]
        self.HintText.text = hintText["hint"] as? String
    }

}
