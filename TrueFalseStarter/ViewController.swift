//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

// PLEASE NOTE: i kept my comments to a minimum since this is not my original codeblock.  i did include some where i felt relevant and appropriate.

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    // let triviaSource = TriviaSource()
    let triviaSource1 = TriviaSource1()
    var currentQuestion = TriviaQuestionStruct()
    var gameSound: SystemSoundID = 0
    var failBuzzer: SystemSoundID = 0
    var claps: SystemSoundID = 0
 
    
    @IBOutlet weak var questionField: UILabel!
    // i belabored the button names for too long. finally, i just went generic. 
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var false2Button: UIButton!
    @IBOutlet weak var false3Button: UIButton!
    
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* 
    PLEASE NOTE:  i ran into difficulties, not in generating the random questions order, but in preventing question repetition.  i couldn't figure out a way to flag a question as having been asked, thereby removing it from possible choices in the next round.  i tried removing the question from the array in the instance created, but ran into two problems...
        1) actually removing the item from the array because the value of the question dictionary was not 'Equatable'
        2) resetting the instance before beginning the new round
        i sought help on stack overflow, and got the response and idea of creating an array of structs rather than dictionaries...  i wasn't confident in that approach.
        Thoughts?
     
    So, i left this here just as a reminder that i did try to use this idea.
     */
    func displayQuestion() {
        currentQuestion = triviaSource1.randomQuestion()
        questionField.text = currentQuestion.question
        playAgainButton.isHidden = true
    }
    
    
    // PLEASE NOTE: the questions are displayed without repitition.
/*
    func displayQuestion() {
        let questionDictionary = triviaSource.triviaQuestions[indexOfSelectedQuestion]
        questionField.text = questionDictionary["Question"]
        playAgainButton.isHidden = true
    }
*/
    func displayScore() {
        // Hide the answer buttons
        trueButton.isHidden = true
        falseButton.isHidden = true
        false2Button.isHidden = true
        false3Button.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let correctAnswer = currentQuestion.answer
        
        if (sender === trueButton &&  correctAnswer == "Musical Instrument") || (sender === falseButton && correctAnswer == "Circular Kick") || (sender === false2Button && correctAnswer == "Hand Strike") ||
            (sender === false3Button && correctAnswer == "Ground Movement") {
            loadCorrectSound()
            playCorrectSound()
            
            correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            loadIncorrectSound()
            playIncorrectSound()
            
            questionField.text = "Sorry, wrong answer!\n  It's a type of \((correctAnswer))"
            
        }
        
        loadNextRoundWithDelay(seconds: 2.5)
        
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        trueButton.isHidden = false
        falseButton.isHidden = false
        false2Button.isHidden = false
        false3Button.isHidden = false
        // currentQuestion = TriviaQuestionStruct
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Double) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    // my additional sounds.  
    // PLEASE NOTE:  it was hard to find sound files that were appropriate.  
    // UX is a bit wonky as a result.
    // every site except one i went to wanted youto create an account and blah blah blah, so...
    // the little bit of wonkiness is a result of the duration of the sound files i found
    
    func loadIncorrectSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "FailBuzzer", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &failBuzzer)
    }
    
    func playIncorrectSound() {
        AudioServicesPlaySystemSound(failBuzzer)
    }
    
    func loadCorrectSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "Claps", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &claps)
    }
    
    func playCorrectSound() {
        AudioServicesPlaySystemSound(claps)
    }
    
    // i took a crack at the extra credit, but felt i had the ability to do 2 of them effectively.

}
