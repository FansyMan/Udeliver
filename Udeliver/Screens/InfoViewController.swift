//
//  InfoViewController.swift
//  Udeliver
//
//  Created by Surgeont on 02.09.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var nameOfStep: UILabel!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var countOfStep: UILabel!
    var infoCounter: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImageView.image = UIImage(named: "U")
        
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameOfStep.text = "Добро пожаловать!"
        infoTextView.text = "Нужно что-то передать или отвезти? Возможно кто-то едет по нужному Вам адресу и готов помочь. Просто создайте заявку и кто-нибудь Вам обязательно поможет"
        countOfStep.text = "\(infoCounter) / 4"
    }
    
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        
//
            
            infoCounter = infoCounter + 1
        
        switch infoCounter {
        case 2:
            nameOfStep.text = "Заказы"
            infoTextView.text = "Люди создают заявки на доставку и они появляются во вкладке Заказы. База обновляется автоматически. Нажимайте на ячейку с заказом для подробной информации. Нашли подходящую доставку? Выбирайте её и, выполнив, получите деньги"
            countOfStep.text = "\(infoCounter) / 4"
        
        case 3:
            nameOfStep.text = "Погода"
            infoTextView.text = "Взяли доставку и не знаете какая погода на улице? Во вкладке Погода можно посмотреть актуальную информацию, и не только в Петербурге"
            countOfStep.text = "\(infoCounter) / 4"
        case 4:
            nameOfStep.text = "Профиль"
            infoTextView.text = "Во вкладке Профиль показаны все ваши текущие доставки, за которые вы взялись. При завершении не забудьте отметить заказ как выполненный"
            countOfStep.text = "\(infoCounter) / 4"
            actionButton.setTitle("Войти / Зарегистрироваться", for: .normal)
        case 5:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            present(destinationVC, animated: true, completion: nil)
        default:
            break
        }
        
    }
        
        
    }
    
    
    
        
    




