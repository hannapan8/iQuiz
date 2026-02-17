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

struct ContentView: View {
    let topics: [QuizTopic] = [
        QuizTopic(title: "Mathematics",
                  description: "Explore mathematical topics and sharpen your calculation skills!",
                  icon: "pencil.and.list.clipboard"
        ),
        QuizTopic(title: "Marvel Super Heroes",
                  description: "Test your knowledge of Marvel characters!",
                  icon: "person.crop.artframe"
        ),
        QuizTopic(title: "Science",
                  description: "Delve into the depths of biology, physics, chemistry, and more!",
                  icon: "atom"
        )
                  
    ]
    
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            List(topics) { topic in
                HStack(spacing: 16) {
                    Image(systemName: topic.icon)
                        .font(.title3)
                        .frame(width: 30)
                    
                    VStack(alignment: .leading) {
                        Text(topic.title)
                            .font(.headline)
                            .lineLimit(1)
                        
                        Text(topic.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 3)
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
