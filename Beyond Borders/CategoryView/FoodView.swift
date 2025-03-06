import SwiftUI

struct FoodView: View {
    
    @Binding var participants: [String]
    @Binding var numParticipants: Int
    @Binding var numRounds: Int
    @Binding var turnDuration: Int
    
    var totalRounds: Int
    var timerDuration: Int
    var onHome: () -> Void
    
    @State private var remainingTime: Int
    @State private var currentTurn: Int = 0
    @State private var completedRounds: Int = 0
    @State private var timer: Timer?
    @State private var showEndScreen = false
    @State private var showTransitionScreen = false
    @State private var extraRound = false
    @State private var turnOrder: [[String]] = []
    
    let foodquestions: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V"]
    
    @State private var randomQuestion: String = ""
    @State private var showStart = true // Controlla la visibilità del pulsante Start
    @State private var showNo = false
    @State private var showYes = false
    @State private var showTimer = false
    
    private func getRandomQuestion() -> String {
        return foodquestions.randomElement() ?? "No questions available"
    }
    
    init(numParticipants: Binding<Int>, participants: Binding<[String]>, numRounds: Binding<Int>, turnDuration: Binding<Int>, totalRounds: Int, timerDuration: Int, onHome: @escaping () -> Void) {
        self._numParticipants = numParticipants
        self._participants = participants
        self._numRounds = numRounds
        self._turnDuration = turnDuration
        self.totalRounds = totalRounds
        self.timerDuration = timerDuration
        self.onHome = onHome
        self._remainingTime = State(initialValue: timerDuration)
        
        let initialQuestion = foodquestions.randomElement() ?? "No questions available"
        self._randomQuestion = State(initialValue: initialQuestion)
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 1.0, green: 0.647, blue: 0.274)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Food / China")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                        .padding(.top, 50)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color(red: 1.0, green: 0.945, blue: 0.816))
                            .frame(width: 350, height: 200)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 0.176, green: 0.188, blue: 0.278), lineWidth: 4)
                            )
                        
                        Text(randomQuestion)
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .frame(width: 320)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    
                    Spacer()
                    
                    if showStart {
                        Button(action: {
                            showStart = false // Nasconde il pulsante Start e mostra nuovi elementi
                        }) {
                            Text("Start")
                                .font(.title)
                                .padding()
                                .bold()
                                .frame(width: 130, height: 70)
                                .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                                .foregroundColor(.white)
                                .cornerRadius(30)
                        }
                        .padding()
                    } else {
                        // Qui puoi aggiungere il nuovo contenuto che comparirà dopo aver premuto Start
                        VStack(spacing: 20) {
                            
                            Spacer()
                            
                            if let currentParticipant = currentTurnSafe() {
                                Text("\(currentParticipant)")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                                
                                //                        Text("Round \(currentRound)")
                                //                            .font(.title3)
                                //                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                                //                            .bold()
                            }
                            else {
                                Text("Re open the app")
                            }
                            
                            
                            Spacer()
                            
                            if !showTimer{
                                Text("Do you agree?")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                                
                                
                                
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        showTimer = true // Nasconde il pulsante Start e mostra nuovi elementi
                                    })
                                    {
                                        Text("Yes")
                                            .font(.title)
                                            .padding()
                                            .bold()
                                            .frame(width: 130, height: 70)
                                            .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                                            .foregroundColor(.white)
                                            .cornerRadius(30)
                                    }
                                        Spacer()
                                        
                                        Button(action: {
                                            showTimer = true // Nasconde il pulsante Start e mostra nuovi elementi
                                        })
                                        {
                                            Text("No")
                                                .font(.title)
                                                .padding()
                                                .bold()
                                                .frame(width: 130, height: 70)
                                                .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                                                .foregroundColor(.white)
                                                .cornerRadius(30)
                                            
                                            
                                        }
                                    Spacer()
                                    
                                }
                                
                            }
                            
                        }
                        .transition(.opacity) // Effetto di transizione
                    }
                    
                }
                .padding(.bottom, 35)
                
                .onAppear {
                    // Ensure turn order is generated when view appears
                    if turnOrder.isEmpty {
                        generateTurnOrder()
                    }
                }
            }
        }// End Nav Stack
    }
    
    func currentTurnSafe() -> String? {
        guard !turnOrder.isEmpty,
              currentTurn / participants.count < turnOrder.count,
              currentTurn % participants.count < turnOrder[currentTurn / participants.count].count else {
            return nil
        }
        return turnOrder[currentTurn / participants.count][currentTurn % participants.count]
    }
    
    func generateTurnOrder() {
        turnOrder = []
        var lastParticipant = ""
        for _ in 0..<(extraRound ? 1 : totalRounds) {
            var order: [String]
            repeat {
                order = participants.shuffled()
            } while !turnOrder.isEmpty && order.first == lastParticipant
            
            lastParticipant = order.last ?? ""
            turnOrder.append(order)
        }
        
        // Debug print to verify turn order generation
        print("Generated Turn Order: \(turnOrder)")
    }
    
    
}


struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView(
            numParticipants: .constant(3),
            participants: .constant(["Alice", "Bob", "Charlie"]),
            numRounds: .constant(3),
            turnDuration: .constant(60),
            totalRounds: 3, // Aggiunto
            timerDuration: 60, // Aggiunto
            onHome: {}
        )
    }
}


