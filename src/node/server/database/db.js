// imprt db

var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'mysqlhost',
  user     : 'laravel',
  password : 'my-secret',
  database : 'laravel',
  port: 13306
});
 
connection.connect();
 
// connection.query('SELECT 1 + 1 AS solution', function (error, results, fields) {
//   if (error) throw error;
//   console.log('The solution is: ', results[0].solution);
// });
 
// connection.end();


module.exports = connection