console.log(`\n----- Возведение числа в степень с помощью рекурсии -----`)

// Возведение числа в степень с помощью рекурсии. x - число, которое возводим в степень, n - степень в которую мы хотим возвести число

const pow = (x, n) => {
  if (n == 1) {
    return x;
  } else {
    return x * pow(x, n - 1);
  };
};

console.log(pow(2, 4));

console.log(`----- Подсчет общей суммы зарплат всех сотрудников с помощью рекурсии -----`)

// Подсчет общей суммы зарплат всех сотрудников с помощью рекурсии

let company = {
  sales: [{
    name: 'John',
    salary: 1000
  }, {
    name: 'Alice',
    salary: 600
  }],

  development: {
    sites: [{
      name: 'Peter',
      salary: 2000
    }, {
      name: 'Alex',
      salary: 1800
    }],

    internals: [{
      name: 'Jack',
      salary: 1300
    }]
  }
};

const sumSalaries = (department) => {
  if (Array.isArray(department)) {
    return department.reduce((prev, current) => prev + current.salary, 0);
  } else {
    let sum = 0;
    for (let subdep of Object.values(department)) {
      sum += sumSalaries(subdep);
    };
    return sum;
  };
};

console.log(sumSalaries(company));

console.log(`----- Подсчет суммы числа -----`)

// Задание: написать функцию, которая считает сумму числа. С помощью цикла и с помощью рекурсии.

// Цикл:

const sumTo = (number) => {

  let result = 0;

  for (let i = 0; i <= number; i++) {
    result += i;
  };
  return result;
};

console.log(sumTo(100), 'c помощью цикла');

// Рекурсия:

const sumToRec = (number) => {

  if (number === 0 || number === 1) {
    return number;
  } else {
    return number += sumToRec(number - 1);
  };
};

console.log(sumToRec(100), 'с помощью рекурсии');

console.log(`----- Вычисление факториала числа -----`)

// Задание: написать функцию, вычисляющую факториал числа. Факториал натурального числа это число, умноженное на себя - 1, после умноженное на себя - 2 и т.д.

const calculateFactorial = (number) => {
  if (number === 1) {
    return number;
  } else {
    return number * calculateFactorial(number - 1);
  };
};

console.log(calculateFactorial(4));

console.log(`----- Числа Фибоначчи -----`)

// Задание: написать функцию чисел Фибоначчи. Последовательность чисел Фибоначчи определяется формулой Fn = Fn-1 + Fn-2. То есть, следующее число получается как сумма двух предыдущих. Первые два числа равны 1, затем 2(1+1), затем 3(1+2), 5(2+3) и так далее: 1, 1, 2, 3, 5, 8, 13, 21....

const fib = (number) => {
  if (number <= 1) {
    return number;
  } else {
    return fib(number - 1) + fib(number - 2);
    };
  };

console.log(fib(7), 'с помощью рекурсии');            // Очень долгий способ, так как функция много раз вызывает сама себя


const fibCycle = (number) => {
  let a = 1;
  let b = 1;
  let c = 0;
  for (let i = 2; i < number; i++) {
    c = a + b;
    a = b;
    b = c;
  };
  return c;
};

console.log(fibCycle(7), 'с помощью цикла');      // Таким способом 77 посчиталось за долю секунды. При использовании рекурсии я так и не 
console.log(fibCycle(77), 'с помощью цикла');     // дождался, когда программа посчитает это число.