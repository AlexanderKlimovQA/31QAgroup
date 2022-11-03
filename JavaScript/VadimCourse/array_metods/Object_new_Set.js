// Объекты Set позволяют вам сохранять уникальные значения любого типа, как примитивы, так и другие типы объектов. Значение элемента в Set может присутствовать только в одном экземпляре, что обеспечивает его уникальность в коллекции Set.

let arr = ['Moscow', 'SPB', 'EKB', 'Cheliabinsk', 'SPB', 'Kazan', 'Moscow']

let uniq_set = new Set(arr)
console.log(uniq_set)

let arr2 = new Set (['Cat', 'Dog', 'Cat'])
console.log(arr2)


// Преобразование к массиву с помощью Array.from
let uniq_arr = Array.from(new Set(arr))
console.log(uniq_arr)

