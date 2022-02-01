import SwiftUI

struct UserModel: Identifiable {
    let id: String = UUID().uuidString
    let displayName: String
    let userName: String
    let followerCount: Int
    let isVerified: Bool
}

struct CreatedHabit: View {
    
    @State var habit: [UserModel] = [UserModel(displayName: "Aprender programação", userName: "marcus.sousa", followerCount: 100, isVerified: false)]
    
    var body: some View {
        NavigationView {
            List{
                ForEach(habit) { habit in
                    HStack (spacing: 15.0) {
                        Circle()
                            .frame(width: 35, height: 35)
                        VStack(alignment: .leading) {
                            Text(habit.displayName)
                            Text("@\(habit.userName)")
                            foregroundColor(.gray)
                                .font(.caption)
                        }
                        Spacer()
                        
                        if habit.isVerified{
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.blue)
                        }
                        VStack{
                            Text("\(habit.followerCount)")
                                .font(.headline)
                            Text("Followers")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Meus hábitos", displayMode: .inline)
        }
    }
}
struct CreatedHabit_Previews: PreviewProvider {
    static var previews: some View {
        CreatedHabit()
    }
}
