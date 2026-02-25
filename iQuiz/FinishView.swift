//
//  FinishView.swift
//  iQuiz
//
//  Created by Hanna Pan on 2/24/26.
//

import SwiftUI

struct FinishView: View {
    
    let quiz: Quiz
    let score: Int
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text("Quiz Finished!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            if (score == quiz.questions.count) {
                Text("Perfect!")
                    .font(.title3)
                    .foregroundColor(.green)
            } else if (score == 0){
                Text("Better luck next time!")
                    .font(.title3)
                    .foregroundColor(.red)
            } else if (score >= quiz.questions.count / 2){
                Text("Almost there!")
                    .font(.title3)
                    .foregroundColor(.orange)
            }
            
            Text("Score: \(score) of \(quiz.questions.count) correct")
                .font(.title3)
            
            Button("Next") {
                path = NavigationPath()
            }
            .buttonStyle(.borderedProminent)
            
        }
        .padding()
        .navigationTitle(quiz.topic.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
