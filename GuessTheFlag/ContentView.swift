//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Woodrow Martyr on 24/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var endOfGame = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var questionNumber = 0
    @State private var isCorrect = false
    @State private var chosenNumber = 3
    @State private var rotationAmount = 0.0
    
    @State private var animationAmount = 0.0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0..<3)
    
    struct FlagImage: View {
        var flagName: String
        
        var body: some View {
            Image(flagName)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(radius: 5)
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(flagName: countries[number])
                                .rotation3DEffect(
                                    .degrees(chosenNumber == number ? 360 : 0), axis: (x: 0.0, y: 1.0, z: 0.0)
                                )
                                .opacity(chosenNumber == number ? 1 : (chosenNumber == 3 ? 1 : 0.25))
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score: \(userScore)")
        }
        .alert("You've reached the end of the game", isPresented: $endOfGame) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your score: \(userScore) / 5")
        }
    }
    
    func flagTapped(_ number: Int) {
        chosenNumber = number
        print("chosenNumber: \(chosenNumber)")
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong, that's the flag of \(countries[number])"
        }
        questionNumber += 1
        if questionNumber  < 5 {
            showingScore = true
        } else {
            endOfGame = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
        chosenNumber = 3
    }
    
    func restartGame() {
        userScore = 0
        questionNumber = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
