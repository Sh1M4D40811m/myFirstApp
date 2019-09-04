//
//  Quiz01ViewController.swift
//  クイズ
//
//  Created by 島田　澪 on 2019/06/03.
//  Copyright © 2019 島田　澪. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var questionNoLabel : UILabel!
    @IBOutlet weak var questionLabel : UILabel!
    @IBOutlet weak var countLabel :UILabel!
    @IBOutlet weak var Q1button : UIButton!
    @IBOutlet weak var Q2button : UIButton!
    @IBOutlet weak var Q3button : UIButton!
    @IBOutlet weak var Qbutton3: NSLayoutConstraint!
    @IBOutlet weak var Qbutton2: NSLayoutConstraint!
    
    var questions : [Int : Any] = [:]
    var questionNo : Int = 1
    var correct : String?
    var score : Int! = 0
    var timer : Timer!
    var count : Float = 1
    var pauseTime : Float = 0
    var hintNo : Int = 0

    /// ViewControllerがLoadされたとき呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCount()
        self.setQuestions()
        self.displayQuestions()
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //カウントダウン設定
    private func setCount() {
        self.count = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(QuizViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
    }

    /// 出題するクイズを設定(カタの中身)
    private func setQuestions() {
        self.questions[1] = ["Question":"出身大学は？", "Choice1":"1.東京大学" , "Choice2":"2.東京藝術大学", "Correct":"2"]
        self.questions[2] = ["Question":"姉に寝言で言われたのはどっち？", "Choice1":"1.澪はアイドル界に入って\nどうするつもりなの？" , "Choice2":"2.澪はお笑い界に入って\nどうするつもりなの？", "Correct":"2"]
        self.questions[3] = ["Question":"中学生の時に食べていた\n自作おやつはなに？", "Choice1":"1.とろこんチョコ" , "Choice2":"2.わさびチョコ", "Correct":"1"]
        self.questions[4] = ["Question":"幼少期の癖は？","Choice1":"1.逃走癖","Choice2":"2.収集癖","Choice3":"3.夢想癖","Correct":"1"]
        self.questions[5] = ["Question":"趣味は？","Choice1":"1.ゲーム","Choice2":"2.ライブ","Correct":"1"]
        self.questions[6] = ["Question":"好きなアクション俳優は？","Choice1":"1.トム・クルーズ","Choice2":"2.キアヌ・リーブス","Choice3":"3.ジェイソン・ステイサム","Correct":"3"]
    }

    /// 出題するクイズを表示(カタを作る)
    /// - Parameters:
    ///   - questionNo: 表示するクイズNo
    private func displayQuestions() {
        var question:[String:Any] = self.questions[self.questionNo] as! [String : Any] //setQuestionsメソッドの型（[String : Any]・・・なんでも入るやで！）
        self.questionNoLabel.text = "Q"  + "." + String(self.questionNo)
        self.questionLabel.text = question["Question"] as? String
        self.Q1button.setTitle(question["Choice1"] as? String, for: .normal)
        self.Q2button.setTitle(question["Choice2"] as? String, for: .normal)
        self.Q3button.setTitle(question["Choice3"] as? String, for: .normal)
        self.correct = question["Correct"] as? String
        self.questionNo += 1

        self.hintNo += 1 //対応するヒントを出すためのヒント画面に渡す値

        ///選択肢ボタンの表示非表示
        Q3button.isHidden = false//表示初期化
        if question.keys.count == 4 { //question配列の要素数でジャッジ
            Q3button.isHidden = true
            NSLayoutConstraint.deactivate([Qbutton3])
            NSLayoutConstraint.activate([Qbutton2])
        } else {
            NSLayoutConstraint.deactivate([Qbutton2])
            NSLayoutConstraint.activate([Qbutton3])
        }
    }

    /// 答え判定
    /// - Parameters:
    ///   - answer: 押したボタン番号
    /// - Returns: 押されたボタンが正解かどうか(true:正解、false：不正解)
    private func judgmentAnswer(_ answer: String) {
        if self.correct == answer {
            score += 1 // スコアに+1する
        }
    }

    /// ボタンが押されたときの処理
    /// - Parameters:
    ///   - sender: 押されたボタン
    @IBAction func tapButton(sender: UIButton) {
        if sender == self.Q1button {
            self.judgmentAnswer("1")
        } else if sender == self.Q2button {
            self.judgmentAnswer("2")
        }else if sender == self.Q3button {
            self.judgmentAnswer("3")
        }
        timer.invalidate()
        // すべてのクイズ出題した？
        if questionNo > questions.count {
            // 出題し終わった場合
            let storyboard: UIStoryboard = self.storyboard!
            let vc = storyboard.instantiateViewController(withIdentifier: "result") as! ResultViewController
            vc.scoreText = String(self.score)
            vc.modalTransitionStyle = .flipHorizontal
            self.present(vc, animated: true, completion: nil)
        } else {
            // 次の問題がある場合
            self.setCount()
            self.displayQuestions()
        }
    }

    ///カウントダウン処理表示
    @objc private func onUpdate(timer : Timer){
        // 桁数を指定して文字列を作る
        let str = String(format: "%.0f", count)
        // ラベルに表示
        countLabel.text = str
        // カウントの値
        count -= 1
        //TimeUpでアラート表示
        if count == -1{   //表示ラグのため-1=0になる
            //タイマー破棄
            timer.invalidate()
            let alert: UIAlertController = UIAlertController(title: "TimeUp!", message: "NEXT→", preferredStyle:  UIAlertController.Style.alert)
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                // ボタンが押された時の処理
                (action: UIAlertAction!) -> Void in
                if self.questionNo > self.questions.count {
                    // 出題し終わった場合
                    let storyboard: UIStoryboard = self.storyboard!
                    let vc = storyboard.instantiateViewController(withIdentifier: "result") as! ResultViewController
                    vc.scoreText = String(self.score)
                    vc.modalTransitionStyle = .flipHorizontal
                    self.present(vc, animated: true, completion: nil)
                } else {
                    // 次の問題がある場合
                    self.setCount()
                    self.displayQuestions()
                }
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }

    //ヒント表示（モーダル準備）
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //遷移先のViewControllerを取得
        let hintVC = segue.destination as! HintViewController
        hintVC.recieveValue = "submit value"
        //hintNo取得
        hintVC.inputNo = hintNo
        //カウント一時停止
        timer.invalidate()
    }

    //ヒント閉じる
    @IBAction func close(_ segue: UIStoryboardSegue ){
        //カウント再開
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(QuizViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
    }

    // Setup
    func setupUI() {
        self.questionLabel.adjustsFontSizeToFitWidth = true
        self.questionLabel.minimumScaleFactor = 0.6
        Q1button.layer.cornerRadius = 10.0
        Q2button.layer.cornerRadius = 10.0
        Q3button.layer.cornerRadius = 10.0
        view.backgroundColor = UIColor.activeColor(string: "FFF2CE", alpha: 1)
    }

}
