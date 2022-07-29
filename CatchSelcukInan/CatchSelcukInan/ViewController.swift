//
//  ViewController.swift
//  CatchSelcukInan
//
//  Created by Cüneyt Erçel on 28.07.2022.
//

import UIKit

class ViewController: UIViewController {

    var selcukArray = [UIImageView]() // Bu sağ tarafa yazılan kısımı anlayamadım maalesef ama cokda önemli değil array tanımlıyoruz işte
    var score = 0
    // Timer
    var timer = Timer()
    var counter = 0
    
    var hideTimer = Timer()
    var highScore = 0

    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var selcuk1: UIImageView!
    @IBOutlet weak var selcuk2: UIImageView!
    @IBOutlet weak var selcuk3: UIImageView!
    @IBOutlet weak var selcuk4: UIImageView!
    @IBOutlet weak var selcuk5: UIImageView!
    @IBOutlet weak var selcuk6: UIImageView!
    @IBOutlet weak var selcuk7: UIImageView!
    @IBOutlet weak var selcuk8: UIImageView!
    @IBOutlet weak var selcuk9: UIImageView!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)"
        
        
        //Highscore 2 burayı anlamadım ama 1. kısımda yaptığımız keywordü falan cekiyoruz orda set yapmıştık burda object yapıyoruz.
        var storedHighScore = UserDefaults.standard.object(forKey: "highsscore")
        
      
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore : \(highScore)"
            
            if storedHighScore == nil {
                highScore = 0
                highScoreLabel.text = "Highscore : \(highScore)"
            }
        }
        
        
        // Tap gestrure oluşturdum burada target self, selector kısmı içinde daha öncede olduğu gibi objc func açıyoruz.
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        // burda resimleri recognizerlara bağladık.
        selcuk1.addGestureRecognizer(recognizer1)
        selcuk2.addGestureRecognizer(recognizer2)
        selcuk3.addGestureRecognizer(recognizer3)
        selcuk4.addGestureRecognizer(recognizer4)
        selcuk5.addGestureRecognizer(recognizer5)
        selcuk6.addGestureRecognizer(recognizer6)
        selcuk7.addGestureRecognizer(recognizer7)
        selcuk8.addGestureRecognizer(recognizer8)
        selcuk9.addGestureRecognizer(recognizer9)
        
        // burda da resime basılmayı enable ettik.
        selcuk1.isUserInteractionEnabled = true
        selcuk2.isUserInteractionEnabled = true
        selcuk3.isUserInteractionEnabled = true
        selcuk4.isUserInteractionEnabled = true
        selcuk5.isUserInteractionEnabled = true
        selcuk6.isUserInteractionEnabled = true
        selcuk7.isUserInteractionEnabled = true
        selcuk8.isUserInteractionEnabled = true
        selcuk9.isUserInteractionEnabled = true
        
        
        
        // Selcuk hareket ediyor 1 array oluşturma
        selcukArray = [ selcuk1, selcuk2, selcuk3, selcuk4, selcuk5, selcuk6, selcuk7, selcuk8, selcuk9 ]
        
        
        
        // Timers
        
        counter = 10
        timeLabel.text = " \(counter)"
        
        // bu timerı ayarlama kodları interval 1 saniye etki et demek target gene aynı zaten selectorde gene objc func acıyoruz userinfo yok diyoruz tekrar edermiye evet diyoruz.
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
         hideTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(hideSelcuk), userInfo: nil, repeats: true)
        
        
        // Burada highscore 1
        
        if score > highScore {
            highScore = score
            highScoreLabel.text = " Highscore: \(highScore)"
            UserDefaults.standard.set(highScore, forKey: "highsscore")
        }
        
    
    }
    
    
    @objc func hideSelcuk() {
        
        for selcuk in selcukArray {
            selcuk.isHidden = true
            
        }
        // Selcuk hareket 2, random mevzsunu bu kodlarla hallediyoruz
        // Yukarıda her şeyi gizle yapıp aşağıda ise sadece bi tanesini göster yapıyorum.
      let random = Int(arc4random_uniform(UInt32(selcukArray.count - 1)))
        
        selcukArray[random].isHidden = false
    }
    
    @objc func increaseScore() {
        
        score += 1
        scoreLabel.text = "Score = \(score)"
        
        
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            hideTimer.invalidate()
            timer.invalidate() // etkisiz bırakma kodu
            
            //Alert
            //Action değil kontroller diye yazdık. son style kısmında .alert ekledik- Ok butonda action yaptık styleında sonuna .cancel ekledik handlerda basınca ek bişi istemiyorum diye nil yaptım.-
            
            let alert = UIAlertController(title: "Time's Over!!", message: "Do you want to try again ?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "Okey", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                self.counter = 10
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.hideSelcuk), userInfo: nil, repeats: true)
            
        }
            
            // alerte buton aksiyonlarını ekliyoruz böyle
             alert.addAction(okButton)
             alert.addAction(replayButton)
                            
            // Bu ne boka yarıyor anlamadım ama alerti gösterme kodu bu yani.
            self.present(alert, animated: true , completion: nil)
        
    }
    
    
      
    }
    
    
    

}

