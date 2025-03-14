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
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let corners : CGFloat = 10
    
    var body: some View {
        
        NavigationStack {
            ZStack {
//                Color(.background)
                Color(.beigeBack)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Choose the Category!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(.colorWritten))
                        .padding(.top, -150)
                    
                    
                    LazyVGrid(columns: columns, spacing: 5) {
                        
                        Button(action: {
                            //                        print("Settings Button tapped")
                            isLanguagePresented = true
                            
                        }) {
                            Text("Language")
                                .font(.title2)
                                .bold()
                                .frame(width: 170, height: 140)
                                .background(Color(.white.opacity(0.5)))
                                .foregroundColor(Color(.colorWritten))
                                .cornerRadius(corners)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: corners)
                                .stroke(Color(.colorLanguage), lineWidth: 2)
                        )
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
                                .frame(width: 170, height: 140)
                                .background(Color(.white.opacity(0.5)))
                                .foregroundColor(Color(.colorWritten))
                                .cornerRadius(corners)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: corners)
                                .stroke(Color(.colorFood), lineWidth: 2)
                        )
                        .fullScreenCover(isPresented: $isFoodPresented){
                            FoodView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome, selectedCountry : selectedCountry)
                        }
                        
                        .padding()
                        
                        Button(action: {
                            //                        print("Settings Button tapped")
                            isCulturePresented = true
                            
                        }) {
                            Text("Culture")
                                .font(.title2)
                                .bold()
                                .frame(width: 170, height: 140)
                                .background(Color(.white.opacity(0.5)))
                                .foregroundColor(Color(.colorWritten))
                                .cornerRadius(corners)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: corners)
                                .stroke(Color(.colorCulture), lineWidth: 2)
                        )
                        .fullScreenCover(isPresented: $isCulturePresented){
                            CultureView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome, selectedCountry : selectedCountry)
                        }
                        
                        .padding()
                        
                        Button(action: {
                            //                        print("Settings Button tapped")
                            isOffensivePresented = true
                            
                        }) {
                            Text("Offensive Rumors")
                                .font(.title2)
                                .bold()
                                .frame(width: 170, height: 140)
                                .background(Color(.white.opacity(0.5)))
                                .foregroundColor(Color(.colorWritten))
                                .cornerRadius(corners)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: corners)
                                .stroke(Color(.colorOffensive), lineWidth: 2)
                        )
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


