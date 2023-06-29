//
//  ChatViewModel.swift
//  Chat
//
//  Created by Dyan on 6/28/23.
//

import Foundation

class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = [
        Message(uuid: UUID().uuidString, text: "A nível organizacional, a valorização de fatores subjetivos causa impacto indireto na reavaliação dos conhecimentos estratégicos para atingir a excelência.", isMe: false),
        Message(uuid: UUID().uuidString, text: "Não obstante, o desenvolvimento contínuo de distintas formas de atuação cumpre um papel essencial na formulação das posturas dos órgãos dirigentes com relação às suas atribuições.", isMe: true),
        Message(uuid: UUID().uuidString, text: "O cuidado em identificar pontos críticos na percepção das dificuldades desafia a capacidade de equalização do processo de comunicação como um todo.", isMe: true),
        Message(uuid: UUID().uuidString, text: "É importante questionar o quanto a competitividade nas transações comerciais causa impacto indireto na reavaliação das condições financeiras e administrativas exigidas.", isMe: false),
        Message(uuid: UUID().uuidString, text: "some message true", isMe: true),
        Message(uuid: UUID().uuidString, text: "Caros amigos, a constante divulgação das informações deve passar por modificações independentemente do investimento em reciclagem técnica.", isMe: false),
        Message(uuid: UUID().uuidString, text: "O cuidado em identificar pontos críticos na execução dos pontos do programa afeta positivamente a correta previsão do fluxo de informações.", isMe: false),
        Message(uuid: UUID().uuidString, text: "No entanto, não podemos esquecer que a constante divulgação das informações não pode mais se dissociar das diversas correntes de pensamento.", isMe: true),
        Message(uuid: UUID().uuidString, text: "Podemos já vislumbrar o modo pelo qual a competitividade nas transações comerciais estende o alcance e a importância das condições inegavelmente apropriadas.", isMe: false),
        Message(uuid: UUID().uuidString, text: "A nível organizacional, a contínua expansão de nossa atividade deve passar por modificações independentemente das diretrizes de desenvolvimento para o futuro.", isMe: true),
        Message(uuid: UUID().uuidString, text: "No entanto, não podemos esquecer que a consolidação das estruturas agrega valor ao estabelecimento do orçamento setorial.", isMe: true),
    ]
    
    @Published var text = String()
}
