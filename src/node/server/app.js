const express = require("express")

const app = express()


app.use("/", require("./routes/web.js"))
app.use("/api", require("./routes/api.js"))


module.exports = app