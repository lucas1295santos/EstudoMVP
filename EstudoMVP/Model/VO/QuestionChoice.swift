//
//  QuestionChoice.swift
//  EstudoMVP
//
//  Created by Lucas Santos on 15/03/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

class QuestionChoice {
    
    var choice: String
    var voteCount: Int
    
    //Simple init with initial count 0
    init(choice: String) {
        self.choice = choice
        self.voteCount = 0
    }
    
    func AddVotes(quantity: Int)
    {
        self.voteCount += quantity
    }
}
