def count_ways_to_make(target, coins):
    dp = [0] * (target + 1)
    dp[0] = 1

    for coin in coins:
        for amount in range(coin, target + 1):
            dp[amount] += dp[amount - coin]

    return dp[target]

coins = [1, 2, 5, 10, 20, 50, 100, 200]
target = 200
result = count_ways_to_make(target, coins)
print(result)