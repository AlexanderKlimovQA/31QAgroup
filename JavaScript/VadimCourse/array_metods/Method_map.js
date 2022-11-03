// Метод map() создаёт новый массив с результатом вызова указанной функции для каждого элемента массива.

const numbers = [0, 1, 4, 10, 100, 500]

let doubles_numbers = numbers.map(el => el * 2)
console.log(doubles_numbers)


const string_numbers = ['-1', '2', '5', '0', '123']

let convert_numbers = string_numbers.map(Number)
console.log(convert_numbers)