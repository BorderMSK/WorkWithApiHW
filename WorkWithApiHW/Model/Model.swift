//
//  Model.swift
//  WorkWithApiHW
//
//  Created by Igor Makeev on 27.06.2021.
//


struct Model: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
