import SwiftUI

struct Habit: View {
    
    @AppStorage("onboardingAppears") var onboardingAppears: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                
                    .fullScreenCover(isPresented: $onboardingAppears, content: {OnboardingView(onboardingAppears: $onboardingAppears)
                })
            }
            .navigationTitle("Meus hábitos")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button{
                } label: {
                    Label("Criar hábito", systemImage: "plus")
                    }
            }
        }
    }
}

struct Habit_Previews: PreviewProvider {
    static var previews: some View {
        Habit()
        }
    }
}
