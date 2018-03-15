//
//  Question.swift
//  EstudoMVP
//
//  Created by Lucas Santos on 15/03/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

class Question {
    
    var date: Date
    var questionBody: String
    var choices: [QuestionChoice]
    
    //Simple init with no choices, and current date
    init(questionBody: String) {
        self.questionBody = questionBody
        self.date = Date()
        self.choices = [QuestionChoice]()
    }
    
    init(questionBody: String, creationDate: Date) {
        self.questionBody = questionBody
        self.date = creationDate
        self.choices = [QuestionChoice]()
    }
    
    func addChoice(choice: QuestionChoice)
    {
        self.choices.append(choice)
    }
}
