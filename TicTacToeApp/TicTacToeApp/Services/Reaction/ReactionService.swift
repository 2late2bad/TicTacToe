//
//  ReactionService.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 15.06.2023.
//

import Foundation

protocol ReactionServiceProtocol {
    //
    var muteSoundEffect: Bool { get set }
    // Старт игры
    func startGame() -> String
    // Генерация результата раунда
    func roundResult(xPoint: Int, oPoint: Int, sumOfWins: Int) -> String
    // Генерация результата матча
    func matchResult(player: Player, typeGame: TypeGame) -> String
}

final class ReactionService {
    static let shared = ReactionService()
    private init() {}
    
    private let soundManager = SoundManager.instance
    private var canPlaySound: Bool = true
}

extension ReactionService: ReactionServiceProtocol {
    
    var muteSoundEffect: Bool {
        get {
            return canPlaySound
        }
        set {
            canPlaySound = !newValue
        }
    }
    
    func startGame() -> String {
        if canPlaySound {
            soundManager.playSound(.roundonefight)
        }
        return "FIGHT!"
    }
    
    func matchResult(player: Player, typeGame: TypeGame) -> String {
        switch typeGame {
        case .PvP:
            if player == .cross {
                if canPlaySound {
                    soundManager.playSound(.xwins)
                }
            } else {
                if canPlaySound {
                    soundManager.playSound(.zerowins)
                }
            }
            return player == .cross ? "CROSS    WINNER" : "ZERO    WINNER"
        case .AI:
            let random = Bool.random()
            if player == .cross {
                if canPlaySound {
                    soundManager.playSound(random ? .excellent : .champion)
                }
            } else {
                if canPlaySound {
                    soundManager.playSound(random ? .yousuck : .laugh)
                }
            }
            return player == .cross ? "YOU  ARE  WINNER" : "YOU   SUCK"
        }
    }
    
    func roundResult(xPoint: Int, oPoint: Int, sumOfWins: Int) -> String {
        // Проверка на ничью
        guard sumOfWins != 0 else {
            if canPlaySound {
                soundManager.playSound(.drawlaugh)
            }
            return "DRAW"
        }
        
        // Генерация реакции в зависимости от счета в игре
        switch (xPoint, oPoint, sumOfWins) {
            // Условие first blood (1-0 or 0-1)
        case let (xP , oP, sumP) where ((sumP - oP == 1) && (xP == 0)) || ((sumP - oP == 0) && (xP == 1)):
            if canPlaySound {
                soundManager.playSound(.firstblood)
            }
            return "FIRST  BLOOD"
            
            // Условие nice catch (1-1, 2-2, 3-3, 4-4, 5-5)
        case let (xP , oP, sumP) where (xP == sumP - oP):
            if canPlaySound {
                soundManager.playSound(.getoverhere)
            }
            return "DEAD  HEAT"
            
            // Условие dominating (2-0 or 0-2)
        case let (xP , oP, sumP) where ((sumP - oP == 2) && (xP == 0)) || ((sumP - oP == 0) && (xP == 2)):
            if canPlaySound {
                soundManager.playSound(.dominating)
            }
            return "DOMINATING"
            
            // Условие unstoppable (3-0 or 0-3)
        case let (xP , oP, sumP) where ((sumP - oP == 3) && (xP == 0)) || ((sumP - oP == 0) && (xP == 3)):
            if canPlaySound {
                soundManager.playSound(.unstoppable)
            }
            return "UNSTOPPABLE"
            
            // Условие wicked sick (4-0 or 0-4)
        case let (xP , oP, sumP) where ((sumP - oP == 4) && (xP == 0)) || ((sumP - oP == 0) && (xP == 4)):
            if canPlaySound {
                soundManager.playSound(.wickedsick)
            }
            return "WICKED   SICK"
            
            // Условие godlike (5-0 or 0-5)
        case let (xP , oP, sumP) where ((sumP - oP == 5) && (xP == 0)) || ((sumP - oP == 0) && (xP == 5)):
            if canPlaySound {
                soundManager.playSound(.godlike)
            }
            return "GODLIKE"
            
            // Условие rampage (5-1 or 1-5)
        case let (xP , oP, sumP) where ((sumP - oP == 5) && (xP == 1)) || ((sumP - oP == 1) && (xP == 5)):
            if canPlaySound {
                soundManager.playSound(.rampage)
            }
            return "RAMPAGE"
            
            // Условие ownage (4-1, 1-4, 5-2, 2-5)
        case let (xP , oP, sumP) where
            ((sumP - oP == 4) && (xP == 1))
            || ((sumP - oP == 1) && (xP == 4))
            || ((sumP - oP == 5) && (xP == 2))
            || ((sumP - oP == 2) && (xP == 5)):
            if canPlaySound {
                soundManager.playSound(.ownage)
            }
            return "OWNAGE"
            
            // Условие holy shit (3-1, 1-3, 4-2, 2-4, 5-3, 3-5)
        case let (xP , oP, sumP) where
            ((sumP - oP == 3) && (xP == 1))
            || ((sumP - oP == 1) && (xP == 3))
            || ((sumP - oP == 4) && (xP == 2))
            || ((sumP - oP == 2) && (xP == 4))
            || ((sumP - oP == 5) && (xP == 3))
            || ((sumP - oP == 3) && (xP == 5)):
            if canPlaySound {
                soundManager.playSound(.holyshit)
            }
            return "HOLY   SHIT"
            
            // Условие combo whore (3-2, 2-3, 4-3, 3-4, 5-4, 4-5)
        case let (xP , oP, sumP) where
            ((sumP - oP == 3) && (xP == 2))
            || ((sumP - oP == 2) && (xP == 3))
            || ((sumP - oP == 4) && (xP == 3))
            || ((sumP - oP == 3) && (xP == 4))
            || ((sumP - oP == 5) && (xP == 4))
            || ((sumP - oP == 4) && (xP == 5)):
            if canPlaySound {
                soundManager.playSound(.combowhore)
            }
            return "COMBO    WHORE"
            
            // Условие toasty (2-1 or 1-2)
        case let (xP , oP, sumP) where ((sumP - oP == 2) && (xP == 1)) || ((sumP - oP == 1) && (xP == 2)):
            if canPlaySound {
                soundManager.playSound(.toasty)
            }
            return "TOASTY"
            
        default: return ""
        }
    }
}
