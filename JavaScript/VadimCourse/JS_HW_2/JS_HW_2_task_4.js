// Написать функцию, которая проверяет, является ли слово палиндромом. 
// Проверки: 'abba', 'Abba'.

const isPalindrom = function (word) {
  let splitWord = word.split("");
  let reverseArr = splitWord.reverse();
  let reversed_word = reverseArr.join("");
  let word_not_reverse = word;

  if (reversed_word.toUpperCase() === word_not_reverse.toUpperCase()) {
    console.log('Слово ' + word + ' является палиндромом');
  } else {
    console.log('Слово ' + word + ' не является палиндромом');
  };
};

isPalindrom('abba');
isPalindrom('Abba');
isPalindrom('Tenet');
isPalindrom('Шалаш');
isPalindrom('Шалаши');
isPalindrom('До-в-од');