//
//  UserModel.swift
//  AssessmentTask
//
//  Created by Adel Aref on 05/12/2021.
//

import Foundation
import RealmSwift

class UserModel: Object, Codable {
    @objc dynamic var phone: String = ""
    @objc dynamic var password: String = ""
    override class func primaryKey() -> String? {
        return "phone"
    }
}
