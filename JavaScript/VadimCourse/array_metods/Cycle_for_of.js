// Оператор for...of выполняет цикл обхода итерируемых объектов (включая Array, Map, Set, объект аргументов и подобных), вызывая на каждом шаге итерации операторы для каждого значения из различных свойств объекта.

let iterable = [10, 30, 50,];

for (let value of iterable) {
  value *= 2;
  console.log(value);
}

// Таким образом мы можем заменить обычный цикл for
for (let i = 0; i < iterable.length; i++) {
  iterable[i] *= 2;
  console.log(iterable[i])
}


let str = 'boss'

for (let value of str) {
  value += 'i';
  console.log(value)
}