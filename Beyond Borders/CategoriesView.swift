import SwiftUI

struct CategoriesView: View {
    @Binding var numParticipants: Int
    @Binding var participants: [String]
    @Binding var numRounds: Int
    @Binding var turnDuration: Int
    var onHome: () -> Void
    
    @State private var isLanguagePresented = false
    @State private var isFoodPresented = false
    @State private var isCulturePresented = false
    @State private var isOffensivePresented = false
    
    let selectedCountry: Country
    
    var body: some View {
        
        NavigationStack {
            ZStack {
//                Color(.background)
                Color(.colorAzz)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Choose the Category!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(.colorDarkBlue))
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    Button(action: {
                        isLanguagePresented = true
                        
                    }) {
                        Text("Language")
                            .font(.title2)
                            .bold()
                            .frame(width: 350, height: 60)
                            .background(Color(.colorGreen))
                            .foregroundColor(Color(.white))
                            .cornerRadius(50)
                    }
                    .fullScreenCover(isPresented: $isLanguagePresented){
                        LanguageView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome, selectedCountry : selectedCountry)
                    }
                    
                    .padding()
                    
                    Button(action: {
//                        print("Settings Button tapped")
                        isFoodPresented = true
                        
                    }) {
                        Text("Food")
                            .font(.title2)
                            .bold()
                            .frame(width: 350, height: 60)
                            .background(Color(.colorYellow))
                            .foregroundColor(Color(.white))
                            .cornerRadius(50)
                    }
                    .fullScreenCover(isPresented: $isFoodPresented){
                        FoodView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome, selectedCountry : selectedCountry)
                    }
                    
                    .padding()
                    
                    Button(action: {
                        isCulturePresented = true
                        
                    }) {
                        Text("Culture")
                            .font(.title2)
                            .bold()
                            .frame(width: 350, height: 60)
                            .background(Color(.colorBlue))
                            .foregroundColor(Color(.white))
                            .cornerRadius(50)
                    }
                    .fullScreenCover(isPresented: $isCulturePresented){
                        CultureView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome, selectedCountry : selectedCountry)
                    }
                    
                    .padding()
                    
                    Button(action: {
                        isOffensivePresented = true
                        
                    }) {
                        Text("Offensive Rumors")
                            .font(.title2)
                            .bold()
                            .frame(width: 350, height: 60)
                            .background(Color(.colorRed))
                            .foregroundColor(Color(.white))
                            .cornerRadius(50)
                    }
                    .fullScreenCover(isPresented: $isOffensivePresented){
                        OffensiveView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome, selectedCountry : selectedCountry)
                    }
                    .padding()
                    Spacer()
                }
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(
            numParticipants: .constant(3),
            participants: .constant(["Alice", "Bob", "Charlie"]),
            numRounds: .constant(3),
            turnDuration: .constant(60),
            onHome: {},
            selectedCountry: Country(name: "Italy", flagImage: "flags_italy")
        )
    }
}


