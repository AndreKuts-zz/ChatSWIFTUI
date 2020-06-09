//
//  Queue.swift
//  ChatTestTask
//
//  Created by Kuts, Andrey on 6/10/20.
//  Copyright © 2020 Kuts, Andrey. All rights reserved.
//

struct Queue {

    var items: [String] = []

    mutating func enqueue(element: String) {
        items.append(element)
    }

    mutating func dequeue() -> String? {
        if items.isEmpty {
            return nil
        } else {
            let tempElement = items.first
            items.remove(at: 0)
            return tempElement
        }
    }
}
