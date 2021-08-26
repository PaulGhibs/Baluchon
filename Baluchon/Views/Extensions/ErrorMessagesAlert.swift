//
//  Extension.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 05/08/2021.
//

import Foundation

// Pop up title alert calls from presentAlert function in UIAlertActivities
enum TitleAlert: String {
    case failure = "❌"
    case convertInputValidity = "🧮"
    case translateInputValidity = "🇫🇷"
    case weatherRequest = "🌦"
    case locationAuth = "📍"
}
// strings to display as alert pop-up messages
enum MessageAlert: String {
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
