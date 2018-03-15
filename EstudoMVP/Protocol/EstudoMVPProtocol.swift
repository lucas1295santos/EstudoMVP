//
//  EstudoMVPProtocol.swift
//  EstudoMVP
//
//  Created by Lucas Santos on 15/03/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

//View -> presenter
protocol MainViewProtocol {

    func updateQuestionList() -> Void

}

//Presenter -> View
protocol MainViewPresenterProtocol {
    func requestQuestionCount() -> Int
//    func requestQuestionList() -> [Question]
    func requestQuestionBody(forIndex: Int) -> String?
    func requestQuestionDate(forIndex: Int) -> String?
    func requestChoiceName(questionIndex: Int, choiceIndex: Int) -> String?
    func requestChoiceCount(questionIndex: Int, choiceIndex: Int) -> String?
    func requestChoiceCount(questionIndex: Int) -> Int
    func requestQuestion(forIndex: Int) -> Question
}
