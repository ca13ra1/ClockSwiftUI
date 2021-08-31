//
//  CityCell.swift
//  CityCell
//
//  Created by cole cabral on 2021-08-27.
//

import SwiftUI

struct CityCell: View {
    let city: String
    let difference: String
    let time: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(city)
                    .font(.headline)
                Text(difference)
                    .foregroundColor(Color.secondary)
            }
            Spacer()
            Text(time)
                .font(.title)
        }
    }
}

struct CityCell_Previews: PreviewProvider {
    static var previews: some View {
        CityCell(city: "", difference: "", time: "")
    }
}
