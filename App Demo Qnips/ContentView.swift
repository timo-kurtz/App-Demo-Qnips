//
//  ContentView.swift
//  App Demo Qnips
//
//  Created by Timo Kurtz on 11.04.23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var network: Network?
    @State private var ProductIds: [ProductId]?
    @State private var weekDays = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
    @State private var missingWeekDays = [Int()]
    @State private var categoryTitles = [String]()
    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    ForEach(Array(weekDays.enumerated()), id: \.1) { index, item in
                        WeekDayView(name: weekDays[index], date: "22.02.2016", product: network?.Products[String(ProductIds?[index].ProductId ?? 0)] ?? Product(AllergenIds: [], ProductId: 0, Name: "", Price: ["" : 0]), network: network, title: categoryTitles)
//                        WeekDayView(name: weekDays[index], date: "22.02.2016", product: Product(AllergenIds: ["1, 11, 9"], ProductId: 2, Name: "Asia", Price: ["Betrag" : 6.9]), network: network)
                    }
                        
                        
                        
                    
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            .navigationBarTitle("KW 8")
            .onAppear {
                fetch()
                // Perform setup tasks here
            }
        }
    }
    
    
    private func fetch() {
        if let url = URL(string: "https://myprelive.qnips.com/dbapi/ha") {
          let session = URLSession.shared
          let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
              print("Error: \(error)")
              return
            }

            if let response = response as? HTTPURLResponse {
              if response.statusCode != 200 {
                print("Invalid response: \(response.statusCode)")
                return
              }
            }

            if let data = data {
              // Parse the response data here
                if let jsonString = String(data: data, encoding: .utf8) {
//                  print(jsonString)
                    let jsonData = jsonString.data(using: .utf8)!
                        let decoder = JSONDecoder()
                    network = try! decoder.decode(Network.self, from: jsonData)
                    getWeeks()
                } else {
                  print("Failed to convert data to string")
                }
            }
          }

          task.resume()
        }
    }
    
    private func getWeeks() {
        guard let rows = network?.Rows else {return }
        var numbWeeks = [Int]()
        for row in rows {
            categoryTitles.append(row.Name)
            for day in row.Days {
                for ProductId in day.ProductIds {
                    if ProductIds == nil {
                        ProductIds = [ProductId]
                    }
                    ProductIds?.append(ProductId)
                }
                numbWeeks.append(day.Weekday)
            }
        }

        missingWeekDays = (0...6).filter { !numbWeeks.contains($0) }

        if missingWeekDays.isEmpty {
            print("All numbers are present")
        } else {
            for missingNumber in missingWeekDays {
                print(missingNumber)
                weekDays[missingNumber] = "Heute geschlossen"
//                weekDays.remove(at: missingNumber)
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
