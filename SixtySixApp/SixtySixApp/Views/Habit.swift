import SwiftUI

struct Habit: View {
    
    @AppStorage("onboardingAppears") var onboardingAppears: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: NewHabit(), label: {
                    Text("Criar novo hábito")
                })
                
            }
            .navigationTitle("Meus hábitos")
//            .toolbar{
//                ToolbarItemGroup(placement: .navigationBarTrailing){
//                    Button{
//                    } label: {
//                        Label("Criar hábito", systemImage: "plus")
//                    }
//                }
//            }
        }
        .fullScreenCover(isPresented: $onboardingAppears, content: {OnboardingView(onboardingAppears: $onboardingAppears)
        })
    }
    
    
    struct Habit_Previews: PreviewProvider {
        static var previews: some View {
            Habit()
        }
    }
}
