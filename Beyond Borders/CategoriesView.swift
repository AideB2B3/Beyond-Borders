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
    
    let corners : CGFloat = 25
    
    var body: some View {
        
        NavigationStack {
            ZStack {
               Color(.beigeBack)
//                Color(red: 0.968, green: 1, blue: 0.96) 
                    .ignoresSafeArea()
                
                VStack {
                    Text("Choose the Category!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(.colorDarkBlue))
                        .padding(.top, 50)
                    
                    Image("Mascotte")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                    
                    Spacer()
                    
                    LazyVGrid(columns: columns, spacing: 25) {
                        
                        Button(action: {
                            isLanguagePresented = true
                            
                        }) {
                            Text("Language")
                                .font(.title2)
                                .bold()
                                .frame(width: 160, height: 160)
                                .background(Color(.white.opacity(0.5)))
                                .foregroundColor(Color(.colorDarkBlue))
                                .cornerRadius(corners)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: corners)
                                .stroke(Color(.colorLanguage), lineWidth: 2)
                        )
                        .fullScreenCover(isPresented: $isLanguagePresented){
                            LanguageView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome, selectedCountry : selectedCountry)
                        }
                        
//                        .padding()
                        
                        Button(action: {
                            isFoodPresented = true
                            
                        }) {
                            Text("Food")
                                .font(.title2)
                                .bold()
                                .frame(width: 160, height: 160)
                                .background(Color(.white.opacity(0.5)))
                                .foregroundColor(Color(.colorDarkBlue))
                                .cornerRadius(corners)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: corners)
                                .stroke(Color(.colorFood), lineWidth: 2)
                        )
                        .fullScreenCover(isPresented: $isFoodPresented){
                            FoodView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome, selectedCountry : selectedCountry)
                        }
                        
//                        .padding()
                        
                        Button(action: {
                            isCulturePresented = true
                            
                        }) {
                            Text("Culture")
                                .font(.title2)
                                .bold()
                                .frame(width: 160, height: 160)
                                .background(Color(.white.opacity(0.5)))
                                .foregroundColor(Color(.colorDarkBlue))
                                .cornerRadius(corners)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: corners)
                                .stroke(Color(.colorCulture), lineWidth: 2)
                        )
                        .fullScreenCover(isPresented: $isCulturePresented){
                            CultureView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome, selectedCountry : selectedCountry)
                        }
                        
//                        .padding()
                        
                        Button(action: {
                            isOffensivePresented = true
                            
                        }) {
                            Text("Rumors")
                                .font(.title2)
                                .bold()
                                .frame(width: 160, height: 160)
                                .background(Color(.white.opacity(0.5)))
                                .foregroundColor(Color(.colorDarkBlue))
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

                    }//EndLazy
                    .padding(.bottom, 50)
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


