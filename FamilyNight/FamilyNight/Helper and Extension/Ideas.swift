//
//  EventIdeas.swift
//  FamilyNight
//
//  Created by Jaymond Richardson on 6/8/21.
//

import Foundation

class Idea {
    var title: String
    init(title: String) {
        self.title = title
    }
}
var ideas: [Idea] = [
    Idea(title: "Go on a walk"),
    Idea(title: "Wash the car"),
    Idea(title: "Go to the zoo"),
    Idea(title: "Throw a slumber party"),
    Idea(title: "Camp in the backyard"),
    Idea(title: "Go through baby photos"),
    Idea(title: "Try a new cookie recipe"),
    Idea(title: "Visit the library"),
    Idea(title: "Play kick-ball"),
    Idea(title: "Plant a garden"),
    Idea(title: "Visit a museum"),
    Idea(title: "Record acting out a play"),
    Idea(title: "Buy and fly a kite"),
    Idea(title: "Play hide and seek in the dark"),
    Idea(title: "Go on a hike"),
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
    Idea(title: "Make a lemonade stand"),
    Idea(title: "Babysit friends or neighbors kids for free so parents can go out"),
    Idea(title: "Have a formal dinner"),
    Idea(title: "Have a garage sale"),
    Idea(title: "Go through a drive through and pay for the car behind you"),
    Idea(title: "Have ice cream for breakfast, and talk about why you dont care"),
    Idea(title: "Go fishing"),
    Idea(title: "Visit a waterfall"),
    Idea(title: "Go bird watching"),
    Idea(title: "Video call a loved one"),
    Idea(title: "Go to a local bakery"),
    Idea(title: "Make cookies for your neighbor"),
    Idea(title: "Play charades with chalk outside"),
    Idea(title: "Go to the zoo")
  
]

func randomIdea() -> String {
   let randomIdea = Int(arc4random_uniform(UInt32(ideas.count)))
   let placeHolderIdea = ideas.remove(at: randomIdea)
   return placeHolderIdea.title
}
