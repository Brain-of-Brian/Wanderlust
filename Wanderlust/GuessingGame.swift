import SwiftUI

// finder guessing game
struct GuessingGame: View {
    @State private var SecretWord: String = "PETRA" // test landmark
    @State private var guess: [String] = Array(repeating: "", count: 6)
    @State private var GameWon: Bool = false
    @State private var GameOver: Bool = false
    @State private var CurrentGuess: String = ""
    @State private var CurrentAttempt: Int = 0
    @State private var UsedLetters: [String: Color] = [:]
    
    @State private var InvalidLandmark: Bool = false
    @State private var AvaliableLandmarks: [String] = ["PETRA", "LUXOR", "TULUM", "TOKYO", "ALAMO"]
    @Binding var currentTab: Tabs
    
    @State private var InfoPopup: Bool = false
    @State private var MapPopup: Bool = false
    @Binding var InfoTab: Int
    
    @AppStorage("GamesPlayed") private var GamesPlayed: Int = 0
    @AppStorage("GamesWon") private var GamesWon: Int = 0
    @AppStorage("Streak") private var Streak: Int = 0
    @AppStorage("HighestStreak") private var HighestStreak: Int = 0
    
    
    
    @Binding var DiscoveredLandmarks: [String]
    
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
        VStack {
            VStack(spacing: 8) {
                ForEach(0..<6, id: \.self){ Row in
                    HStack(spacing: 8) {
                        ForEach(0..<5, id: \.self){ Column in
                            let letter = GetLetterColor(for: Row, and: Column)
                            let BackgroundColor = GetTileColor(for: Row, at: Column)
                            
                            Text(letter)
                                .font(.title)
                                .bold()
                                .foregroundStyle(.black)
                                .frame(width: 50, height: 60)
                                .background(BackgroundColor)
                                .cornerRadius(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                        }
                    }
                }
            }
            .padding(.vertical)
            
            Spacer()
            
            VStack(spacing: 6) {
                ForEach(KeyboardRows, id: \.self){ row in
                    HStack {
                        ForEach(row, id: \.self){ key in
                            Button {
                                handleKeyPress(key)
                            } label: {
                                Text(key)
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                    .bold()
                                    .frame(minWidth: key.count > 1 ? 45 : 28, minHeight: 45)
                                    .background(GetKeyColor(for: key))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                                    .cornerRadius(4)
                            }
                            .buttonStyle(.plain)
                            .disabled(GameOver)
                        }
                    }
                }
            }
            .padding(.bottom, 50)
        }
        .padding()
        .onAppear{
            SetupDaily()
        }
        .alert(isPresented: $GameOver) {
            Alert(
                title: Text(GameWon ? "You Win!" : "Game Over"),
                message: Text(GameWon ? "You guessed the landmark correctly!" : "Try again tomorrow!"),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(isPresented: $InvalidLandmark) {
            Alert(
                title: Text("Invalid Landmark"),
                message: Text("If this is a specific landmark you want to add to the game, please submit a suggestion in the feedback form.")
                    .font(.caption),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    currentTab = .Dashboard
                } label: {
                    Image(systemName: "house")
                        .foregroundStyle(.black)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Wanderlust")
                    .font(.title2)
                    .bold()
            }
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button {
                        MapPopup = true
                    } label: {
                        Image(systemName: "map.fill")
                            .foregroundStyle(.black)
                    }
                    Button {
                        InfoTab = 0
                        InfoPopup = true
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .padding(.vertical)
        .sheet(isPresented: $InfoPopup) {
            InfoPopupView(InfoTab: $InfoTab)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $MapPopup) {
            MapPopupView(DiscoveredLandmarks: $DiscoveredLandmarks)
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
            
        }
    }
    func GetLetterColor(for row: Int, and column: Int) -> String {
        let word = (row == CurrentAttempt) ? CurrentGuess : guess[row]
        let index = word.index(word.startIndex, offsetBy: column, limitedBy: word.endIndex)
        if let index = index, column < word.count {
            return String(word[index])
        }
        return ""
    }
    
    func GetTileColor(for row: Int, at column: Int) -> Color {
        let Submitted = row < CurrentAttempt || (row == CurrentAttempt && GameOver)
        guard Submitted else {
            return EmptyLetter
        }
        let word = (row == CurrentAttempt && GameOver) ? CurrentGuess : guess[row]
        guard column < word.count else {
            return EmptyLetter
        }
        
        let index = word.index(word.startIndex, offsetBy: column)
        let letter = String(word[index])
        let SecretArray = Array(SecretWord)
        let GuessArray = Array(word)
        
        if SecretArray[column] == GuessArray[column] {
            return CorrectLetter
        }
        
        if SecretArray.contains(Character(letter)) {
            return MisplacedLetter
        }
        return WrongLetter
    }
    func GetKeyColor(for key: String) -> Color {
        if key.count > 1 {
            return Gray
        }
        return UsedLetters[key] ?? Gray
    }
    
    func handleKeyPress(_ key: String) {
        if key == "ENTER" {
            SubmitGuess()
        }
        else if key == "⌫" {
            if !CurrentGuess.isEmpty {
                CurrentGuess.removeLast()
            }
        }
        else {
            if CurrentGuess.count < 5 {
                CurrentGuess.append(key.uppercased())
            }
        }
    }
    
    func SubmitGuess() {
        guard CurrentGuess.count == 5 else {
            return
        }
        
        guard AvaliableLandmarks.contains(CurrentGuess) else {
            InvalidLandmark = true
            return
        }
        
        if !DiscoveredLandmarks.contains(CurrentGuess) {
            DiscoveredLandmarks.append(CurrentGuess)
        }
        for (column,letter) in CurrentGuess.enumerated() {
            let lettersArray = String(letter)
            let secretArray = Array(SecretWord)
            
            if secretArray[column] == letter {
                UsedLetters[lettersArray] = CorrectLetter
            }
            else if secretArray.contains(letter){
                if UsedLetters[lettersArray] != CorrectLetter {
                    UsedLetters[lettersArray] = MisplacedLetter
                }
            }
            else {
                if UsedLetters[lettersArray] == nil {
                    UsedLetters[lettersArray] = WrongLetter
                }
            }
        }
        guess[CurrentAttempt] = CurrentGuess
        
        if CurrentGuess == SecretWord {
            GameWon = true
            GameOver = true
            Stats(won: true)
        }
        else if CurrentAttempt == 5 {
            GameOver = true
            Stats(won: false)
        }
        else {
            CurrentAttempt += 1
            CurrentGuess = ""
        }
    }
    
    func SetupDaily() {
        let landmarks: [String] = ["PETRA", "ALAMO", "LUXOR", "KYOTO", "TULUM"]
        var calender = Calendar.current
        if let timezone = TimeZone(identifier: "America/Chicago"){
            calender.timeZone = timezone
        }
        
        let DayOfYear = calender.ordinality(of: .day, in: .year, for: Date()) ?? 1
        let index = DayOfYear % landmarks.count
        SecretWord = landmarks[index]
    }
    
    func Stats(won: Bool) {
        GamesPlayed += 1
        if won {
            GamesWon += 1
            Streak += 1
            if Streak > HighestStreak {
                HighestStreak = Streak
            }
        }
        else {
            Streak = 0
        }
    }
}

#Preview {
    GuessingGame(currentTab: .constant(.Game), InfoTab: .constant(0), DiscoveredLandmarks: .constant([]))
}
