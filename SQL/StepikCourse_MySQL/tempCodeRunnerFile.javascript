let age_2 = 18;
let age_3 = 60;

const checkAge = function (age) {
  if (age !== "" && !isNaN(age)) {
    if (age < age_2) {
      console.log('You don’t have access cause your age is ' + age + ' It’s less then');
    } else if (age >= age_2 && age <= age_3) {
      console.log('Welcome  !');
    } else if (age > age_3) {
      console.log('Keep calm and look Culture channel');
    } else {
      console.log('Technical work');
    }
  } else {
    console.log('ERROR. Not an integer value');
  }
}


checkAge(17);
checkAge(18);
checkAge(60);
checkAge(61);
checkAge('Я НИНАЮ СКОЛЬКО МНЕ ЛЕТ!!! ПАМАГИТИ!!!!');
checkAge('2');
checkAge('17');
checkAge('18');
checkAge('61');
checkAge('0');
checkAge(0);
checkAge('');