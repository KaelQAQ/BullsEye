//
//  ViewController.swift
//  BullsEye
//
//  Created by Abstergo on 2018/9/9.
//  Copyright © 2018年 Abstergo. All rights reserved.
//

import UIKit
//渐入渐出特效依赖的框架
import QuartzCore
//播放器背景音乐依赖的框架
//import AVFoundation
//测试推送到GitHub

class ViewController: UIViewController {
    @IBOutlet weak var slider:UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var currentValue: Int = 50
    var targetValue: Int = 0
    var score = 0
    var round = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
//    背景音乐
//        playBgMusic()
        //设置滑动条的外观
        
        let thumbImageNormal = UIImage(named: "进度3")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "进度1")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "进度2")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func showAlert(){
        let difference = abs(targetValue - currentValue) //abs绝对值
        var points = 100 - difference
        //添加评价
        //(后续添加一个提示奖励分数的方法)
        var title: String
        if difference == 0 {
            title = "二货小老弟,你丫真牛逼!误差\(difference)分"
            points += 100
        }else if difference < 5 {
            title = "二货小老弟,就差那么一点儿!误差\(difference)分"
            points += 50
        }else if difference < 10 {
            title = "二货小老弟...怎么回事!误差\(difference)分"
        }else {
            title = "二货小老弟,你丫就一手残党!误差\(difference)分"
        }
        score += points
        let mesage = "\n二货,你的得分是: \(points)"
        let alert = UIAlertController(title:title,
                                      message:mesage,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title:"ok",style: .default,handler: {action in self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(slider: UISlider){
        // print("滑动条的当前数值是： \(slider.value)")
        //lroundf()是一个函数，它可以把一个带小数点的数值四舍五入到最接近的整数，
        currentValue = lroundf(slider.value)
        print(currentValue)
    }
    func startNewRound() {
        round += 1 //回合+1
        targetValue = 1 + Int (arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
//      每次重新开始回合后的都计数，所以targetLabel放到这个方法下。
        updateLabels()
    }
    @IBAction func startOver(){
        startNewGame()
    }
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
      
//        添加一个简单的淡入淡出效果，也就是当“Start Over”的按钮被触碰后，会使用一个过渡效果让这个过程显得不是那么突兀。
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        view.layer.add(transition, forKey: nil)
    }
    //我们把界面数值显示这个逻辑放到一个单独的方法里，这是因为得分和游戏会和等会用到。
    func updateLabels(){
//        使用String是因为数值类型不能直接赋值到字符串类型
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    // 背景音乐
//    func playBgMusic(){
//        let musicPath = Bundle.main.path(forResource: "001", ofType: "mp3")
//        let url = URL.init(fileURLWithPath: musicPath!)
//        do{
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//        }catch _ {
//            audioPlayer = nil
//        }
//        audioPlayer.numberOfLoops = -1
//        audioPlayer.prepareToPlay()
//        audioPlayer.play()
//    }

}

