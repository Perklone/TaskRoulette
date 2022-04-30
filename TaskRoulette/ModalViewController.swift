//
//  ModalViewController.swift
//  TaskRoulette
//
//  Created by Rizky Maulana on 29/04/22.
//

import UIKit
protocol ModalViewControllerDelegate: AnyObject {
  func addItemViewControllerDidCancel(
    _ controller: ModalViewController)
  func addItemViewController(
    _ controller: ModalViewController,
    didFinishAdding item: TodoModel
  )
    
}
class ModalViewController: UIViewController {
    weak var delegate: ModalViewControllerDelegate?
    
    let cancelButton: UIButton = {
        let x = UIButton()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.setTitle("Cancel", for: .normal)
        x.setTitleColor(UIColor(red: 251/255, green: 90/255, blue: 72/255, alpha: 1), for: .normal)
        x.heightAnchor.constraint(equalToConstant: 22).isActive = true
        x.widthAnchor.constraint(equalToConstant: 75).isActive = true
        return x
    }()
    let taskTextField: UITextField = {
        let x = UITextField()
        x.placeholder = "Task Name"
        x.translatesAutoresizingMaskIntoConstraints = false
        x.textAlignment = .center
        x.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return x
    }()
    let prioTextField: UITextField = {
        let x = UITextField()
        x.placeholder = "Priority"
        x.translatesAutoresizingMaskIntoConstraints = false
        x.textAlignment = .center
        x.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return x
    }()
    let addButton: UIButton = {
        let x = UIButton()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.setTitle("Add", for: .normal)
        x.setTitleColor(UIColor(red: 42/255, green: 154/255, blue: 70/255, alpha: 1), for: .normal)
        x.heightAnchor.constraint(equalToConstant: 22).isActive = true
        x.widthAnchor.constraint(equalToConstant: 75).isActive = true
        return x
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        view.addSubview(cancelButton)
        view.addSubview(addButton)
        view.addSubview(taskTextField)
        view.addSubview(prioTextField)
        
        cancelButton.addTarget(self, action: #selector(dismissView(_:)), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addItem(_:)), for: .touchUpInside)
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        taskTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 75).isActive = true
        taskTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        prioTextField.topAnchor.constraint(equalTo: taskTextField.topAnchor,constant: 75).isActive = true
        prioTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    @objc func dismissView(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @objc func addItem(_ sender:UIButton){
//        print("\(taskTextField.text!)")
//        dismiss(animated: true)
        let x = TodoModel()
        if !taskTextField.text!.isEmpty && !prioTextField.text!.isEmpty{
            
            x.text = taskTextField.text!
            x.priority = prioTextField.text!
            delegate?.addItemViewController(self, didFinishAdding: x)
            dismiss(animated: true)
        }else {
            sender.setTitleColor(UIColor(red: 42/255, green: 154/255, blue: 70/255, alpha: 0.5), for: .normal)
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ModalViewController: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField, range:NSRange,replacement: String) -> Bool {
        let oldText = taskTextField.text!
        let stringRange = Range(range, in: oldText)!
          let newText = oldText.replacingCharacters(
            in: stringRange,
            with: replacement)
          if newText.isEmpty {
            addButton.isEnabled = false
          } else {
            addButton.isEnabled = true
          }
          return true
    }
}
