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
    
    func getResultWorkoutModel() -> Results<WorkoutModel> {
        realm.objects(WorkoutModel.self)
    }
    
    func saveWorkoutModel(_ model: WorkoutModel) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    func deleteWorkoutModel(_ model: WorkoutModel) {
        try! realm.write {
            realm.delete(model)
        }
    }
    
    func updateSetsRepsWorkoutModel(model: WorkoutModel, sets: Int, reps: Int) {
        try! realm.write {
            model.workoutSets = sets
            model.workoutReps = reps
        }
    }
    
    func updateStatusWorkoutModel(_ model: WorkoutModel) {
        try! realm.write {
            model.workoutStatus = true
        }
    }
}


