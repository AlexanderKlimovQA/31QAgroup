//  Написать скрипт, который выведет 5 строк в консоль таким образом, чтобы в первой строчке выводилось :), во второй :):) и так далее.
smile = ';)';

for (let i = 1; i <= 5; i++) {
  console.log(smile);
  smile += ';)';
};



// Преобразовать задачу в функцию, принимающую на вход строку, которая и будет выводиться в консоль (как в условии смайлик), а также количество строк для вывода 
// e.g. function printSmile(stroka, numberOfRows)

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