---
title: Two Player Discrete Game Representation in Haskell
---

To begin precise analysis of games, a precise definition of a game is necessary.
In Game Theory, this is known as a Normal Form of a game. Without this formalization
it would be difficult to do much better than squinting and pondering about specific
textual formulations of a game.

A game may be represented by the three tuple $(P, S, U)$
where $P$ is the set of players,
$S$ is the set of strategy profiles,
and $U$ is the set of payout or reward functions.

The set $P$ is nothing more than a collection of labels,
either numbers or names of the players in the game.
The set $S$ is a corresponding collection of strategy profiles for
players in $P$. There is a one-to-one correspondence between strategy profiles
and players. A function $ps: P \to S$ exists which relates one set to the other.
Generally though, the notation $S_i$ is used to refer to the $i^\text{ th}$ player's
strategy profile. A strategy profile is itself a set of strategies $\{s_1, s_2, \ldots, s_n\}$
A particular strategy $s$ represents a possible method of playing the game.

There is a function $U_i$ in the set of reward functions for each member $P_i$ in the set of players.
For static discrete games, these are complete functions with the type:
$$U_i: S_1 \times S_2 \times \ldots \times S_n \to \mathbb{R}$$
These functions map the combination of strategies used by all players in the game to a real number
representing the magnitude of the value or reward the $i^\text{ th}$ player recieved. The natural
conotation being that higher is better. The resulting number is representative of all motivations
of a particular player. For example, if one player would like to bring down another player, that
desire will be expressed by $U$. Reasoning about other player's payout functions is therefore
detached from their actual game performance, and therefore not very interesting.

A famous example of a discrete two player game is the Prisoner's Dilemma. There are two prisoners,
and they have each been offered the same deal by the police. If just one prisoner confesses, their
sentence will be shortened to just two years and their partner's extended to 10 years.
If both confess, they will both recieve a 5 year sentence.
If neither confess to the crime, they will be let go after 3 years.
What should a prisoner do?

Formalize their situation, obviously. There are two prisoners, so the set of players is 
$P=\{1,2\}$
A prisoner may either confess or not confess, so the set of strategy sets is:

$S$ = {{Confess, Do Not Confess}, {Confess, Do Not Confess}}

The payout functions may then be defined as:
\\[U_1(C, C) = -5 \\]
\\[U_1(C, D) = -2 \\]
\\[U_1(D, C) = -10\\]
\\[U_1(D, D) = -3 \\]
\\[U_2(C, C) = -5 \\]
\\[U_2(C, D) = -2 \\]
\\[U_2(D, C) = -10\\]
\\[U_2(D, D) = -3 \\]
Where $C$ is short for Confess, and $D$ is short for Do Not Confess.

# Haskell Representation of Games
In Haskell, we can represent this particular game in nearly
1:1 fashion:

```haskell
module Prisoners where

type Player = Int

data Strategy = Confess
              | DoNotConfess

payout :: Player -> (Strategy, Strategy) -> Int
payout 1 (C, C) = -5
payout 1 (C, D) = -2
payout 1 (D, C) = -10
payout 1 (D, D) = -3
payout 2 (C, C) = -5
payout 2 (C, D) = -2
payout 2 (D, C) = -10
payout 2 (D, D) = -3
```

It's important to remember that from our construction we are dealing with
players who only seek to minimize their own jailtime. If they had other factors
to consider the results of the payout function would be definied differently.
This is obviously not a realistic interpretation of how such a situation would
play out, but it's useful as an example.
