const fs = require('node:fs')

String.prototype.countChar = function (ch) {
  let result = 0
  for (let i = 0; i < this.length; i++) {
    if (this[i] === ch) { result++ }
  }
  return result
}

Array.prototype.sortHands = function () {
  return this.sort(function (a, b) { return compareHands(a, b) })
}

function countDupes (hand) {
  // technically this function counts the same rank multiple times if more than
  // one exists, but if we want to optimise this counting we'll need to
  // traverse the whole hand to remove duplicates so we might as well traverse
  // it once but with a less clean solution as we do here
  const dupes = {}
  for (let i = 0; i < hand.cards.length; i++) {
    dupes[hand.cards.charAt(i)] = hand.cards.countChar(hand.cards.charAt(i))
  }

  const ret = Object.values(dupes).sort().reverse()
  return ret
}

function categoriseHand (hand) {
  const dupes = countDupes(hand)
  if (dupes[0] === 5) { return 7 }
  if (dupes[0] === 4) { return 6 }
  if (dupes[0] === 3 && dupes[1] === 2) { return 5 }
  if (dupes[0] === 3) { return 4 }
  if (dupes[0] === 2 && dupes[1] === 2) { return 3 }
  if (dupes[0] === 2) { return 2 }
  if (dupes[0] === 1) { return 1 }
  return -99
}

function compareCards (a, b) {
  const honourCards = {
    T: 10,
    J: 11,
    Q: 12,
    K: 13,
    A: 14
  }

  const cmpA = honourCards[a] || a
  const cmpB = honourCards[b] || b

  if (cmpA > cmpB) { return 1 }
  if (cmpB > cmpA) { return -1 }
  return 0
}

function compareHands (a, b) {
  const catA = categoriseHand(a)
  const catB = categoriseHand(b)

  if (catA > catB) { return 1 }

  if (catB > catA) { return -1 }

  for (let idx = 0; idx < a.cards.length; idx++) {
    const cmp = compareCards(a.cards[idx], b.cards[idx])
    if (cmp !== 0) { return cmp }
  }

  return 0
}

const hands = []
fs.readFile('data/7.txt', 'utf8', (err, data) => {
  let score = 0
  if (err) {
    console.error(err)
    return
  }
  const lines = data.toString().split('\n')
  lines.pop() // throw away the last record due to trailing new line in the input

  for (let line = 0; line < lines.length; line++) {
    const parts = lines[line].toString().split(' ')

    hands.push({ cards: parts[0], bid: parts[1] })
  }
  hands.sortHands()

  for (let id = 0; id < hands.length; id++) {
    score += (id + 1) * hands[id].bid
  }
  console.log('Part 1: score = ' + score)
})
