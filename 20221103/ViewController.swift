//
//  ViewController.swift
//  20221103
//
//  Created by Tadas Petrikas on 2022-11-03.
//

import UIKit


final class ViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var textField: UITextField!
    
    //MARK: - Properties
    
    private let kSavedColor = "kSavedColor"
    private var isBlueColorBackground = true
    
    //MARK: - Init
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Lifecycles
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
       
        setupNotifications()
        textField.delegate = self
        
        getUserDefaults()
        setBackgroundColor()
    }
    
    //MARK: - Private
    
    /// Notifications
  
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidDismiss), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    /// UserDefaults
    
    private func getUserDefaults() {
        isBlueColorBackground = UserDefaults.standard.bool(forKey: kSavedColor)
    }
    
    private func setUserDefaults() {
        UserDefaults.standard.set(isBlueColorBackground, forKey: kSavedColor)
    }
    
    /// Internal setup
    
    private func setBackgroundColor() {
        view.backgroundColor = isBlueColorBackground ? .blue : .yellow
    }
    
    private func toggleBackgroundColor() {
        isBlueColorBackground.toggle()
        setBackgroundColor()
        setUserDefaults()
    }
    
    @objc private func keyboardDidShow() {
        if textField.isFirstResponder {
            toggleBackgroundColor()
        }
    }
    
    @objc private func keyboardDidDismiss() {
        if textField.isFirstResponder {
            toggleBackgroundColor()
        }
    }
    
    //MARK: - Actions
    
    @IBAction private func buttonPressed(_ sender: Any) {
        toggleBackgroundColor()
    }
}


//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



