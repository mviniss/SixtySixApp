import SwiftUI

//HomeScreen

struct ContentView: View {
    //@AppStorage é o que assegura que o Onboarding será chamado apenas uma única vez. Uma vez que o Botão "Começar" é pressionado, a função toggle na variável onboardingAppears, dentro da declaração Button presente no arquivo onboarding, armazena que o onboarding foi finalizado e ele não é mais chamado quando o usuário começa a usar o aplicativo
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
