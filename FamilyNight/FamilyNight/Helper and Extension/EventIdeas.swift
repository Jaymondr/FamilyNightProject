//
//  EventIdeas.swift
//  FamilyNight
//
//  Created by Jaymond Richardson on 6/8/21.
//

import Foundation

struct Idea {
    var title: String
}
var ideas: [Idea] = [
    Idea(title: "Go on a walk"),
    Idea(title: "Wash the car"),
    Idea(title: "Go to the zoo"),
    Idea(title: "Have a slumber party"),
    Idea(title: "Camp in the backyard"),
    Idea(title: "Go through baby photos"),
    Idea(title: "Try a new cookie recipe"),
    Idea(title: "Visit the library"),
    Idea(title: "Play kick-ball"),
    Idea(title: "Plant a garden"),
    Idea(title: "Visit a museum"),
    Idea(title: "Record yourselves acting out a play"),
    Idea(title: "Buy and fly a kit"),
    Idea(title: "Play hide and seek in the dark"),
    Idea(title: "Go for a hike"),
    Idea(title: "Have a race"),
    Idea(title: "Tell scary stories in the dark"),
    Idea(title: "Make a rope swing and hang it in a tree"),
    Idea(title: "Draw funny faces of each other"),
    Idea(title: "Go ice blocking"),
    Idea(title: "Go to a lake"),
    Idea(title: "Play sardines in a forest"),
    Idea(title: "Play tag on a park gymnasium"),
    Idea(title: "Drive through town and read historical signs"),
    Idea(title: "Play tag football"),
    Idea(title: "Doorbell ditch nice letters to your neighbors, or friends"),
    Idea(title: "Visit a local book store"),
    Idea(title: "Say why your grateful for each other"),
    Idea(title: "Have a lemonade stand"),
    Idea(title: "Babysit friends or neighbors kids for free so parents can go out"),
    Idea(title: "Have a formal dinner"),
    Idea(title: "Have a garage sale"),
    Idea(title: "Go through a drive through and pay for the car behind you"),
    Idea(title: "Have ice cream for breakfast, and talk about why you dont care"),
  
]

let randomIdea = Int(arc4random_uniform(UInt32(ideas.count)))
let placeHolderIdea = ideas.remove(at: randomIdea)
