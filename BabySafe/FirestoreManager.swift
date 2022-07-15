//
//  FirestoreManager.swift
//  BabySafe
//
//  Created by Anghi Rodriguez on 3/07/22.
//

import FirebaseCore
import FirebaseFirestore

class FirestoreManager {
    
    static let collectionName = "tips"
    static let database = Firestore.firestore()
    
    static func fetchTips(completion: @escaping (([Tip]) -> Void)) {
        var tips: [Tip] = []
        database.collection(collectionName).getDocuments { response, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let response = response {
                    for document in response.documents {
                        do {
                            let tip = try document.data(as: Tip.self)
                            tips.append(tip)
                        }
                        catch {
                            print(error)
                        }
                        print("\(document.documentID) => \(document.data())")
                    }
                }
                completion(tips)
            }
        }
    }
    
    static func addTip(tip: Tip, completion: @escaping ((Bool) -> Void)) {
        let collectionRef = database.collection(collectionName)
        do {
            try _ = collectionRef.addDocument(from: tip, encoder: Firestore.Encoder()) { error in
                if error == nil {
                    completion(true)
                }
                completion(false)
            }
        } catch {
            completion(false)
        }
    }
    
    static func updateTip(tip: Tip) {
        if let id = tip.id {
            let documentRef = database.collection(collectionName).document(id)
            do {
                try documentRef.setData(from: tip)
            } catch {
                print("Error updateTip")
            }
        }
    }
    
}
