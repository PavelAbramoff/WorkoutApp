//
//  WorkouteModel.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-09.
//

import Foundation
import RealmSwift

class WorkouteModel: Object {
    @Persisted var workoutDate: Date
    @Persisted var workoutNumberOfDay: Int = 0
    @Persisted var workoutName: String = ""
    @Persisted var workoutRepeat: Bool = true
    @Persisted var workoutSets: Int = 0
    @Persisted var workoutReps: Int = 0
    @Persisted var workoutTimer: Int = 0
    @Persisted var workoutImage: Data?
    @Persisted var workoutStatus: Bool = false

}
