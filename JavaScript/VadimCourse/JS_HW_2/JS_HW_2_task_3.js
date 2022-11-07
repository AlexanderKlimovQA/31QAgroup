// Написать функцию, которая принимает на вход слово. Задача функции посчитать и вывести в консоль, сколько в слове гласных, и сколько согласных букв.
// Проверки: 'case', 'Case', 'Check-list'.

const vowel_number = function(word) {
  let vowel_letters = 'aeiouAEIOU';
  let cons_letters = 'bcdfghjklmnpqrstvwxzBCDFGHJKLMNPQRSTVWXA';
  let vcount = 0;
  let ccount = 0;

  for (let x = 0; x < word.length; x++) {
    if (vowel_letters.indexOf(word[x]) !== -1) {
      vcount += 1;
    };
    if (cons_letters.indexOf(word[x]) !== -1) {
      ccount += 1;
    };
  };
  console.log('Слово ' + word + ' состоит из ' + vcount + ' гласных букв и ' + ccount + ' согласных.');
};

vowel_number('case');
vowel_number('Case');
vowel_number('Check-list');