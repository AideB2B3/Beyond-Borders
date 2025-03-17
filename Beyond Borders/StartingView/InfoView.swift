import SwiftUI

struct InfoView: View {
    var body: some View {
        ZStack{
            Color(.beigeBack)
                .ignoresSafeArea()
            
            Image("rules")
                .resizable()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    InfoView()
}
