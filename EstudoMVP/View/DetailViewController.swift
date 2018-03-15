//
//  DetailViewController.swift
//  EstudoMVP
//
//  Created by Lucas Santos on 15/03/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let identifier: String = "choiceIndexIdentifier"
    
    var question: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.title = question!.questionBody
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "choiceIndexIdentifier", for: indexPath) as! ExpandableTableViewCell
        
        cell.choiceLabel.text = question!.choices[indexPath.row].choice
        cell.voteCountLabel.text = String(question!.choices[indexPath.row].voteCount)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}

extension DetailViewController: UITableViewDelegate {
    
}
