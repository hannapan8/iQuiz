//
//  ContentView.swift
//  iQuiz
//
//  Created by Hanna Pan on 2/15/26.
//

import SwiftUI

struct QuizTopic: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
}

struct Question: Identifiable {
    let id = UUID()
    let question: String
    let answerOptions: [String]
    let correctAnswerIndex: Int
}

struct Quiz: Identifiable {
    let id = UUID()
    let topic: QuizTopic
    let questions: [Question]
}

struct ContentView: View {
    let quizzes: [Quiz] = [
        Quiz(
            topic: QuizTopic(title: "Mathematics",
                              description: "Explore mathematical topics and sharpen your calculation skills!",
                              icon: "pencil.and.list.clipboard"
                    ),
             questions: [
                Question(question: "What is 9 % (10 / 4)?", answerOptions: ["0", "2", "1", "3"], correctAnswerIndex: 2),
                Question(question: "What is (2^6) + 3?", answerOptions: ["64", "67", "66", "65"], correctAnswerIndex: 1)
             ]
        ),
        Quiz(
            topic: QuizTopic(title: "Marvel Super Heroes",
                             description: "Test your knowledge of Marvel characters!",
                             icon: "person.crop.artframe"
                   ),
            questions: [
                Question(question: "What is the name of Thor's hammer?", answerOptions: ["Mjolnir", "Thor's hammer", "Dumbledore", "The Hammer"], correctAnswerIndex: 0),
                Question(question: "Which character is known for saying, \"I can do this all day\"?", answerOptions: ["Iron Man", "Spider-man", "Hulk", "Captain America"], correctAnswerIndex: 3)
            ]
        ),
        Quiz(
            topic: QuizTopic(title: "Science",
                            description: "Delve into the depths of biology, physics, chemistry, and more!",
                            icon: "atom"
                  ),
            questions: [
                Question(question: "How many elements are on the periodic table?", answerOptions: ["110", "118", "120", "113"], correctAnswerIndex: 1),
                Question(question: "How many bones do sharks have?", answerOptions: ["256", "114", "135", "0"], correctAnswerIndex: 3)
            ]
        )
    ]
    
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            List(quizzes) { quiz in
                NavigationLink {
                    RunQuiz(quiz: quiz)
                } label: {
                    HStack(spacing: 16) {
                        Image(systemName: quiz.topic.icon)
                            .font(.title3)
                            .frame(width: 30)
                        
                        VStack(alignment: .leading) {
                            Text(quiz.topic.title)
                                .font(.headline)
                                .lineLimit(1)
                            
                            Text(quiz.topic.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        
                    }
                    .padding(.vertical, 3)
                }
            }
            .navigationTitle("iQuiz")
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 14))
                            Text("Settings")
                        }
                        
                    }
                }
            }
            .alert("Settings go here", isPresented: $showSettings) {
                Button("OK", role: .cancel) {
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
