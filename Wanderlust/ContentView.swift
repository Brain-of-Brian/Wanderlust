import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            GuessingGame()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct GuessingGame: View {
    @State private var SecretWord: String = "PETRA" // test landmark
    @State private var guess: [String] = Array(repeating: "", count: 6)
    @State private var GameWon: Bool = false
    @State private var GameOver: Bool = false
    @State private var CurrentGuess: String = ""
    @State private var CurrentAttempt: Int = 0
    @State private var UsedLetters: [String: Color] = [:]
    
    let CorrectLetter: Color = Color(red: 0.1, green: 0.35, blue: 0.2)
    let MisplacedLetter: Color = Color(red: 0.6, green: 0.5, blue: 0.1)
    let WrongLetter: Color = Color(red: 0.35, green: 0.25, blue: 0.15)
    let EmptyLetter = Color.gray
    let Gray = Color.gray.opacity(0.5)
    let KeyboardRows = [
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["ENTER", "Z", "X", "C", "V", "B", "N", "M", "DELETE"]
    ]
    
    var body: some View {
        VStack {
            Text("Guess the landmark")
                .font(.title)
            VStack {
                ForEach(0..<6, id: \.self){ Row in
                    HStack {
                        ForEach(0..<5, id: \.self){ Column in
                            let letter = GetLetterColor(for: Row, and: Column)
                            let BackgroundColor = GetTileColor(for: Row, at: Column)
                            
                            Text(letter)
                                .frame(width: 50, height: 60)
                                .background(BackgroundColor)
                                .foregroundStyle(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding(.vertical)
            
            Spacer()
            
            if !GameOver {
                Text(GameWon ? "You guessed the landmark correctly!" : "Try again tomorrow!")
            }
            VStack {
                ForEach(KeyboardRows, id: \.self){ row in
                    HStack {
                        ForEach(row, id: \.self){ key in
                            Button {
                                handleKeyPress(key)
                            } label: {
                                Text(key)
                                    .font(.system(size: key.count > 1 ? 12 : 16, weight: .bold))
                                    .frame(maxWidth: key.count > 1 ? 55 : 32, minHeight: 45)
                                    .foregroundStyle(.white)
                                    .cornerRadius(5)
                                
                            }
                            .disabled(GameOver)
                        }
                        
                    }
                }
            }
            .padding(.bottom, 10)
            
        }
        .padding()
        .onAppear{
            SetupDaily()
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
        if row >= CurrentAttempt && (row != CurrentAttempt || CurrentGuess.count <= column) {
            return EmptyLetter
        }
        let word = (row == CurrentAttempt) ? CurrentGuess : guess[row]
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
            return .gray
        }
        return UsedLetters[key] ?? Gray
    }
    func handleKeyPress(_ key: String) {
        if key == "ENTER" {
            SubmitGuess()
        }
        else if key == "BACKSPACE" {
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
        let landmarks: [String] = ["Eiffel Tower", "Great Wall of China", "Petra", "Machu Picchu", "Christ the Redeemer"]
        var calender = Calendar.current
        if let timezone = TimeZone(identifier: "America/Chicago"){
            calender.timeZone = timezone
        }
        
        let DayOfYear = calender.ordinality(of: .day, in: .year, for: Date()) ?? 1
        let index = DayOfYear % landmarks.count
        SecretWord = landmarks[index]
    }
    func Stats(won: Bool) {
        
    }
}
#Preview {
    GuessingGame()
}
