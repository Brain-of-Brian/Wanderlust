import SwiftUI

struct Game: View {
    @State private var SecretWord: String = ""
    @Binding var currentTab: Tabs
    @Binding var InformationTab: Int
    @Binding var DiscoveredLandmarks: [String]
    
    @State private var InfoView: Bool = false
    @State private var map: Bool = false
    @State private var InvalidLandmark: Bool = false
    
    @State private var GameWon: Bool = false
    @State private var GameOver: Bool = false
    
    @AppStorage("HighestStreak") var HighestStreak: Int = 0
    @AppStorage("CurrentStreak") var CurrentStreak: Int = 0
    @AppStorage("GamesWon") var GamesWon: Int = 0
    @AppStorage("GamesPlayed") var GamesPlayed: Int = 0
    @AppStorage("LastPlayed") private var LastPlayed: String = ""
    
    @State private var CurrentGuess: String = ""
    @State private var Guess: [String] = Array(repeating: "", count: 6)
    @State private var CurrentAttempt: Int = 0
    @State private var UsedLetters: [String: Color] = [:]
    
    let AvaliableLandmarks: [String] = ["PETRA", "LUXOR", "TULUM", "TOKYO", "ALAMO"]
    let AllowedLandmarks: [String] = ["PETRA", "LUXOR", "TULUM", "TOKYO", "ALAMO"]
    
    let CorrectLetter: Color = Color(red: 0.1, green: 0.35, blue: 0.2)
    let MisplacedLetter: Color = Color(red: 0.6, green: 0.5, blue: 0.1)
    let WrongLetter: Color = Color(red: 0.35, green: 0.25, blue: 0.15)
    let EmptyLetter = Color.clear
    let Gray = Color.gray.opacity(0.5)
    
    let KeyboardRows = [
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["ENTER", "Z", "X", "C", "V", "B", "N", "M", "⌫"]
    ]
    
    var body: some View {
        ZStack {
            HeavyFogBackground()
        VStack {
            VStack(spacing: 8) {
                ForEach(0..<6, id: \.self) { row in
                    HStack(spacing: 8) {
                        ForEach(0..<5, id: \.self) { Column in
                            let letter: String = {
                                if row < CurrentAttempt {
                                    let word = Guess[row]
                                    return Column < word.count ? String(Array(word)[Column]) : ""
                                } else if row == CurrentAttempt {
                                    return Column < CurrentGuess.count ? String(Array(CurrentGuess)[Column]) : ""
                                }
                                return ""
                            }()
                            
                            Text(letter)
                                .font(.title)
                                .bold()
                                .foregroundStyle(.white)
                                .frame(width: 50, height: 60)
                                .background(row < CurrentAttempt ? LetterColor(guess: Guess[row], index: Column) : EmptyLetter)
                                .cornerRadius(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                        }
                    }
                }
            }
            .padding(.vertical)
            .padding(.vertical)
            .padding(.vertical)
            
            VStack(spacing: 6) {
                ForEach(KeyboardRows, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { letter in
                            Button {
                                Input(letter)
                            } label: {
                                Text(letter)
                                    .font(.system(size: letter.count > 1 ? 12 : 18, weight: .bold))
                                    .frame(minWidth: letter.count > 1 ? 45 : 28, minHeight: 45)
                                    .background(UsedLetters[letter] ?? Gray)
                                    .foregroundStyle(.white)
                                    .cornerRadius(4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.white, lineWidth: 1)
                                    )
                            }
                            .buttonStyle(.plain)
                            .disabled(GameWon || GameOver)
                        }
                    }
                }
            }
            .padding(.bottom, 50)
        }
        .padding()
        .onAppear {
            DailyReset()
        }
        .alert("Invalid Landmark", isPresented: $InvalidLandmark) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("If this is a specific landmark you want to add to the game, please submit a suggestion in the feedback form.")
                .font(.caption)
        }
        .alert("Congratulations!", isPresented: $GameWon) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("You guessed the landmark correctly! You can view your stats in the dashboard.")
                .font(.caption)
        }
        .alert("Game Over", isPresented: $GameOver) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Try again tomorrow! The correct landmark was \"\(SecretWord)\".")
                .font(.caption)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    currentTab = .Dashboard
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundStyle(.white)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Wanderlust")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    InformationTab = 0
                    InfoView = true
                } label: {
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(.white)
                }
            }
        }
        .sheet(isPresented: $InfoView) {
            InfoScreen(InformationTab: $InformationTab)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
                .foregroundStyle(.white)
        }
    }
    }
    
    func DailyLandmark() -> String {
        let calendar = Calendar.current
        let day = calendar.ordinality(of: .day, in: .year, for: Date()) ?? 1
        let index = abs(day) % AvaliableLandmarks.count
        return AvaliableLandmarks[index]
    }
    
    func Submit() {
        let UppercasedGuess = CurrentGuess.uppercased()
        guard CurrentGuess.count == 5 else { return }
        
        guard AllowedLandmarks.contains(UppercasedGuess) else {
            InvalidLandmark = true
            return
        }
        
        Guess[CurrentAttempt] = UppercasedGuess
        UpdatedColors(for: UppercasedGuess)
        
        if UppercasedGuess == SecretWord.uppercased() {
            GamesPlayed += 1
            GamesWon += 1
            CurrentStreak += 1
            if CurrentStreak > HighestStreak {
                HighestStreak = CurrentStreak
            }
            GameWon = true
            LastPlayed = Today()
            if !DiscoveredLandmarks.contains(UppercasedGuess) {
                DiscoveredLandmarks.append(UppercasedGuess)
            }
            CurrentGuess = ""
        } else if CurrentAttempt == 5 {
            GameOver = true
            GamesPlayed += 1
            CurrentStreak = 0
            LastPlayed = Today()
            CurrentGuess = ""
        } else {
            CurrentAttempt += 1
            CurrentGuess = ""
        }
    }
    
    func Input(_ letters: String) {
        if letters == "ENTER" {
            Submit()
        } else if letters == "⌫" {
            if !CurrentGuess.isEmpty {
                CurrentGuess.removeLast()
            }
        } else if CurrentGuess.count < 5 {
            CurrentGuess.append(letters.uppercased())
        }
    }
    
    func LetterColor(guess: String, index: Int) -> Color {
        let Guessed = Array(guess)
        let SecretArray = Array(SecretWord.uppercased())
        guard index < Guessed.count, index < SecretArray.count else {
            return EmptyLetter
        }
        let letter = Guessed[index]
        if letter == SecretArray[index] {
            return CorrectLetter
        } else if SecretArray.contains(letter) {
            return MisplacedLetter
        } else {
            return WrongLetter
        }
    }
    
    func UpdatedColors(for guess: String) {
        for (i, char) in Array(guess).enumerated() {
            let letter = String(char)
            let color = LetterColor(guess: guess, index: i)
            if UsedLetters[letter] != CorrectLetter {
                UsedLetters[letter] = color
            }
        }
    }
    
    func Reset() {
        SecretWord = DailyLandmark().uppercased()
        CurrentGuess = ""
        Guess = Array(repeating: "", count: 6)
        CurrentAttempt = 0
        UsedLetters = [:]
        GameWon = false
        GameOver = false
    }
    
    func Today() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.string(from: Date())
    }
    
    func DailyReset() {
        SecretWord = DailyLandmark().uppercased()
        let currentDay = Today()
        if LastPlayed == currentDay {
            GameOver = true
        } else {
            Reset()
        }
    }
}
