// Цикл for...in проходит через перечисляемые свойства объекта. Он пройдёт по каждому отдельному элементу.

let obj = {
  a: 1,
  b: 2,
  c: 3,
  class: 'Axeman'
}

for (let prop in obj) {
  console.log("obj." + prop + " = " + obj[prop])
}
