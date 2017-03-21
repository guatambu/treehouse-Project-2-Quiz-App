//
//  TriviaDataModel.swift
//  TrueFalseStarter
//
//  Created by Michael Guatambu Davis on 3/16/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import GameKit

// This is the class to set up the questions and their respective answers

struct TriviaQuestionStruct {
    var question = "0"
    var answer = "0"
    
}



// these are the instances of the various questions with their respective answers

let questionA = TriviaQuestionStruct(question: "What is a Berimbau?", answer: "Musical Instrument")
let questionB = TriviaQuestionStruct(question: "What is a Queixada?", answer: "Circular Kick")
let questionC = TriviaQuestionStruct(question: "What is a Godeme?", answer: "Hand Strike")
let questionD = TriviaQuestionStruct(question: "What is an Aú?", answer: "Ground Movement")
let questionE = TriviaQuestionStruct(question: "What is an Agogô?", answer: "Musical Instrument")
let questionF = TriviaQuestionStruct(question: "What is a Rolê?", answer: "Ground Movement")
let questionG = TriviaQuestionStruct(question: "What is an Armada?", answer: "Circular Kick")
let questionH = TriviaQuestionStruct(question: "What is a Galopante?", answer: "Hand Strike")

// this is an array of the question/answer instances

struct TriviaSource {
    
    let triviaQuestion = "0"

    var questionAnswerArray = [
        questionA,
        questionB,
        questionC,
        questionD,
        questionE,
        questionF,
        questionG,
        questionH
    ]
    
    func randomQuestion1() -> TriviaQuestionStruct {
        let randomIndexNumber = GKRandomSource.sharedRandom().nextInt(upperBound: questionAnswerArray.count)
        return questionAnswerArray[randomIndexNumber]
    }
    
    
    /// func generates a random number based on questionAnswerArray's contents
    func randomIndexNumberGenerator() -> Int {
        let randomIndexNumber = GKRandomSource.sharedRandom().nextInt(upperBound: questionAnswerArray.count)
        return randomIndexNumber
    }
    
    /// func generates question from instance of questionAnswerArray based on provided index value
    func randomQuestion(at index: Int) -> TriviaQuestionStruct {
        let randomQuestion = questionAnswerArray[index]
        return randomQuestion
    }
    
    /// func removes question from instance of questionAnswerArray based on provided index value
    mutating func arrayItemRemover(at index: Int) -> TriviaQuestionStruct {
        let removedArrayItem = questionAnswerArray.remove(at: index)
        return removedArrayItem
    }
    
    
}


// these are structs for the 4 response options

struct OptionASource {
    var optionA = "0"

    init(optionA: String) {
        self.optionA = optionA
    }
}

struct OptionBSource {
    var optionB = "0"
 
    init(optionB: String) {
    self.optionB = optionB

    }
}

struct OptionCSource {
    var optionC = "0"
 
    init(optionC: String) {
    self.optionC = optionC
    }
}

struct OptionDSource {
    var optionD = "0"

    init(optionD: String) {
    self.optionD = optionD
    }
}


// these are instances of the 4 response options

let optionA = OptionASource(optionA: "Musical Instrument")
let optionB = OptionBSource(optionB: "Circular Kick")
let optionC = OptionCSource(optionC: "Hand Strike")
let optionD = OptionDSource(optionD: "Ground Movement")

// this is an aaray of those response option instances

var optionsArray = [optionA, optionB, optionC, optionD] as [Any]





