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
    
    @State private var sideViews: [SideView]?
    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    ForEach(sideViews ?? [], id: \.weekDay) { view in
                        WeekDayView(data: view)
                        
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("KW 8")
        }
        
        .onAppear {
            fetch()
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
                    let jsonData = jsonString.data(using: .utf8)!
                        let decoder = JSONDecoder()
                    network = try! decoder.decode(Network.self, from: jsonData)
                    prepareData()
                } else {
                  print("Failed to convert data to string")
                }
            }
          }

          task.resume()
        }
    }
    
    private func prepareData() {
        guard let network = network else { return }
        sideViews = [SideView]()
        var categories = [Category]()
        for i in 0..<7 {
            for row in network.Rows {
                var productIds = [Int]()
                
                for day in row.Days {
                    if (day.Weekday == i) {
                        for id in day.ProductIds {
                            productIds.append(id.ProductId)
                        }
                    }
                }
                categories.append(Category(name: row.Name, ProductIds: productIds))
            }
            sideViews?.append(SideView(weekDay: i, categories: categories, products: network.Products, allergens: network.Allergens))
            categories = [Category]()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
