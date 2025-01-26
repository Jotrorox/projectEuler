from collections import Counter
import sys
import os

def card_value(card):
    values = {'2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9, 'T': 10,
              'J': 11, 'Q': 12, 'K': 13, 'A': 14}
    return values[card[0]]

def hand_rank(hand):
    values = sorted([card_value(card) for card in hand], reverse=True)
    value_counts = Counter(values)
    suits = [card[1] for card in hand]

    is_flush = len(set(suits)) == 1
    is_straight = len(value_counts) == 5 and (max(values) - min(values) == 4)
    counts = sorted(value_counts.values(), reverse=True)

    if is_flush and is_straight:
        return (9, max(values))  # Straight Flush
    if counts == [4, 1]:
        return (8, max(value_counts, key=value_counts.get), values)  # Four of a Kind
    if counts == [3, 2]:
        return (7, max(value_counts, key=value_counts.get), values)  # Full House
    if is_flush:
        return (6, values)  # Flush
    if is_straight:
        return (5, max(values))  # Straight
    if counts == [3, 1, 1]:
        return (4, max(value_counts, key=value_counts.get), values)  # Three of a Kind
    if counts == [2, 2, 1]:
        pair_values = sorted([val for val, count in value_counts.items() if count == 2], reverse=True)
        return (3, pair_values, values)  # Two Pair
    if counts == [2, 1, 1, 1]:
        return (2, max(value_counts, key=value_counts.get), values)  # One Pair
    return (1, values)  # High Card

def compare_hands(hand1, hand2):
    rank1, rank2 = hand_rank(hand1), hand_rank(hand2)
    return 1 if rank1 > rank2 else 0

def count_player1_wins(filename):
    player1_wins = 0
    with open(filename, 'r') as file:
        for line in file:
            cards = line.strip().split()
            hand1, hand2 = cards[:5], cards[5:]
            player1_wins += compare_hands(hand1, hand2)
    return player1_wins

# Example usage
script_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
input_path = os.path.join(script_dir, 'input.txt')
player1_wins = count_player1_wins(input_path)
print(f"Player 1 wins {player1_wins} times")
