//
//  WeekDayView.swift
//  App Demo Qnips
//
//  Created by Timo Kurtz on 11.04.23.
//

import SwiftUI

struct WeekDayView: View {
    
    let data: SideView
    
    let weekDays = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
    
    var body: some View {
        VStack {
            Spacer()
            Text(weekDays[data.weekDay])
                .bold()
                .font(.largeTitle)
            Spacer()
            List(Array(data.categories.enumerated()), id: \.1) { index, category in
                Text(category.name)
                    .font(.title)
                    .bold()
                ForEach(Array(category.ProductIds.enumerated()), id: \.1) { index, id in
                        Text(data.products[String(id)]?.Name ?? "")
                            .bold()
                        Text("\(String(format: "%.2f", (data.products[String(id)]?.Price["Betrag"] ?? 0))) €")
                        .font(.caption)
                        .padding(.leading)
                        Text(allergens(ids: data.products[String(id)]?.AllergenIds))
                        .font(.caption)
                        .padding(.leading)
                        .padding(.bottom)
                }
                if category.ProductIds.isEmpty {
                    Text("Ausverkauft")
                        .font(.caption)
                        .foregroundColor(.pink)
                        .padding(.leading)
                }
            }
        }
    }
    private func allergens(ids: [String]?) -> String {
        guard let allergensIds = ids else { return "" }
        
        var result = [String]()
        for id in allergensIds {
            result.append(data.allergens[id]?.Label ?? "")
        }
        return result.joined(separator: ", ")
    }
}

struct WeekDayView_Previews: PreviewProvider {
    static var previews: some View {
        
        WeekDayView(data: SideView(weekDay: 0,
                                   categories: [
                                    Category(name: "Vorspeise", ProductIds: [0, 2]),
                                    Category(name: "Mittag", ProductIds: [1])
                                               ],
                                   products: [
                                    "0" : Product(AllergenIds: ["0_", "0_2"], ProductId: 0, Name: "Apfel",Price: ["Betrag" : 3.5]),
                                    "1" : Product(AllergenIds: ["0_1"], ProductId: 1, Name: "Birne",Price: ["Betrag" : 3.5]),
                                    "2" : Product(AllergenIds: ["0_1"], ProductId: 2, Name: "Olive",Price: ["Betrag" : 3.5])
                                   ], allergens: [
                                    "0_" : AllergensLabel(Id: "0_", Label: "Glüden"),
                                    "0_1" : AllergensLabel(Id: "0_1", Label: "A2"),
                                    "0_2" : AllergensLabel(Id: "0_2", Label: "A3"),
                                    "1_" : AllergensLabel(Id: "1_", Label: "K"),
                                   ]
                      ))
    }
}
