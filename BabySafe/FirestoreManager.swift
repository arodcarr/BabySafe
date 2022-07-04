//
//  FirestoreManager.swift
//  BabySafe
//
//  Created by Anghi Rodriguez on 3/07/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class FirestoreManager {
    
    static func fetchTips(completion: @escaping (([Tip]) -> Void)){
        var tips: [Tip] = []
        let database = Firestore.firestore()
        database.collection("tips").getDocuments { response, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in response!.documents {
                    do {
                        let tip = try document.data(as: Tip.self)
                        tips.append(tip)
                    }
                    catch {
                        print(error)
                    }
                    print("\(document.documentID) => \(document.data())")
                }
                completion(tips)
            }
        }
    }
    
}
