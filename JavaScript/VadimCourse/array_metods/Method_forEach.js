// Метод forEach() выполняет указанную функцию один раз для каждого элемента в массиве.

const array1 = ['Dog', 'Cat', 'Mouse', 'Bear', 'Fox']

array1.forEach(el => console.log(el))


let copy = []
let count = 0

array1.forEach(el => {
copy.push(el)
count++
})

console.log('Колчиество скопированных элементов =', count)
console.log(copy)