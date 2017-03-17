//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    let triviaSource = TriviaSource()
    var gameSound: SystemSoundID = 0
    var failBuzzer: SystemSoundID = 0
    var claps: SystemSoundID = 0
 
    
    @IBOutlet weak var questionField: UILabel!
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
    func displayQuestion() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: triviaSource.triviaQuestions.count)
        let questionDictionary = triviaSource.triviaQuestions[indexOfSelectedQuestion]
        questionField.text = questionDictionary["Question"]
        playAgainButton.isHidden = true
    }
    */
    
    func displayQuestion() {
        let questionDictionary = triviaSource.triviaQuestions[indexOfSelectedQuestion]
        questionField.text = questionDictionary["Question"]
        playAgainButton.isHidden = true
    }
    
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
        
        let selectedQuestionDict = triviaSource.triviaQuestions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict["Answer"]
        
        if (sender === trueButton &&  correctAnswer == "a musical Instrument") || (sender === falseButton && correctAnswer == "a circular kick") || (sender === false2Button && correctAnswer == "a head butt") ||
            (sender === false3Button && correctAnswer == "a cartwheel") {
            loadCorrectSound()
            playCorrectSound()
            indexOfSelectedQuestion += 1
            correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            loadIncorrectSound()
            playIncorrectSound()
            indexOfSelectedQuestion += 1
            questionField.text = "Sorry, wrong answer!\n  It's \((correctAnswer)!)"
            
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
        
        indexOfSelectedQuestion = 0
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

}
