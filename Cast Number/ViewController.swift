//
//  ViewController.swift
//  Cast Number
//
//  Created by Султан Магомедкадиев on 23/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var easyButton: UIButton!
    
    @IBOutlet weak var mediumButton: UIButton!
    
    @IBOutlet weak var hardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: - Actions
    
    @IBAction func easyButtonDidClick(_ sender: UIButton) {
        performSegue(withIdentifier: "toStartScene", sender: sender)
    }
    
    @IBAction func mediumButtonDidClick(_ sender: UIButton) {
        performSegue(withIdentifier: "toStartScene", sender: sender)
    }
    
    @IBAction func hardButtonDidClick(_ sender: UIButton) {
        performSegue(withIdentifier: "toStartScene", sender: sender)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "toStartScene":
            let button = sender as! UIButton
            switch button.tag {
            case 0:
                // easy
                let easyViewController = segue.destination as? StartSceneViewController
                easyViewController?.levelType = .easy
                
            case 1:
                // medium
                let easyViewController = segue.destination as? StartSceneViewController
                easyViewController?.levelType = .medium
                
            case 2:
                // hard
                let easyViewController = segue.destination as? StartSceneViewController
                easyViewController?.levelType = .hard

            default:
                break
            }
        default:
            break
        }
    }
}

