//
//  RestaurantModel.swift
//  Nerde Yesem
//
//  Created by Berke Can Kandemir on 22.12.2020.
//

import Foundation

struct datatype: Identifiable {
    
    var id: String
    var name: String
    var webUrl: String
    var location: Type4
}

struct Type: Decodable {
    
    var nearby_restaurants: [Type1]
}

struct Type1: Decodable{
    
    var restaurant: Type2
}


struct Type2: Decodable {
    
    var id: String
    var name: String
    var url: String
    var location: Type4
}

struct Type4: Decodable {
    
    var latitude: String
    var longitude: String
}
