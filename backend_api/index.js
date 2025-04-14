const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;
const mongoose = require("mongoose");
const farmerAuthRouter = require("./routes/farmer");
const consumerAuthRouter = require("./routes/consumer");
const productRouter = require("./routes/product");
require('dotenv').config();


app.use(express.json());
app.use(farmerAuthRouter);
app.use(consumerAuthRouter);
app.use(productRouter);
const DB = process.env.MONGO_URI;
mongoose.connect(DB).then(
    ()=>console.log("Connected to MongoDB..!")).
    catch(error => console.error("MongoDB connection error: " + error));


app.listen(PORT, "0.0.0.0",function(){
    console.log(`Server is running on port http://localhost:${PORT}`);
});