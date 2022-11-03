const fs = require('fs');

let users_info = JSON.parse(fs.readFileSync('C:/Users/PC/Testing/group_30_free/JavaScript/JS_HW_3/JS_HW_3_star_2_1/task2.json'));
console.log(users_info);


      // Первый способ
// const find_unique_users = (arr) => {
//     let unique_users = [];
//     arr.forEach(el => {
//         if (!unique_users.includes(JSON.stringify(el))) unique_users.push(JSON.stringify(el))
//     })
//     return unique_users.map(el => JSON.parse(el))
// }

// console.log(find_unique_users(users_info))
// console.log(find_unique_users(users_info).length)


      // Второй способ
let uniq_users = Array.from(new Set(users_info.map(el => JSON.stringify(el)))).map(el => JSON.parse(el));

console.log(uniq_users);
console.log(uniq_users.length);