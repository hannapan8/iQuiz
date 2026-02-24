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

struct RemoteQuiz: Codable {
    let title: String
    let desc: String
    let questions: [RemoteQuestion]
}

struct RemoteQuestion: Codable {
    let text: String
    let answer: String
    let answers: [String]
}

struct ContentView: View {
    
    @AppStorage("quizURL") private var quizURL: String =
        "http://tednewardsandbox.site44.com/questions.json"
    @State private var quizzes: [Quiz] = []
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSettings = false
    
    func downloadQuizData(showSuccess: Bool) async {
        do {
            let url = URL(string: quizURL)!
            let (data, _) = try await URLSession.shared.data(from: url)
            let remote = try JSONDecoder().decode([RemoteQuiz].self, from: data)
            
            quizzes = remote.map { rmtQuestion in
                let topic = QuizTopic(
                    title: rmtQuestion.title,
                    description: rmtQuestion.desc,
                    icon: "questionmark.circle"
                )
                
                let questions = rmtQuestion.questions.map { question in
                    let answerIndex = max(0, (Int(question.answer) ?? 1) - 1)
                    return Question(
                        question: question.text,
                        answerOptions: question.answers,
                        correctAnswerIndex: answerIndex
                    )
                }
                
                return Quiz(topic: topic, questions: questions)
            }
            
            if (showSuccess) {
                alertMessage = "Quizzes refreshed successfully!"
                showAlert = true
            }
            
            
        } catch {
            alertMessage = "Error downloading quiz data. Please try again."
            showAlert = true
        }
    }
    
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
            .task {
                if quizzes.isEmpty {
                    await downloadQuizData(showSuccess: false)
                }
            }
            
            .alert("NOTICE", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
            
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
            
            .sheet(isPresented: $showSettings) {
                NavigationStack {
                    Form {
                        Section(header: Text("Quiz Source URL")) {
                            TextField("URL", text: $quizURL)

                            Button("Check now") {
                                Task {
                                    await downloadQuizData(showSuccess: true)
                                }
                            }
                        }
                    }
                    .navigationTitle("Settings")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Done") {
                                showSettings = false
                            }
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
