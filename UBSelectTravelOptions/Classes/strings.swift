//
//  strings.swift
//  UberUXClone
//
//  Created by Claudio Madureira Silva Filho on 19/12/18.
//  Copyright © 2018 Claudio Madureira Silva Filho. All rights reserved.
//

import UIKit

extension String {
    static func confirmText(_ language: Language) -> String {
        switch language {
        case .en:
            return "Confirm".uppercased()
        case .es:
            return "Llamar al conductor".uppercased()
        default:
            return "Confirmar".uppercased()
        }
//        return language.isPT ? "Confirmar".uppercased() : "Confirm".uppercased()
    }
    
    static func backText(_ language: Language) -> String {
        switch language {
        case .en:
            return "Back"
        case .es:
            return "Volver"
        default:
            return "Voltar"
        }
//        return language.isPT ? "Voltar" : "Back"
    }
    
    static func noCardSelectedText(_ language: Language) -> String {
        switch language {
        case .en:
            return "No card selected"
        case .es:
            return "No hay tarjeta seleccionadas"
        default:
            return "Nenhum cartão selecionado"
        }
        
//        return language.isPT ? "Nenhum cartão selecionado" : "No card selected"
    }
    
    static func youSaveText(_ language: Language) -> String {
        switch language {
        case .en:
            return "No card selected"
        case .es:
            return "No hay tarjeta seleccionadas"
        default:
            return "Nenhum cartão selecionado"
        }
//        return language.isPT ? "Você economiza até " : "You save up "
    }
    
    static func searchingText(_ language: Language) -> String {
        switch language {
        case .en:
            return "Searching..."
        case .es:
            return "Buscando..."
        default:
            return "Buscando..."
        }
//        return language.isPT ? "Buscando..." : "Searching..."
    }
    
    static func descriptionText(_ language: Language) -> String {
        switch language {
        case .en:
            return "The shown fare is the price for this momentaneous request. If the destiny changes, the fare will also be calculated according to the normal ride prices."
        case .es:
            return "El valor final es el precio que se muestra al momento de la solicitud. Si se cambia el destino, el precio se calculará de acuerdo con el valor normal de los viajes."
        default:
            return "O valor final é o preço exibido no momento da solicitação. Se o destino for alterado, o preço será calculado de acordo com o valor normal das viagens."
        }
//        return language.isPT ? "O valor final é o preço exibido no momento da solicitação. Se o destino for alterado, o preço será calculado de acordo com o valor normal das viagens." :
//        "The shown fare is the price for this momentaneous request. If the destiny changes, the fare will also be calculated according to the normal ride prices."
    }
    
    static func priceText(_ language: Language) -> String {
        switch language {
        case .en:
            return "Fare"
        case .es:
            return "Precio"
        default:
            return "Preço"
        }
//        return language.isPT ? "Preço" : "Fare"
    }
    
    static func timeText(_ language: Language) -> String {
        switch language {
        case .en:
            return "Estimated Arrival"
        case .es:
            return "Pronóstico de llegada"
        default:
            return "Previsão de chegada"
        }
//        return language.isPT ? "Previsão de chegada" : "Estimated Arrival"
    }
    
    static func capacityText(_ language: Language) -> String {
        switch language {
        case .en:
            return "Capacity"
        case .es:
            return "Capacidad"
        default:
            return "Capacidade"
        }
//        return language.isPT ? "Capacidade" : "Capacity"
    }
    
    static func tryAgain(_ language: Language) -> String {
        switch language {
        case .en:
            return "Try again"
        case .es:
            return "Inténtalo de nuevo"
        default:
            return "Tente novamente"
        }
//        return language.isPT ? "Tente novamente" : "Try again"
    }
    
    static func noOptions(_ language: Language) -> String {
        switch language {
           case .en:
               return "Unfortunately there is no options in your area at the moment."
           case .es:
               return "Lamentablemente, no hay opciones disponibles en su área en este momento."
           default:
               return "Infelizmente não há opções disponíveis na sua área nesse momento."
           }
//        return language.isPT ? "Infelizmente não há opções disponíveis na sua área nesse momento." : "Unfortunately there is no options in your area at the moment."
    }
    
    static func addCoupon(_ language: Language) -> String {
        switch language {
        case .en:
            return "Add coupon"
        case .es:
            return "Ingressar cupón"
        default:
            return "Adicionar cupom"
        }
//        return language.isPT ? "Adicionar cupom" : "Add coupon"
    }
    
    static func scheduleTravel(_ language: Language) -> String {
        switch language {
        case .en:
            return "Schedule travel to:"
        case .es:
            return "Programe un viaje a"
        default:
            return "Agendar viagem para:"
        }
//        return language.isPT ? "Agendar viagem para:" : "Schedule travel to:"
    }
    
    static func cancelValue(_ language: Language) -> String {
        switch language {
        case .en:
            return "Cancellation fee pending"
        case .es:
            return "Tasa de cancelación pendiente"
        default:
            return "Taxa de cancelamento pendente"
        }

    }
}
