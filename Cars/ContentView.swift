//
//  ContentView.swift
//  Cars
//
//  Created by Rustam Safarov on 9/19/22.
//

import SwiftUI

struct URLImage : View {
    
    let urlString : String
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiImage = UIImage(data: data)  {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 70)
                .background(Color.gray)
            
        } else {
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear {
                    fetchData()
                }
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data,_,_ in
            self.data = data
        }
        task.resume()
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach (viewModel.cars, id: \.self) { car in
                    HStack {
                        URLImage(urlString: car.img)
                        Text(car.model)
                            .bold()
                        
                    }
                    .padding(3)
                }
            }
        }
        .navigationTitle("Cars")
        .onAppear {
            viewModel.fetch()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
