//
//  QuestionModel.swift
//  TrueFalseStarter
//
//  Created by Ty Schenk on 8/24/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
import GameKit

// global variables

var indexOfSelectedQuestions = 0
var count: Int = 0
var usedQuestions = [Int]()

struct Question {
    
    // Structure of the question sets
    let question: String
    var option: [String]
    let answer: String
}

let question1 = Question(question: "What year was the first iPhone released?", option: ["2007", "2011", "2003", "2005"], answer: "2007")
let question2 = Question(question: "Can only female koalas whistle?", option: ["Yes", "No"], answer: "No")
let question3 = Question(question: "Are Blue whales technically whales?", option: ["Yes", "No"], answer: "Yes")
let question4 = Question(question: "Are Camels cannibalistic?", option: ["Yes", "No"], answer: "No")
let question5 = Question(question: "Are ducks a bird?", option: ["Yes", "No"], answer: "Yes")


// Adding the questions together to create a set
var setOfQuestions = [question1, question2, question3, question4, question5]

// This randomly pulls and returns a question Question from the setOfQuestions array
// Want to rebuild the part below as I barrowed it from another project i found online
func pullQuestion() -> Question {
    
    count += 1
    
    // This condition resets the usedQuestions on all the Questions are used up
    if (usedQuestions.count == setOfQuestions.count) {
        
        usedQuestions.removeAll()
        count = 0
        
    // Make sure that the Questions have been reset
    } else if (count == 2 && usedQuestions.count == 1) {
        
        usedQuestions.removeAll()
        ()
        
    // This condition checks against indexes already used to generate a new random number
    } else if (usedQuestions.contains(indexOfSelectedQuestions)) {
        
        while (usedQuestions.contains(indexOfSelectedQuestions)) {
            
            indexOfSelectedQuestions = GKRandomSource.sharedRandom().nextIntWithUpperBound(setOfQuestions.count)
        }
    }
    
    // Using this array to make sure there are no repeats!
    usedQuestions.append(indexOfSelectedQuestions)
    
    let questionSelection = setOfQuestions[indexOfSelectedQuestions]
    
    return questionSelection
}
