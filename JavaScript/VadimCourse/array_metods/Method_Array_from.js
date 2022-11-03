// Метод Array.from() создаёт новый экземпляр Array из массивоподобного или итерируемого объекта.

// Массив из строки
console.log(Array.from('ALEX'))

// Массив из Set
let g = ['BILL', 'SAM']
let a = new Set(['ALEX', g])
console.log(Array.from(a))


let hero = [{
  'name': 'Legolas',
  'race': 'elf',
  'class': 'scout'
},
{
  name: 'Gimli',
  race: 'Dwarf',
  class: 'Axeman'
}]

console.log(Array.from(hero.map(el => JSON.stringify(el))))
console.log(hero.length)
