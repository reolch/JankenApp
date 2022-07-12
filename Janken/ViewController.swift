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
    @IBOutlet weak var playButton: UIButton!
    
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
    
    @IBAction func shuffleJanken(_ sender: Any) {
        // 抽選中はボタンを非活性に設定する
        playButton.isUserInteractionEnabled = false
        
        // 画像と文字を空に設定する
        self.imageView.image = UIImage()
        self.label.text = ""
        
        //ジャンケンの声かけ
        audioPlayer.play()
        
        answerNumber = Int.random(in:0..<3)
        
        //ジャンケンポンの掛け声と同時に手を出す
        if answerNumber == TypesOfAnswers.rock.rawValue {
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                self.label.text = "グー"
                self.imageView.image = UIImage(named:"gu")
                self.playButton.isUserInteractionEnabled = true
            }
        } else if answerNumber == TypesOfAnswers.scissors.rawValue {
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                self.label.text = "チョキ"
                self.imageView.image = UIImage(named:"choki")
                self.playButton.isUserInteractionEnabled = true
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                self.label.text = "パー"
                self.imageView.image = UIImage(named:"pa")
                self.playButton.isUserInteractionEnabled = true
            }
        }
    }
}
