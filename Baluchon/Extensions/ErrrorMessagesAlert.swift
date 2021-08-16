//
//  Extension.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 05/08/2021.
//

import Foundation



enum titleAlert: String {
    case failure = "❌"
    case convertInputValidity = "🧮"
    case translateInputValidity = "🇫🇷"
    case weatherInputValidity = "🌦"
    case locationAuth = "📍"
}

enum messageAlert: String {
    
    case convertInputValidity = "❌ pas convertible en $..."
    case convertRequest = "⚠️ Les données ne sont pas disponibles."

    case translateInputValidity = " ❌ Le traducteur demande un texte !"
    case translateRequest = "⚠️ La traduction n'est pas disponible"

    case weatherRequest = "❌ Un problème est survenu..."
    case locationAuth = """
                        Baluchon n'est pas autorisé pour la localisation :
                        vous ne pouvez pas recevoir les prévisions météo de votre ville !
                        """
}
