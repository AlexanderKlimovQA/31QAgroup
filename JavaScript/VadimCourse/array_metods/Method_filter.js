// Метод filter() создаёт новый массив со всеми элементами, прошедшими проверку, задаваемую в передаваемой функции.


// Находим все слова в массиве, длина которых больше 2 букв

const arr = ['Hi', 'Hello', 'Pr', 'Privet', 'ad', 'adios'];
const result = arr.filter(el => el.length > 2);
console.log(result)


// Использование filter() для создания массива, который удалит все числа меньше 10, а те, что больше, оставит
const only_big_numbers = function (value) {
    return value >= 10;
}

let filtered = [12, 9, 10, 7, -1, 130, 44].filter(only_big_numbers);
console.log(filtered)


// Возвращение только простых чисел в массив
const numbers_array = [-3, -2, -12, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 18, 19, 96, 97]

const prime_numbers = function (num) {
    for (let i = 2; num > i; i++) {
        if (num % i == 0) {
            return false;
        }
    }
    return num > 1;
}

console.log(numbers_array.filter(prime_numbers));


// Фильтрация неверных записей в JSON
// В следующем примере метод filter() используется для создания отфильтрованного JSON-объекта, все элементы которого содержат ненулевое числовое /// поле id.
let arr_id = [
    { id: 15 },
    { id: 1 },
    { id: 0 },
    { id: -1 },
    { id: -25 },
    { id: NaN },
    { id: '1' },
    { id: 'asd' },
    { id: 44 },
    { id: 11 },
    { id: null },
    { id: 12.2 },
    {},
    { id: 'undefined' },
]

let invalid_value = 0;

const filter_by_ID = function (item) {
    if (Number.isFinite(item.id) && item.id !== 0) {
        return true;
    }
    invalid_value++
    return false;
}

let arr_id_filtered = arr_id.filter(filter_by_ID)
console.log('Отфильтрованный массив =', arr_id_filtered);
console.log('Количество неправильных элементов массива =', invalid_value)


// Поиск в массиве
// В следующем примере filter() используется для фильтрации содержимого массива на основе входных данных.
const cities = ['Санкт-Петербург', 'Сан-Франциско', 'Сан-Агустин', 'Нью-Йорк', 'Нью-Албани', 'Москва', 'Сидней', 'Сан-Мартин', 'Минск', 'Сиэтл']

const filter_cities = (arr, query) => {
    return arr.filter(el => el.toLowerCase().indexOf(query.toLowerCase()) !== -1)
}

console.log(filter_cities(cities, 'сан'));
console.log(filter_cities(cities, 'Нью'));
console.log(filter_cities(cities, 'си'));
console.log(filter_cities(cities, 'мо'));
console.log(filter_cities(cities, 'ин'));