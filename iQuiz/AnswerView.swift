//
//  AnswerView.swift
//  iQuiz
//
//  Created by Hanna Pan on 2/24/26.
//

import SwiftUI

struct AnswerView: View {
    let quiz: Quiz
    let questionIndex: Int
    let selectedAnswerIndex: Int
    let userScore: Int
    @Binding var path: NavigationPath
    
    var body: some View {
        let question = quiz.questions[questionIndex]
        let isCorrect = (selectedAnswerIndex == question.correctAnswerIndex)
        let totalScore = userScore + (isCorrect ? 1 : 0)
        let isLastQuestion = (questionIndex == quiz.questions.count - 1)
        
        VStack(alignment: .center, spacing: 24) {
            Text(question.question)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Correct answer: \(question.answerOptions[question.correctAnswerIndex])")
                .font(.headline)
            
            if (isCorrect) {
                Text("✅ You got it right!")
                    .foregroundColor(.green)
            } else {
                Text("❌ Wrong answer!")
                    .foregroundColor(.red)
            }
            
            NavigationLink {
                if (isLastQuestion) {
                    FinishView(quiz: quiz, score: totalScore, path: $path)
                } else {
                    RunQuiz(quiz: quiz, questionIndex: questionIndex + 1, score: totalScore, path: $path)
                }
            } label: {
                Text("Next")
            }
            .buttonStyle(.borderedProminent)
                
        
            
            Text("Tip: Swipe right to continue or left to exit.")
                .font(.footnote)
                .foregroundColor(.secondary)
            
        }
        .padding()
        .navigationTitle(quiz.topic.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
