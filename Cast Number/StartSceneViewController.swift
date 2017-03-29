//
//  StartSceneViewController.swift
//  Cast Number
//
//  Created by Султан Магомедкадиев on 23/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit

enum LevelType: String {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
}

class StartSceneViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    var timer: Timer? = nil
    
    var timerCounter: Int = 0
    
    var resultNumberArray: [Int] = []
    
    var levelType: LevelType!
    
    var animationDuration: Double!
    
    var timeInterval: Double!
    
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        label.alpha = 0.0
        stopButton.isEnabled = false
        configureSettingsByLevelType()
    }
    
    func configureSettingsByLevelType() {
        switch LevelType(rawValue: levelType.rawValue)! {
        case .easy:
            animationDuration = 2.0
            timeInterval = 4.0
            
        case .medium:
            animationDuration = 1.0
            timeInterval = 2.0

        case .hard:
            animationDuration = 0.5
            timeInterval = 1.5

        }
    }
    
    func updateLabel() {
        label.text = "\(configureRandomNumber())"
    }
    
    func configureRandomNumber() -> String {
        let randomNumber = RandomHelper.shared.generateNumber(inRange: -20...20)
        resultNumberArray.append(randomNumber)
        if randomNumber > 0 && timerCounter != 0 {
            return "+\(randomNumber)"
        }
        return String(randomNumber)
    }
    
    func startRandomAction() {
        updateLabel()
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.label.transform = CGAffineTransform(scaleX: 3, y: 3)
            self.label.alpha = 1.0
        }) { (finished) in
            UIView.animate(withDuration: self.animationDuration, animations: {
                self.label.transform = CGAffineTransform.identity
                self.label.alpha = 0.0
            })
        }
    }
    
    func stopRandomActionWith(result: Bool = false) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        timer?.invalidate()
        timerCounter = 0

        guard result else {
            return
        }
        showInputResultView()
    }
    
    // MARK: - Actions
    
    @IBAction func startButtonDidClick(_ sender: UIButton) {
        sender.isEnabled = false
        stopButton.isEnabled = true
        startRandomAction()

        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
            guard self.timerCounter < 10 else {
                self.stopRandomActionWith(result: true)
                return
            }
            
            self.timerCounter += 1
            self.startRandomAction()
        }
    }
    
    @IBAction func stopButtonDidClick(_ sender: UIButton) {
        stopRandomActionWith()
    }
    
    @IBAction func closeButonDidClick(_ sender: UIButton) {
        self.stopRandomActionWith()
        dismiss(animated: true, completion: nil)
    }
    // MARK: - Alert Controller
    
    func showInputResultView() {
        let alert = UIAlertController(title: "Finish", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Input your result.."
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            self.showResult(result: Int(textField!.text!)!)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showResult(result: Int) {
        let sum = resultNumberArray.reduce(0, +)
        
        if result == sum {
            resultLabel.isHidden = false
            resultLabel.text = "SUCCESS"
            resultLabel.textColor = UIColor.green
        } else {
            resultLabel.isHidden = false
            resultLabel.text = "FAIL"
            resultLabel.textColor = UIColor.red
        }
    }
}

