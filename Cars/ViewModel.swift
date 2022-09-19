//
//  ViewModel.swift
//  Cars
//
//  Created by Rustam Safarov on 9/19/22.
//

import Foundation
import SwiftUI

struct Car: Hashable, Codable {
    let id: String
    let createdAt: String
    let manufacturer: String
    let model: String
    let color: String
    let img : String
}

class ViewModel : ObservableObject {
    
    @Published var cars: [Car] = []
    
    func fetch () {
        guard let url = URL(string: "https://63280ad65731f3db9962dc23.mockapi.io/api/v1/cars") else  {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data, error == nil  else {
                return
            }
            
            do {
                let cars  = try JSONDecoder().decode([Car].self, from: data)
                DispatchQueue.main.async {
                    self?.cars = cars
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
