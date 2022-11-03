// Метод JSON.stringify() преобразует значение JavaScript в строку JSON.

let user = {
  "name": "Leanne Graham",
  "username": "Bret",
  "email": "Sincere@april.biz",
  "address": {
      "street": "Kulas Light",
      "suite": "Apt. 556",
      "city": "Gwenborough",
      "zipcode": "92998-3874",
      "geo": {
          "lat": "-37.3159",
          "lng": "81.1496"
      }
  },
  "phone": "1-770-736-8031 x56442",
  "website": "hildegard.org",
  "company": {
      "name": "Romaguera-Crona",
      "catchPhrase": "Multi-layered client-server neural-net",
      "bs": "harness real-time e-markets"
  }
}
console.log(user)

let string_user = JSON.stringify(user)
console.log(string_user)



// Метод JSON.parse() преобразует строку JSON в объект JS

let parse_user = JSON.parse(string_user)
console.log(parse_user)