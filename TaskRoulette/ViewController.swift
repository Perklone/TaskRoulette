//
//  ViewController.swift
//  TaskRoulette
//
//  Created by Rizky Maulana on 27/04/22.
//

import UIKit

class ViewController: UIViewController, ModalViewControllerDelegate {
    
    
    var lists = [TodoModel]()
    let taskHeader: UILabel = {
        let x = UILabel()
        x.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        x.translatesAutoresizingMaskIntoConstraints = false
        x.text = "Active Task"
        
        return x
    }()
    let prioHeader: UILabel = {
        let x = UILabel()
        x.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        x.translatesAutoresizingMaskIntoConstraints = false
        x.text = "Priority"
        
        return x
    }()
    let tableView: UITableView = {
       let x = UITableView()
        x.register(UITableViewCell.self, forCellReuseIdentifier: "backlogCell")
        x.translatesAutoresizingMaskIntoConstraints = false
        
        return x
    }()
    let confirmLabel : UILabel = {
        let x = UILabel()
        x.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        x.translatesAutoresizingMaskIntoConstraints = false
        x.textAlignment = .center
        x.text = "Task Completed?"
        return x
    }()
    let addButton: UIButton = {
       let x = UIButton()
        x.setImage(UIImage(systemName: "plus.square.on.square"), for: .normal)
        x.translatesAutoresizingMaskIntoConstraints = false
        x.widthAnchor.constraint(equalToConstant: 50).isActive = true
        x.heightAnchor.constraint(equalToConstant: 50).isActive = true
        x.tintColor = .white
        
        return x
    }()
    let logoImage: UIImageView = {
        let x = UIImageView()
        x.image = UIImage(named: "diceLogo")
        x.translatesAutoresizingMaskIntoConstraints = false
        x.widthAnchor.constraint(equalToConstant: 55).isActive = true
        x.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        return x
    }()
    let rollButton: UIButton = {
        let x = UIButton()
       
        x.translatesAutoresizingMaskIntoConstraints = false
        x.setTitle("Roll a Task!", for: .normal)
        x.backgroundColor = UIColor(red: 251/255, green: 90/255, blue: 72/255, alpha: 1)
        x.heightAnchor.constraint(equalToConstant: 34).isActive = true
        x.widthAnchor.constraint(equalToConstant: 205).isActive = true
        x.layer.cornerRadius = 10
        x.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return x
    }()
//    let titleActiveLabel: UILabel = {
//        let x = UILabel()
//        x.text = "Active Task"
//        x.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        x.translatesAutoresizingMaskIntoConstraints = false
//        return x
//    }()
    let taskLabel: UILabel = {
        let x = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.text = "-"
        x.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        x.lineBreakMode = .byWordWrapping
        x.textAlignment = .center
        return x
    }()
    let prioLabel: UILabel = {
        let x = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.text = "-"
        x.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        x.lineBreakMode = .byWordWrapping
        x.textAlignment = .center
        return x
    }()
    let completeButton: UIButton = {
        let x = UIButton()
       
        x.translatesAutoresizingMaskIntoConstraints = false
        x.setTitle("Finish!", for: .normal)
        x.backgroundColor = UIColor(red: 42/255, green: 154/255, blue: 70/255, alpha: 1)
        x.heightAnchor.constraint(equalToConstant: 34).isActive = true
        x.widthAnchor.constraint(equalToConstant: 119).isActive = true
        x.layer.cornerRadius = 10
        x.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return x
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
  
        setup()
        
        
        // Do any additional setup after loading the view.
    }
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.addSubview(logoImage)
        view.addSubview(rollButton)
        view.addSubview(taskHeader)
        view.addSubview(taskLabel)
        view.addSubview(prioHeader)
        view.addSubview(prioLabel)
        view.addSubview(confirmLabel)
        view.addSubview(completeButton)
        view.addSubview(tableView)
        rollButton.addTarget(self, action: #selector(rollTask(_:)), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(finishTask(_:)), for: .touchUpInside)

        rollButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rollButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 15).isActive = true
        logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        taskHeader.topAnchor.constraint(equalTo: rollButton.bottomAnchor, constant: 40).isActive = true
        taskHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60).isActive = true
        taskLabel.topAnchor.constraint(equalTo: taskHeader.bottomAnchor, constant: 10).isActive = true
        taskLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        prioHeader.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 25).isActive = true
        prioHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -70).isActive = true
        prioLabel.topAnchor.constraint(equalTo: prioHeader.bottomAnchor, constant: 10).isActive = true
        prioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmLabel.topAnchor.constraint(equalTo: prioLabel.bottomAnchor, constant: 25).isActive = true
        confirmLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        completeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        completeButton.topAnchor.constraint(equalTo: confirmLabel.bottomAnchor, constant: 15).isActive = true
        tableView.topAnchor.constraint(equalTo: completeButton.bottomAnchor, constant: 30).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    @objc func addItem(_ sender: UIButton) {
        let sheetVC = ModalViewController()
        if let sheet = sheetVC.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        sheetVC.delegate = self
        present(sheetVC, animated: true, completion: nil)
        
    }
    func addItemViewControllerDidCancel(_ controller: ModalViewController) {
//        dismiss(animated: true)
    }
    
    func addItemViewController(_ controller: ModalViewController, didFinishAdding item: TodoModel) {
        lists.append(item)
        tableView.reloadData()
//        dismiss(animated: true)
    }
    @objc func rollTask(_ sender:UIButton){
        if(lists.isEmpty){
            
        }else{
            let index = Int.random(in: 0..<lists.count)
            let pick = lists[index]
            taskLabel.text = pick.text
            prioLabel.text = pick.priority
        }
    }
    @objc func finishTask(_ sender:UIButton){
        if(lists.isEmpty){
            
        }
        else{
            var index = 0
            for list in lists {
                if(list.text == taskLabel.text){
                    break
                }
                index += 1
            }
            lists.remove(at: index)
            
            taskLabel.text = "-"
            prioLabel.text = "-"
            tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listIndex = lists[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "backlogCell", for: indexPath)
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "backlogCell")
        cell.textLabel?.text = listIndex.text
        cell.detailTextLabel?.text = listIndex.priority
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        tableView.sectionHeaderTopPadding = 0
        vw.backgroundColor = UIColor(red: 251/255, green: 90/255, blue: 72/255, alpha: 1)
        
        let label = UILabel()
        label.frame = CGRect.init(x: 15, y: 5, width: vw.frame.width-10, height: vw.frame.height-10)
        label.text = "Backlog"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        vw.addSubview(label)
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.square.on.square"), for: .normal)
        button.frame = CGRect.init(x: vw.frame.width-60, y: 0, width: 50, height: 50)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addItem(_:)), for: .touchUpInside)
        vw.addSubview(button)
        return vw
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
}
