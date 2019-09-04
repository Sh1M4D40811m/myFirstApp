//
//  ViewController.swift
//  クイズ
//
//  Created by 島田　澪 on 2019/06/03.
//  Copyright © 2019 島田　澪. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        setupUI()
        hideKeyboardWhenTappedAround()
    }

    // ボタン押下処理
    @IBAction func tapStartButton() {
        setUserData()
    }

    // テキスト入力判定
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        textLimit()
        setButton()
    }

    // 完了タップでキーボード閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // 字数制限
    private func textLimit() {
        let maxLength: Int = 8
        guard let text = textField.text else { return }
        textField.text = String(text.prefix(maxLength))
    }

    // ボタン有効判定
    private func setButton() {
        if textField.text == "" {
            self.startButton.backgroundColor = UIColor.activeColor(string: "D4E2CC", alpha: 1)
            startButton.isEnabled = false
        } else {
            self.startButton.backgroundColor = UIColor.activeColor(string: "77A354", alpha: 1)
            startButton.isEnabled = true
        }
    }

    // ユーザー名保存
    private func setUserData() {
        let ud = UserDefaults.standard
        ud.set(textField.text, forKey: "user_name")
        ud.synchronize()
    }
    // uiデザイン
    func setupUI() {
        textField.delegate = self
        view.backgroundColor = UIColor.activeColor(string: "FFF2CE", alpha: 1)
        startButton.layer.cornerRadius = 10.0
    }

    // 入力エラー表示
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "start") {
            if (textField.text?.isEmpty)! {
                let alert = UIAlertController(title: "***Error***", message: "ENTER YOUR NAME", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
                return false;
            }
        }
        return true;
    }
}

// 画面タップでキーボードを閉じる
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

// 色変換
extension UIColor {
    class func activeColor(string: String, alpha: CGFloat) -> UIColor {
        let string_ = string.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: string_ as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            return UIColor.white;
        }
    }
}
