import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var todolistviewmodel : TodoListViewModel
    @State var selectedTab:BottomBarSelectedTab = .home

    var body: some View {
        NavigationView {
            VStack {
                List {
                                   ForEach(todolistviewmodel.tasks) { task in
                                       NavigationLink(destination: TaskDetailView(task: task)) {
                                           VStack(alignment: .leading){
                                               Text(task.title).font(.title2).bold()
                                               Text(task.description)
                                               Text("Due: \(task.dueDate, style: .date)")
                                           }
                                       }
                                   }
                                   .onDelete(perform: deleteTasks)
                               }
            }
            .navigationTitle("Dashboard ")
            .navigationBarItems(trailing:
                                    NavigationLink(destination: AddView(todo: Task(contact: ContactInfo(firstName: "name", lastName: "name")), todolistviewmodel: todolistviewmodel,selectedTab: $selectedTab)) {
                    Image(systemName: "plus")
                
                }
            )
            .onAppear(perform: {
                todolistviewmodel.loadTasks()
            })
        }
        .environmentObject(todolistviewmodel)
        .edgesIgnoringSafeArea(.all)
    }
    
    func deleteTasks(at offsets: IndexSet) {
        todolistviewmodel.removeTasks(at: offsets)
        }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
