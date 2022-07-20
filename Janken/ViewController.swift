//
//  ViewController.swift
//  Janken
//
//  Created by Reolch on 2022/07/11.
//

import UIKit
import AVFoundation

enum TypesOfAnswers: Int {
    case rock = 0
    case scissors = 1
    case paper = 2
}

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stackButtos: UIStackView!
    
    /// 掛け声のリソース
    var shuffleAudio = Bundle.main.bundleURL.appendingPathComponent("BattleStart.wav")
    /// 音声を再生するプレイヤー
    var audioPlayer = AVAudioPlayer()
    /// コンピュータの提示する手
    var answerNumber = TypesOfAnswers.rock.rawValue
    /// 掛け声を待つ時間
    var delayTime = 1.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: shuffleAudio, fileTypeHint: nil)
        } catch {
            print("error")
        }
        // Do any additional setup after loading the view.
    }
    
    // ユーザーがグーを選択した場合
    @IBAction func jankenRock(_ sender: Any) {
        shuffleJanken(userHand: .rock)
    }
    
    // ユーザーがシーザーを選択した場合
    @IBAction func jankenScissors(_ sender: Any) {
        shuffleJanken(userHand: .scissors)
    }
    
    // ユーザーがペーパーを選択した場合
    @IBAction func jankenPaper(_ sender: Any) {
        shuffleJanken(userHand: .paper)
    }
    
    // 判定結果をラベルに文字を設定する
    func judgeJanken(result: Int) {
        if (result == 0) {
            self.label.text = "DRAW";
        } else if (result == 2) {
            self.label.text = "WIN";
        } else {
            self.label.text = "LOSE";
        }
    }
    
    // ジャンケンをする関数
    func shuffleJanken(userHand: TypesOfAnswers) {
        // 画像と文字を空に設定する
        self.imageView.image = UIImage()
        self.label.text = ""
        self.stackButtos.isHidden = true
        
        //ジャンケンの声かけ
        audioPlayer.currentTime = .zero
        audioPlayer.play()
        
        // コンピュータが提示する手
        answerNumber = Int.random(in:0..<3)
        
        // ユーザーが選択した手とコンピュータが選択した手の対戦結果
        let result = (userHand.rawValue - answerNumber + 3) % 3
        
        //ジャンケンポンの掛け声と同時に手を出す
        if answerNumber == TypesOfAnswers.rock.rawValue {
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                self.imageView.image = UIImage(named:"gu")
                self.judgeJanken(result: result)
            }
        } else if answerNumber == TypesOfAnswers.scissors.rawValue {
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                self.imageView.image = UIImage(named:"choki")
                self.judgeJanken(result: result)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                self.imageView.image = UIImage(named:"pa")
                self.judgeJanken(result: result)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.stackButtos.isHidden = false
        }
    }
}
