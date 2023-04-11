//
//  WeekDayView.swift
//  App Demo Qnips
//
//  Created by Timo Kurtz on 11.04.23.
//

import SwiftUI

struct WeekDayView: View {
    
    let name: String
    let date: String
    let product: Product
    let network: Network?
    let title: [String]

    var body: some View {
        VStack {
            
            
            if name != "Heute geschlossen" {
                
                Text(name)
                    .font(.title)
                Text(date)
                    .font(.callout)
                List(Array(title.enumerated()), id: \.1) { index, action in
                    Text(title[index])
                        .font(.title2)
                        Text(product.Name)
                        Text(getAllergens(ids: product.AllergenIds))
                        Text("\(String(product.Price["Betrag"] ?? 0)) $")
                    Spacer()
                }
            } else {
                Text(name)
                    .font(.title)
                Text(date)
                    .font(.callout)
                
                Spacer()
            }
            
            
            
        }
        
    }
    private func getAllergens(ids: [String]) -> String {
        var result = ""
        for id in ids {
            result += id
        }
        return result
    }
}

struct WeekDayView_Previews: PreviewProvider {
    static var previews: some View {
        
        WeekDayView(name: "Montag", date: "22.02.2016", product: Product(AllergenIds: ["1, 11, 9"], ProductId: 2, Name: "Asia", Price: ["Betrag" : 6.9]), network: nil, title: ["Aktion_1", "Aktion_2", "Salatbar"])
    }
}
