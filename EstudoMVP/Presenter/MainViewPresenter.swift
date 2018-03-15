//
//  MainViewPresenter.swift
//  EstudoMVP
//
//  Created by Lucas Santos on 15/03/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

class MainViewPresenter {
    
    private var view: MainViewProtocol?
    private var questionService = QuestionsService()
    private var cachedQuestions = [Question]()
    
    init(owner: MainViewProtocol) {
        view = owner
        self.questionService.delegate = self
        self.questionService.requestAllQuestionsAndChoices()
    }
}

extension MainViewPresenter: MainViewPresenterProtocol {
    func requestQuestion(forIndex: Int) -> Question {
        return cachedQuestions[forIndex]
    }
    
    
    func requestChoiceCount(questionIndex: Int) -> Int {
        return cachedQuestions[questionIndex].choices.count
    }

    func requestChoiceName(questionIndex: Int, choiceIndex: Int) -> String? {
        if(questionIndex < self.cachedQuestions.count) {
            if(choiceIndex < self.cachedQuestions[questionIndex].choices.count) {
                return self.cachedQuestions[questionIndex].choices[choiceIndex].choice
            }
            else
            {
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    func requestChoiceCount(questionIndex: Int, choiceIndex: Int) -> String? {
        if(questionIndex < self.cachedQuestions.count) {
            if(choiceIndex < self.cachedQuestions[questionIndex].choices.count) {
                return String(self.cachedQuestions[questionIndex].choices[choiceIndex].voteCount)
            }
            else
            {
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    func requestQuestionBody(forIndex: Int) -> String? {
        if (forIndex < self.cachedQuestions.count) {
            return self.cachedQuestions[forIndex].questionBody
        }
        else {
            return nil
        }
    }
    
    func requestQuestionDate(forIndex: Int) -> String? {
        if (forIndex < self.cachedQuestions.count) {
            return DateFormatter.localizedString(from: self.cachedQuestions[forIndex].date, dateStyle: .medium, timeStyle: .medium)
        }
        else {
            return nil
        }
    }
    
    func requestQuestionCount() -> Int {
        return self.cachedQuestions.count
    }
    
//    func requestQuestionList() -> [Question] {
//        return self.cachedQuestions
//    }
    
}

extension MainViewPresenter: QuestionProtocol {
    func updateQuestionList(questions: [Question]) {
        self.cachedQuestions = questions
        if let view = self.view {
            view.updateQuestionList()
        }
    }
}
