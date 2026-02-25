//
//  RunQuiz.swift
//  iQuiz
//
//  Created by Hanna Pan on 2/19/26.
//

import SwiftUI

struct RunQuiz: View {
    
    let quiz: Quiz
    let questionIndex: Int
    let score: Int
    
    @Binding var path: NavigationPath
    @State private var selectedAnswer: Int? = nil

    var body: some View {
        let question = quiz.questions[questionIndex]
        VStack (alignment: .center, spacing: 24) {
            
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
            
            NavigationLink {
                AnswerView(quiz: quiz,
                           questionIndex: questionIndex,
                           selectedAnswerIndex: selectedAnswer ?? 0,
                           userScore: score,
                           path: $path
                )
            } label: {
                Text("Submit")
            }
            .buttonStyle(.borderedProminent)
            .disabled(selectedAnswer == nil)
            
            Text("Tip: Swipe right to submit or left to exit.")
                .font(.footnote)
                .foregroundColor(.secondary)
                
        }
        .padding()
        .navigationTitle(quiz.topic.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
