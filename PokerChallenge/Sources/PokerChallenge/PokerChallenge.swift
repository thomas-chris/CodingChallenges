func decideWinner(players: [Player], river: [Card]) {
    
}

func getCards(river: [Card], hand: [Card]?) -> [Card] {
    return river + (hand ?? [])
}

func getFlush(player: Player?, river: [Card]) -> Suit? {
    getCards(river: river, hand: player?.hand)
        .map { card in
            card.suit
        }
        .reduce(into: [:]) { counts, number in
            counts[number, default: 0] += 1
        }
        .filter { (suit, count) in
            count >= 5
        }
        .keys
        .first
}

func getFlushCards(player: Player?, river: [Card]) -> [Card] {
    guard let suit = getFlush(player: player, river: river) else { return [] }
    
    return getCards(river: river, hand: player?.hand)
        .filter { card in
            card.suit == suit
        }
}

func getBestFlushHand(player: Player?, river: [Card]) -> [Card] {
    getFlushCards(player: player, river: river).getOrderedHand()
}

func getStraightHand(player: Player?, river: [Card]) -> [Card] {
    let potentialHand = getCards(river: river, hand: player?.hand).getOrdered()
    if (potentialHand.prefix(5).passesForConsecutiveValues {
        $0.value.rawValue - 1 == $1.value.rawValue
        
    }) {
        guard potentialHand.prefix(5).count == 5 else { return [] }
        return Array(potentialHand.prefix(5))
    }
    else if (potentialHand.dropFirst().prefix(5).passesForConsecutiveValues {
        $0.value.rawValue - 1 == $1.value.rawValue
    }) {
        guard potentialHand.dropFirst().prefix(5).count == 5 else { return [] }
        return Array(potentialHand.dropFirst().prefix(5))
    }
    else if (potentialHand.dropFirst().dropFirst().prefix(5).passesForConsecutiveValues {
        $0.value.rawValue - 1 == $1.value.rawValue
    }) {
        guard potentialHand.dropFirst().dropFirst().prefix(5).count == 5 else { return [] }
        return Array(potentialHand.dropFirst().dropFirst().prefix(5))
    }
    return []
}

func getStraightFlush(player: Player, river: [Card]) -> [Card] {
    let flushHand = getFlushCards(player: player, river: river)
    return getStraightHand(player: nil, river: flushHand)
}