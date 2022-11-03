const printWord = function(word, q) {
  word_2 = String(word);
  for (let i = 1; i <= q; i++) {
  console.log(word.toString());
  word += word_2
}
}

printWord('Hi ', 2)
printWord('WTF ', 3)
printWord('Ментор, который проверил это, ты лучший :) ', 4)
printWord(444, 4)