//
//  RunQuiz.swift
//  iQuiz
//
//  Created by Hanna Pan on 2/19/26.
//

import SwiftUI

struct RunQuiz: View {
    
    let quiz: Quiz
    @State private var questionIndex = 0
    @State private var selectedAnswer: Int? = nil
    @State private var score = 0
    @State private var showAnswer = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack (alignment: .center, spacing: 24) {
            if (questionIndex >= quiz.questions.count) {
                Text("Quiz Finished!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                if (score == quiz.questions.count) {
                    Text("Perfect!")
                        .font(.title3)
                        .foregroundColor(.green)
                } else if (score == quiz.questions.count / 2){
                    Text("Almost there!")
                        .font(.title3)
                        .foregroundColor(.orange)
                } else if (score == 0) {
                    Text("Better luck next time!")
                        .font(.title3)
                        .foregroundColor(.red)
                }
                
                Text("Score: \(score) of \(quiz.questions.count) correct")
                    .font(.title3)
                
                Button("Next") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                
            } else {
                let question = quiz.questions[questionIndex]
                if (showAnswer) {
                    Text(question.question)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Correct answer: \(question.answerOptions[question.correctAnswerIndex])")
                        .font(.headline)
                    
                    if (selectedAnswer == question.correctAnswerIndex) {
                        Text("✅ You got it right!")
                            .foregroundColor(.green)
                    } else {
                        Text("❌ Wrong answer!")
                            .foregroundColor(.red)
                    }
                    
                    Button("Next") {
                        questionIndex += 1
                        selectedAnswer = nil
                        showAnswer = false
                    }
                    .buttonStyle(.borderedProminent)
                    
                } else {
                    Text(question.question)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    ForEach(question.answerOptions.indices, id: \.self) { i in
                        Button {
                            selectedAnswer = i
                        } label: {
                            HStack (alignment: .center) {
                                if (selectedAnswer == i) {
                                    Image(systemName: "largecircle.fill.circle")
                                } else {
                                    Image(systemName: "circle")
                                }
                                Text(question.answerOptions[i])
                                Spacer()
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(.leading, 20)
                    }
                    
                    Button("Submit") {
                        if (selectedAnswer == question.correctAnswerIndex) {
                            score += 1
                        }
                        showAnswer = true
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(selectedAnswer == nil)
                }
            }
        }
        .padding()
        .navigationTitle(quiz.topic.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
