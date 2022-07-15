//
//  Tip.swift
//  BabySafe
//
//  Created by Anghi Rodriguez on 25/06/22.
//

import FirebaseFirestoreSwift

struct Tip: Codable {
    @DocumentID var id: String?
    let title: String
    let description: String
    var likes: Int
}
