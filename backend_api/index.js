// console.log("Hello");
const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
    res.send("Hello World!");
});

app.listen(PORT, "0.0.0.0",function(){
    console.log(`Server is running on port http://localhost:${PORT}`);
});