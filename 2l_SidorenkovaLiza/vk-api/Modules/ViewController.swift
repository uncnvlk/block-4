//
//  ViewController.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 13.09.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let dict = ["admin" : "123456", "guest" : "654321", "lisa" : "300360"]
    let dictID = ["admin" : "Admin", "guest" : "Ivan Ivanov", "lisa" : "Lisa Sidorenkova"]
    
    let account = Account.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
        autorizationTitleAnimate()
        autorizationLabelAnimate(labelField: loginLabel, move: -200)
        autorizationLabelAnimate(labelField: passwordLabel, move: 200)
        autorizationTextFieldAnimate(textField: loginTextField)
        autorizationTextFieldAnimate(textField: passwordTextField)
        autorizationButtonAnimate()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObservers()
    }
    
    private func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture))
        self.scrollView.addGestureRecognizer(gesture)
    }
    
    @objc private func handleGesture() {
        self.scrollView.endEditing(true)
    }
    
    
    private func addObservers() {
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(handleKeyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil)
        
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(handleKeyboardWillHide),
                name: UIResponder.keyboardWillHideNotification,
                object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default
            .removeObserver(
                self,
                name: UIResponder.keyboardWillShowNotification,
                object: nil)
        
        NotificationCenter.default
            .removeObserver(
                self,
                name: UIResponder.keyboardWillHideNotification,
                object: nil)
    }
    
    @objc func handleKeyboardWillShow(){
        self.scrollView.contentInset.bottom += 220
    }
    
    @objc func handleKeyboardWillHide(){
        self.scrollView.contentInset.bottom = 0
        
    }
    
    @IBAction func onButtonPressed(_ sender: Any) {
        checkPassword()
    }


    private func checkPassword() {
        if let login = loginTextField.text,
           let password = passwordTextField.text,
           dict[login] != nil, password == dict[login] {
            self.showAdminScene()
        } else {
            self.showAllert()
        }
    }
    
    private func showAdminScene() {
        let viewController = R.Storyboard.debugMenu.instantiateInitialViewController()
        if let viewController = viewController as? DebugViewController {
            self.present(viewController, animated: true)
        }
        
        guard let ID = loginTextField.text else {
            return
        }
        
        let name = dictID[ID]
        
        account.login = ID
        account.name = name!
    }
    
    private func showAllert() {
        let allertController = UIAlertController(
            title: "Ошибка",
            message: "Введены неверные данные!",
            preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: "ОК",
            style: .cancel)
        
        allertController.addAction(action)
        self.present(allertController, animated: true)
    }
    
    private func autorizationTitleAnimate() {
        self.titleView.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height/2)
            
        UIView.animate(withDuration: 1,
                        delay: 0.5,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
                           options: .curveEaseOut,
                           animations: {
                               self.titleView.transform = .identity
                           },
                           completion: nil)
    }
    
    private func autorizationLabelAnimate(labelField : UILabel, move: Float) {
        labelField.transform = CGAffineTransform(translationX: CGFloat(move), y: 0)
            
        UIView.animate(withDuration: 1,
                       delay: 0.5,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
                           options: .curveEaseOut,
                           animations: {
                               labelField.transform = .identity
                           },
                           completion: nil)
    }
    
    private func autorizationTextFieldAnimate(textField: UITextField) {
        textField.alpha = 0.0
        UIView.animate(withDuration: 1, delay: 0.3, options: .curveEaseInOut, animations: {
        textField.alpha = 1.0
        }) { _ in print("Animation Done") }
    }
    
    private func autorizationButtonAnimate() {
        UIView.animate(withDuration: 0.5,
            animations: {
                self.signInButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.signInButton.transform = CGAffineTransform.identity
                }
            })
    }

}
