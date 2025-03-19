import SwiftUI

struct TransitionScreen: View {
    
    var nextParticipant: String
    var onTap: () -> Void
    var backgroundColor: Color
    
    var body: some View {
        VStack {
            Text("Next turn:\n\(nextParticipant)")
                .font(.custom("Atma-Bold", fixedSize: 40))
                .foregroundColor(Color(.colorWritten))
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Tap to Start the Turn")
                .font(.custom("Atma-SemiBold", fixedSize: 30))
                .foregroundColor(Color(.colorWritten))
            
            Image(systemName: "hand.tap.fill")
                .font(.custom("Atma-SemiBold", fixedSize: 40))
                .padding(.top, 10)
                .foregroundColor(Color(.colorWritten))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
        .onTapGesture {
            onTap()
        }
    }
}

struct TransitionScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransitionScreen(
            nextParticipant: "Alice",
            onTap: {},
            backgroundColor: Color(.beigeBack)
        )
    }
}
