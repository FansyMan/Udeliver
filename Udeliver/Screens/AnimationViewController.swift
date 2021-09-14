//
//  AnimationViewController.swift
//  Udeliver
//
//  Created by Surgeont on 02.09.2021.
//

import UIKit

class AnimationViewController: UIViewController {

    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImageView.image = UIImage(named: "U")

        self.logoImageView.alpha = 0
        self.logoLabel.alpha = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       animateLogos()
        
    }
    
    
    func animateLogos() {
        UIView.animate(withDuration: 2, delay: 1, options: []) {
            self.logoImageView.alpha = 1
            self.logoLabel.alpha = 1
           
        } completion: { (_) in
            self.animateMoves()
        }
    }
    
    func animateMoves() {
        UIView.animate(withDuration: 0.5, delay: 0.5, options: []) {
            self.logoImageView.frame.origin.y -= 700
            self.logoLabel.frame.origin.y += 700
        } completion: { (_) in
            self.goToLoginViewController()
        }
    }
    
    func goToLoginViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        present(destinationVC, animated: true, completion: nil)
    }
        

}
