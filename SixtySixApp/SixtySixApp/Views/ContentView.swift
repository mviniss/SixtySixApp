import SwiftUI

//HomeScreen

struct ContentView: View {
    @AppStorage("onboardingAppears") var onboardingAppears: Bool = true
    var body: some View {
        NavigationView {
            VStack {
                Text("Main screen")
            }
            .navigationTitle("Meus hábitos")
        }
        .fullScreenCover(isPresented: $onboardingAppears, content: {
            OnboardingView(onboardingAppears: $onboardingAppears)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
