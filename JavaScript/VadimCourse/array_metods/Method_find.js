// Метод find() возвращает значение первого найденного в массиве элемента, которое удовлетворяет переданному условию. Если подходящее значение не обнаружено, возвращает undefined


// Поиск объекта по ключу
let team = [{
  'name': 'Bilbo Buggins',
  'race': 'Hobbit',
  'class': 'miner'
},
{
  'name': 'Thorin Oakenshield',
  'race': 'Gnome',
  'class': 'Lider'
},
{
  'name': 'Ori',
  'race': 'Gnome',
  'class': 'scout'
},
{
  'name': 'Gendalf',
  'race': 'Mayar',
  'class': 'mage'
},
{
  'name': 'Ori',
  'race': 'Gnome',
  'class': 'scout'
},
]

console.log(team.find(el => el.race === 'Gnome'))

// Возвращает первый найденный элемент с таким значением