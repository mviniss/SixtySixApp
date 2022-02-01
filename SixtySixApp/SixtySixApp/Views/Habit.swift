import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject{
    
    let container: NSPersistentContainer
    @Published var savedEntities: [SixtySixEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "SixtySixDaysCoreData")
        container.loadPersistentStores{(description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
        
        fetchHabit()
    }
    func fetchHabit() {
        let request = NSFetchRequest<SixtySixEntity>(entityName: "SixtySixEntity")
        do{
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching.\(error)")
        }
    }
    
    func addHabit(text: String) {
        let newHabit = SixtySixEntity(context: container.viewContext)
        newHabit.title = text
        newHabit.notes = text
        newHabit.shouldSendAlert = false
        newHabit.startDate = Date()
        saveData()
    }
    
    func saveData() {
        do{
            try container.viewContext.save()
            fetchHabit()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}
struct Model: Identifiable {
    let id = UUID().uuidString
    let title: String
}

struct Habit: View {
    
    @AppStorage("onboardingAppears") var onboardingAppears: Bool = true
    
    @StateObject var ViewModel = CoreDataViewModel()
    @State var selectedModel: Model = Model(title: "STARTING TITLE")
    @State var showSheet: Bool = false
    var body: some View {
        VStack (spacing: 20){
            Spacer()
            List {
                ForEach(ViewModel.savedEntities) { entity in
                    Text(entity.title ?? "NO NAME")
                }
            }
            Button("Criar novo hábito") {
                selectedModel = Model(title: "ONE")
                showSheet.toggle()
            }
            .fullScreenCover(isPresented: $onboardingAppears, content: {OnboardingView(onboardingAppears: $onboardingAppears)
            })
        }
        .sheet(isPresented: $showSheet, content: {
            NewHabitScreen(selectedModel: $selectedModel)
        })
    }
}

struct NewHabitScreen: View {
    @State private var title = ""
    @State private var startDate = Date()
    @State private var notes = ""
    @State private var shouldSendAlert = false
    @Binding var selectedModel: Model
    @StateObject var ViewModel = CoreDataViewModel()
    @State var textFieldHabit: String = ""
    
    var body: some View {
        ZStack {
            Spacer()
            Form {
                Section{
                    TextField("Título", text: $title)
                }
                Section{
                    DatePicker("Começa", selection: $startDate)
                }
                Section{
                    Toggle("Alerta", isOn: $shouldSendAlert)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
                Section{
                    TextField("Notas", text: $notes)
                        .frame(width: 374, height: 240, alignment: .topLeading)
                }
                Button(action: {
                    guard !title.isEmpty else {return}
                    ViewModel.addHabit(text: title)
                    title = ""
                    notes = ""
                }, label: {
                    Text("Salvar")
                })
            }
            
        }
    }
}

struct Habit_Previews: PreviewProvider {
    static var previews: some View {
        Habit()
    }
}
