//
//  ViewController.swift
//  EstudoMVP
//
//  Created by Lucas Santos on 15/03/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private var presenter: MainViewPresenterProtocol?
    let tableViewCellIdentifier = "questionCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MainViewPresenter(owner: self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.question = sender as! Question
        }
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: presenter!.requestQuestion(forIndex: indexPath.row))
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.tableViewCellIdentifier, for: indexPath) as! MainTableViewCell
        
        cell.questionBodyLabel.text = presenter!.requestQuestionBody(forIndex: indexPath.row)!
        cell.questionDateLabel.text = presenter!.requestQuestionDate(forIndex: indexPath.row)!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let presenter = self.presenter {
            return presenter.requestQuestionCount()
        }
        else {
            return 0
        }
    }
}

extension MainViewController: MainViewProtocol {
    func updateQuestionList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    
    
}

