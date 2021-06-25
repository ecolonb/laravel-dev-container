const connection = require("../database/db")

const tesFunction = (req, res)=>{
  console.log(connection)
  return res.json({ok:true})
}

module.exports = {
    tesFunction
}