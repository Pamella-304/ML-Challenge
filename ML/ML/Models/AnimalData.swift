//
//  AnimalData.swift
//  ML
//
//  Created by Larissa Fazolin on 09/08/24.
//

import SwiftUI

struct Positions {
    static let horizontalMiddle: CGFloat = UIScreen.main.bounds.width * 0
    static let rightEdge: CGFloat = UIScreen.main.bounds.width * 0.65
    static let leftEdge: CGFloat = -UIScreen.main.bounds.width * 0.65
    static let verticalMiddle: CGFloat = UIScreen.main.bounds.height * 0
    static let bottomEdge: CGFloat = UIScreen.main.bounds.height * 0.4
    static let topEdge: CGFloat = -UIScreen.main.bounds.height * 0.4
}

struct AnimalFactory {
    static func createShakingAnimal(name: String, imageName: String) -> Animal {
        return Animal(
            name: name,
            animationType: .shake,
            positionX: [Positions.horizontalMiddle, Positions.leftEdge, Positions.rightEdge].randomElement() ?? 0,
            positionY: Positions.bottomEdge,
            image: UIImage(named: imageName)!
        )
    }
    
    static func createHorizontalWalkingAnimal(name: String, imageName: String) -> Animal {
        return Animal(
            name: name,
            animationType: .horizontal(duration: 3.0),
            positionX: [Positions.leftEdge, Positions.rightEdge].randomElement() ?? 0,
            positionY: Positions.bottomEdge,
            image: UIImage(named: imageName)!
        )
    }
    
    static func createWaveWalkingAnimal(name: String, imageName: String) -> Animal {
        return Animal(
            name: name,
            animationType: .wave(duration: 3.0),
            positionX: [Positions.leftEdge, Positions.rightEdge].randomElement() ?? 0,
            positionY: Positions.verticalMiddle,
            image: UIImage(named: imageName)!
        )
    }
    
    static func createStillAnimal(name: String, imageName: String) -> Animal {
        return Animal(
            name: name,
            animationType: .shake,
            positionX: [Positions.horizontalMiddle, Positions.leftEdge, Positions.rightEdge].randomElement() ?? 0,
            positionY: Positions.bottomEdge,
            image: UIImage(named: imageName)!
        )
    }
}

struct AnimalData {
    var animals: [String: Animal] = [
        // Animals that Shake
        "Seahorse": Animal(name: "Seahorse", animationType: .shake, positionX: [Positions.horizontalMiddle, Positions.leftEdge, Positions.rightEdge].randomElement() ?? 0, positionY: [Positions.verticalMiddle, Positions.bottomEdge, Positions.topEdge].randomElement() ?? 0, image: UIImage(named: "seahorse")!),
        "Starfish": AnimalFactory.createShakingAnimal(name: "Starfish", imageName: "starfish"),
        
        // Animals that Walk Horizontally
        "Shark": Animal(name: "Shark", animationType: .horizontal(duration: 3.0), positionX: [Positions.leftEdge, Positions.rightEdge].randomElement() ?? 0, positionY: [Positions.verticalMiddle, Positions.bottomEdge, Positions.topEdge].randomElement() ?? 0, image: UIImage(named: "shark")!),
        "Snail": AnimalFactory.createHorizontalWalkingAnimal(name: "Snail", imageName: "snail"),
        "Crab": AnimalFactory.createHorizontalWalkingAnimal(name: "Crab", imageName: "crab"),
        "Lobster": AnimalFactory.createHorizontalWalkingAnimal(name: "Lobster", imageName: "lobster"),
        "Schrimp": AnimalFactory.createHorizontalWalkingAnimal(name: "Schrimp", imageName: "schrimp"),
        
        // Animals that Walk in Wave
        "Fish": AnimalFactory.createWaveWalkingAnimal(name: "Fish", imageName: "fish"),
        "Dolphin": AnimalFactory.createWaveWalkingAnimal(name: "Dolphin", imageName: "dolphin"),
        "Octopus": AnimalFactory.createWaveWalkingAnimal(name: "Octopus", imageName: "octopus"),
        "Squid": AnimalFactory.createWaveWalkingAnimal(name: "Squid", imageName: "squid"),
        "Jellyfish": AnimalFactory.createWaveWalkingAnimal(name: "Jellyfish", imageName: "jellyfish"),
        "Turtle": AnimalFactory.createWaveWalkingAnimal(name: "Turtle", imageName: "turtle"),
        
        // Animals that Stand Still
        "Mussel": AnimalFactory.createStillAnimal(name: "Mussel", imageName: "mussel"),
        "Oyster": AnimalFactory.createStillAnimal(name: "Oyster", imageName: "oyster"),
        "SeaUrchin": AnimalFactory.createStillAnimal(name: "SeaUrchin", imageName: "seaurchin")
    ]
}


