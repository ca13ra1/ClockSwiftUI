//
//  CityList.swift
//  CityList
//
//  Created by cole cabral on 2021-08-29.
//

import SwiftUI
import CoreData

struct CityList: View {
    var viewContext: NSManagedObjectContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)], animation: .default)
    private var timezone: FetchedResults<Timezone>
    @State private var showingSheet = false
    var body: some View {
        NavigationView {
            TimelineView(.everyMinute) { context in
                List {
                    ForEach(timezone, id: \.self) { item in
                        CityCell(city: item.city!.cityname(), difference: TimeZone.current.identifier.difference(item.city!, context.date), time: item.city!.timezone(context.date))
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            viewContext.delete(timezone[index])
                        }
                        try? viewContext.save()
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarItems(leading:EditButton(), trailing: Button(action: {
                self.showingSheet.toggle()
            }, label: {
                Text(Image(systemName: "plus"))
                    .font(.headline)
            }))
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingSheet) {
                CityView()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
}

struct CityList_Previews: PreviewProvider {
    static var previews: some View {
        CityList(viewContext: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
    }
}
