//
//  RealmManager.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-10.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    private init() {}
    
    let realm = try! Realm()
    
    func getResultWorkoutModel() -> Results<WorkouteModel> {
        realm.objects(WorkouteModel.self)
    }
    
    func saveWorkoutModel(_ model: WorkouteModel) {
        try! realm.write {
            realm.add(model)
        }
    }
}
