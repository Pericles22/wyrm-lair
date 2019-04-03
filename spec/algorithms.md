# Algorithms

## Damage Calculation

scenario:

player has 100 accuracy and 100 melee damage. No other bonuses

enemy has 100 defense

Algorithm:

chance to hit = Math.min(95, 10 + Math.max(0, playerAccuracy - enemyDefense) / 100)

damage = 1 + (0.1 * playerMeleeDamage) + Math.max(0, playerMeleeDamage - enemyDefense)

## Required XP Calculation

requiredXP = pow(log(2), 2)
requiredXP += pow(log(playerLevel + 1),2) * pow(playerLevel + 1,2)