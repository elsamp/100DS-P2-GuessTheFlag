//
//  ContentView.swift
//  100DS-P2-GuessTheFlag
//
//  Created by Erica Sampson on 2024-07-11.
//

import SwiftUI

//Not required in this scenario but shows the example
struct FlagImage: View {
    
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .cornerRadius(20)
            .shadow(radius: 5)
    }
    
}


struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var showingScore = false
    @State private var runStreak = 0
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreMessage = ""
    
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.mint, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack {
                    Text("Select the correct flag:")
                        .font(.title)
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                        .foregroundColor(.white)
                }
                
                VStack {
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(imageName: countries[number])
                        }
                        .padding(10)
                    }
                }
                .padding(50)
                
                Spacer()
                Spacer()
                
                Text("Streak: \(runStreak)")
                    .foregroundColor(.white)
                    .font(.title2)
                
                Spacer()
            }
        }
        .alert(scoreMessage, isPresented: $showingScore) {
            if(runStreak >= 5){
                Button("Restart Game", action: restartGame)
            } else {
                Button("Next Question", action: askQuestion)
            }
            
        } message: {
            //Text("Your streak is now \(runStreak)")
        }
    }
    
    func askQuestion() {

        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        
        if(number == correctAnswer){
            runStreak += 1
            scoreMessage = "Correct!"
        } else {
            scoreMessage = "Oops!"
            runStreak = 0
        }
        
        //state change to show alert
        showingScore = true
    }
    
    func restartGame(){
        runStreak = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
