//import SwiftUI
//import CoreData
//
//class CoreDataViewModel: ObservableObject{
//    
//    let container: NSPersistentContainer
//    @Published var savedEntities: [SixtySixEntity] = []
//    
//    init() {
//        container = NSPersistentContainer(name: "SixtySixDaysCoreData")
//        container.loadPersistentStores{(description, error) in
//            if let error = error {
//                print("ERROR LOADING CORE DATA. \(error)")
//            }
//        }
//        
//        fetchHabit()
//    }
//    func fetchHabit() {
//        let request = NSFetchRequest<SixtySixEntity>(entityName: "SixtySixEntity")
//        do{
//            savedEntities = try container.viewContext.fetch(request)
//        } catch let error {
//            print("Error fetching.\(error)")
//        }
//    }
//    
//    func addHabit(text: String) {
//        let newHabit = SixtySixEntity(context: container.viewContext)
//        newHabit.name = text
//        saveData()
//    }
//    
//    func saveData() {
//        do{
//            try container.viewContext.save()
//            fetchHabit()
//        } catch let error {
//            print("Error saving. \(error)")
//        }
//    }
//}
//    struct StoredHabit: View {
//        
//        @StateObject var ViewModel = CoreDataViewModel()
//        @State var textFieldHabit: String = ""
//        
//        var body: some View {
//            NavigationView{
//                VStack(spacing: 20) {
//                    TextField("Adicionar hábitos aqui", text: $textFieldHabit)
//                        .font(.headline)
//                        .frame(height: 55)
//                        .background(Color(.white))
//                        .cornerRadius(10)
//                        .padding(.horizontal)
//                    
//                    Button(action: {
//                        guard !textFieldHabit.isEmpty else {return}
//                        ViewModel.addHabit(text: textFieldHabit)
//                        textFieldHabit = ""
//                    }, label: {
//                        Text("Save")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .frame(height: 55)
//                            .frame(maxWidth: .infinity)
//                            .background(Color(.blue))
//                            .cornerRadius(10)
//                    })
//                        .padding(.horizontal)
////                    List {
////                        ForEach(ViewModel.savedEntities) { entity in
////                            Text(entity.name ?? "NO NAME")
////                        }
////                    }
//                }
//                .navigationTitle("Hábitos")
//            }
//        }
//    }
//    
//    struct StoredHabit_Previews: PreviewProvider {
//        static var previews: some View {
//            StoredHabit()
//        }
//    }
//