//var horizontalMiddle: CGFloat = UIScreen.main.bounds.width * 0
//var rightEdge: CGFloat = UIScreen.main.bounds.width * 0.65
//var leftEdge: CGFloat = -UIScreen.main.bounds.width * 0.65
//var verticalMiddle: CGFloat = UIScreen.main.bounds.height * 0
//var bottomEdge: CGFloat = UIScreen.main.bounds.height * 0.4
//var topEdge: CGFloat = -UIScreen.main.bounds.height * 0.4

// ANIMALS THAT SHAKE
// name: "Seahorse", animationType: .shake, animationDuration: 3.0, positionX: horizontalMiddle, rightEdge or leftEdge (random), positionY: verticalMiddle, bottomEdge or topEdge (random)
// name: "Starfish", animationType: .shake, animationDuration: 3.0, positionX: horizontalMiddle, rightEdge or leftEdge (random), positionY: bottomEdge

// ANIMALS THAT WALK HORIZONTALLY
// name: "Shark", animationType: .horizontal(duration: animationDuration), animationDuration: 3.0, positionX: rightEdge or leftEdge (random), positionY: verticalMiddle, bottomEdge or topEdge (random)
// name: "Snail", animationType: .horizontal(duration: animationDuration), animationDuration: 3.0, positionX: rightEdge or leftEdge (random), positionY: bottomEdge
// name: "Crab", animationType: .horizontal(duration: animationDuration), animationDuration: 3.0, positionX: rightEdge or leftEdge (random), positionY: bottomEdge
// name: "Lobster", animationType: .horizontal(duration: animationDuration), animationDuration: 3.0, positionX: rightEdge or leftEdge (random), positionY: bottomEdge
// name: "Schrimp", animationType: .horizontal(duration: animationDuration), animationDuration: 3.0, positionX: rightEdge or leftEdge (random), positionY: bottomEdge

// ANIMALS THAT WALK IN WAVE
// name: "Fish", animationType: .wave(duration: animationDuration), animationDuration: 3.0, positionX: rightEdge or leftEdge (random), positionY: verticalMiddle
// name: "Dolphin", animationType: .wave(duration: animationDuration), animationDuration: 3.0, positionX: rightEdge or leftEdge (random), positionY: verticalMiddle
// name: "Octopus", animationType: .wave(duration: animationDuration), animationDuration: 3.0, positionX: rightEdge or leftEdge (random), positionY: verticalMiddle
// name: "Squid", animationType: .wave(duration: animationDuration), animationDuration: 3.0, positionX: rightEdge or leftEdge (random), positionY: verticalMiddle
// name: "Jellyfish", animationType: .wave(duration: animationDuration), animationDuration: 3.0, positionX: rightEdge or leftEdge (random), positionY: verticalMiddle
// name: "Turtle", animationType: .wave(duration: animationDuration), animationDuration: 3.0, positionX: rightEdge or leftEdge (random), positionY: verticalMiddle

// ANIMALS THAT STAND STILL
// name: "Mussel", animationType: .still, animationDuration: 3.0, positionX: horizontalMiddle, rightEdge or leftEdge (random), positionY: bottomEdge
// name: "Oyster", animationType: .still, animationDuration: 3.0, positionX: horizontalMiddle, rightEdge or leftEdge (random), positionY: bottomEdge
// name: "SeaUrchin", animationType: .still, animationDuration: 3.0, positionX: horizontalMiddle, rightEdge or leftEdge (random), positionY: bottomEdge

// All animals that shake have the same positions, except for the Seahorse
// All animals that walk horizontally have the same positions, except for the Shark
// All animals that walk in wave have the same positions
// All animals that stand still have the same positions

// Using machine learning, I'm going to get an animalImage and based on that, I'll figure out which animal that is. If its a Fish, for example, it should have all the characteristics that the Fish has in the AnimalData. How could I do that?
