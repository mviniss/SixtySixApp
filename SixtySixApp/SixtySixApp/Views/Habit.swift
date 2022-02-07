import SwiftUI
import CoreData
import UserNotifications
import CoreLocation

//Notificações

class NotificationManager {
    static let instance = NotificationManager() //Isso é um singleton
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error{
                print("ERROR:\(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    func scheduleNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification"
        content.subtitle = "This is so easy"
        content.sound = .default
        content.badge = 1
        
        let coordinates = CLLocationCoordinate2D (
            latitude: 40.00, longitude: 50.00)
        
        let region = CLCircularRegion(center: coordinates,
                                      radius: 100,
                                      identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        let trigger = UNLocationNotificationTrigger (region: region, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

//CoreData

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
    
    func deleteHabit(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
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

//Habit

struct Habit: View {
    
    @AppStorage("onboardingAppears") var onboardingAppears: Bool = true
    
    @StateObject var ViewModel = CoreDataViewModel()
    @State var selectedModel: Model = Model(title: "STARTING TITLE")
    @State var showSheet: Bool = false
    var body: some View {
        NavigationView {
            VStack (spacing: 20){
                List {
                    ForEach(ViewModel.savedEntities) { entity in
                        Text(entity.title ?? "NO NAME")
                    }
                    .onDelete(perform: ViewModel.deleteHabit)
                }
                .onAppear {
                    ViewModel.fetchHabit()
                }
                Button("Criar novo hábito".localized()) {
                    selectedModel = Model(title: "ONE")
                    showSheet.toggle()
                }
                .fullScreenCover(isPresented: $onboardingAppears, content: {OnboardingView(onboardingAppears: $onboardingAppears)
                })
            }
            .sheet(isPresented: $showSheet, content: {
                NewHabitScreen(selectedModel: $selectedModel, ViewModel: ViewModel)
            })
            .navigationTitle("Meus hábitos".localized())
        }
    }
}

//NewHabitScreen

struct NewHabitScreen: View {
    
    @State private var title = ""
    @State private var startDate = Date()
    @State private var notes = ""
    @State private var shouldSendAlert = false
    @Binding var selectedModel: Model
    var ViewModel: CoreDataViewModel
    @State var textFieldHabit: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section{
                        TextField("Título".localized(), text: $title)
                    }
                    Section{
                        DatePicker("Começa".localized(), selection: $startDate)
                    }
                    Section{
                        Button("Permitir notificações".localized()) {
                            NotificationManager.instance.requestAuthorization()
                        }
                    }
                    Section{
                        TextField("Notas".localized(), text: $notes)
                            .frame(width: 374, height: 240, alignment: .topLeading)
                    }
                    Button(action: {
                        guard !title.isEmpty else {return}
                        ViewModel.addHabit(text: title)
                        title = ""
                        notes = ""
                        dismiss()
                    }, label: {
                        Text("Salvar".localized())
                    })
                }
            }
            .onAppear{
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
            .navigationBarTitle("Criar hábito".localized(), displayMode: .inline)
        }
    }
}

struct Habit_Previews: PreviewProvider {
    static var previews: some View {
        Habit()
    }
}
