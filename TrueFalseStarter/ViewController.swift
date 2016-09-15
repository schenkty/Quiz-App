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
    
    let questionsPerRound = setOfQuestions.count
    var questionsAsked = 0
    var correctQuestions = 0
    var currentQuestion = pullQuestion()
    
    var gameSound: SystemSoundID = 0
    var falseSound: SystemSoundID = 0
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        loadGameFalseSound()
        // Start game
        nextRound()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        questionField.text = currentQuestion.question
        playAgainButton.isHidden = true
        displayOptions()
        hideAllOptions(false)
    }
    
    func displayOptions() {
        if currentQuestion.option.count == 4 {
            option1.setTitle(currentQuestion.option[0], for: UIControlState())
            option2.setTitle(currentQuestion.option[1], for: UIControlState())
            option3.setTitle(currentQuestion.option[2], for: UIControlState())
            option4.setTitle(currentQuestion.option[3], for: UIControlState())
        } else if currentQuestion.option.count == 3 {
            option1.setTitle(currentQuestion.option[0], for: UIControlState())
            option2.setTitle(currentQuestion.option[1], for: UIControlState())
            option3.setTitle(currentQuestion.option[2], for: UIControlState())
            option4.isHidden = true
        } else {
            option1.setTitle(currentQuestion.option[0], for: UIControlState())
            option2.setTitle(currentQuestion.option[1], for: UIControlState())
            option3.isHidden = true
            option4.isHidden = true
        }
    }
    
    func hideAllOptions(_ boolean: Bool) {
        
        let options: [UIButton] = [option1, option2, option3, option4]
        
        for option in options {
            
            option.isHidden = boolean
        }
    }
    
    func displayScore() {
        // Hide the answer buttons
        hideAllOptions(true)
        
        // Display play again button
        playAgainButton.isHidden = false
        
        // Based the score message on percent in case the array of questions is increased
        let percent = correctQuestions * 100/questionsPerRound
        if percent > 55 {
            questionField.text = "Way to go!\nYou got a \(percent)%"
        } else {
            questionField.text = "Oops! You only got a \(percent)%\nTry better next time!"
        }
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        // Set correctAnswer to the current Trivia Set's answer
        let correctAnswer = currentQuestion.answer
        
        if (sender === option1 &&  option1.currentTitle == correctAnswer) ||
            (sender === option2 && option2.currentTitle == correctAnswer) ||
            (sender === option3 && option3.currentTitle == correctAnswer) ||
            (sender === option4 && option4.currentTitle == correctAnswer) {
            
            correctQuestions += 1
            questionField.text = "Correct!"
            playGameStartSound()
        } else {
            questionField.text = "Sorry, wrong answer!\nThe correct answer is \(currentQuestion.answer)"
            playGameFalseSound()
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
            currentQuestion = pullQuestion()
            questionField.text = currentQuestion.question
            displayOptions()
            playAgainButton.isHidden = true
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        hideAllOptions(true)
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
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
    
    func loadGameFalseSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "falseSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &falseSound)
    }
    
    func playGameFalseSound() {
        AudioServicesPlaySystemSound(falseSound)
    }
}

