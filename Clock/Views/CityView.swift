//
//  CityView.swift
//  CountryCodesList
//
//  Created by cole cabral on 2021-08-17.
//

import SwiftUI
import CoreData

struct CityView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [], animation: .default)
    private var timezone: FetchedResults<Timezone>
    @State var timezones: [String] = []
    @State var search = ""
    @State var commit = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("Search", text: $search)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: { presentationMode.wrappedValue.dismiss() }, label: { Text("Cancel")})
            }
            .padding(.top, 10)
            .padding(.all, 10)
            
            List {
                ForEach(timezones.filter({ search.isEmpty ? true : $0.cityname().contains(search) }), id: \.self) { city in
                    if search.containscharacters(city.cityname()) {
                        HStack {
                            Text(city.countryname())
                            Spacer()
                            Button {
                                addCity(city)
                            } label: {
                                HStack(alignment: .center) {
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(6)
                            .background(Color.blue)
                            .cornerRadius(6)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear() {
            knowntimezones()
        }
    }

    func knowntimezones() {
        let knowntimezoneidentifiers = TimeZone.knownTimeZoneIdentifiers
        for timezone in knowntimezoneidentifiers {
            timezones.append(timezone)
        }
    }

    func addCity(_ city: String) {
        let fetchrequest: NSFetchRequest<Timezone> = Timezone.fetchRequest()
        fetchrequest.predicate = NSPredicate(format: "city = %@", city)
        do {
            let timezones = try viewContext.fetch(fetchrequest)
            if !timezones.isEmpty {
                presentationMode.wrappedValue.dismiss()
            } else {
                let timezone = Timezone(context: viewContext)
                timezone.city = city
                timezone.date = Date()
                try? viewContext.save()
                presentationMode.wrappedValue.dismiss()
            }
        } catch {
            print("error")
        }
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView()
    }
}
