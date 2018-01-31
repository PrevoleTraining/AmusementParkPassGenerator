//
//  SoundEngine.swift
//  TrueFalseStarter
//
//  Created by PrevoleTraining on 29.01.18. (from BoutTime)
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

import AudioToolbox

/**
 * Sound engine to play sounds
 */
class SoundEngine {
    // The collection of sounds
    var sounds: [SoundName: (path: String, sound: SystemSoundID)] = [
        SoundName.denied: (path: "AccessDenied", sound: 0),
        SoundName.granted: (path: "AccessGranted", sound: 0)
    ]
    
    /**
     *Constructor
     */
    init() {
        // Load all the game sounds
        for (name, soundDef) in sounds {
            let pathToSoundFile = Bundle.main.path(forResource: soundDef.path, ofType: "wav")
            let soundURL = URL(fileURLWithPath: pathToSoundFile!)
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &(sounds[name]!.sound))
        }
    }
    
    /**
     *Play the specified sound.
     *
     * - parameter soundName: The sound to play
     */
    func playSound(with soundName: SoundName) {
        AudioServicesPlaySystemSound(sounds[soundName]!.sound)
    }
}
