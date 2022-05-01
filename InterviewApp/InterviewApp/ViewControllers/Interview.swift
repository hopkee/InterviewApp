//
//  Interview.swift
//  InterviewApp
//
//  Created by Валентин Величко on 22.04.22.
//

import Foundation

struct Interview {
    
    var title: String
    var date: Date
    var duration: Float
    var interviewer: Interviewer?
    var questions: [String]?
    var notes: String
    
}

struct Interviewer {
    
    var name: String
    var notes: String
    
}
