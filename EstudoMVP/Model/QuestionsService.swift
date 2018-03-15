//
//  QuestionsService.swift
//  EstudoMVP
//
//  Created by Lucas Santos on 15/03/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

class QuestionsService {
    
    fileprivate let url: String = "http://private-bf9893-sentimentos.apiary-mock.com/questions"
    private(set) var questions: [Question]
    var delegate: QuestionProtocol?
    
    init() {
        questions = [Question]()
    }
    
    func requestAllQuestionsAndChoices() {

        APIDAO.requestToApi(url: self.url, queryDic: nil, headerDic: nil) { (data) in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    if let questionArray = self.parseQuestionArray(json) {
                        self.delegate?.updateQuestionList(questions: questionArray)
                    }
                    else {
                        //view controller keep placeholder
                        print("Não funcionou o parse!!")
                    }
                }
                catch {
                    
                }
            }
            else {
                //view controller keep placeholder
            }
            
        }
    }
    
    fileprivate func parseQuestionArray(_ json: Any) -> [Question]?
    {
        var retQuestions = [Question]()
        
        if let rootElement = json as? NSArray {
            for element in rootElement {
                if let question = parseQuestion(element) {
                    retQuestions.append(question)
                }
            }
        }
        else
        {
            return nil
        }
        
        
        return retQuestions
    }
    
    fileprivate func parseQuestion(_ json: Any) -> Question?
    {
        var retQuestion: Question? = nil
        
        if let questionData = json as? NSDictionary {
            if let questionBody = questionData["question"] as? String, let dateString = questionData["published_at"] as? String {
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                let date = formatter.date(from: dateString)
                
                if let date = date {
                    retQuestion = Question(questionBody: questionBody, creationDate: date)
                }
                
                if let questionJSON = questionData["choices"] as? NSArray
                {
                    let choices = self.parseChoiceArray(questionJSON)
                    for choice in choices {
                        retQuestion?.addChoice(choice: choice)
                    }
                }
            }
        }
        
        return retQuestion
    }
    
    fileprivate func parseChoiceArray(_ json: NSArray) -> [QuestionChoice]
    {
        var retChoices = [QuestionChoice]()
        
        for element in json {
            if let choice = parseChoice(element) {
                retChoices.append(choice)
            }
        }
        
        return retChoices
    }
    
    fileprivate func parseChoice(_ json: Any) -> QuestionChoice?
    {
        var retChoice: QuestionChoice? = nil
        
        if let choiceData = json as? NSDictionary {
            if let name = choiceData["choice"] as? String, let voteQuantity = choiceData["votes"] as? Int64 {
                retChoice = QuestionChoice(choice: name)
                retChoice!.AddVotes(quantity: Int(voteQuantity))
            }
        }
        
        return retChoice
    }
    
    
    
    
    
}
