// Метод includes() определяет, содержит ли массив определённый элемент, возвращая в зависимости от этого true или false.


const array1 = ['London', 'Paris', 'Moscow', 'Kiev', 'Washington'];

console.log(array1.includes('London'));
console.log(array1.includes('Minsk'));

// Метод принимает два параметра
console.log(['Apple', 'Orange', 'Pineapple'].includes('Pineapple', 1)) // Первое значение - искомый элемент, второй - индекс с которого начинается поиск
console.log(['Apple', 'Orange', 'Pineapple'].includes('Pineapple', 3)) 
