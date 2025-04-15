const mongoose = require('mongoose');

const productSchema = mongoose.Schema({
    productName:{
        type: String,
        required: true,
        trim: true
    },
    productPrice:{
        type: Number,
        required: true,
        trim: true
    },
    location:{
        type: String,
        required: true,
        trim: true
    },
    speciality:{
        type: String,
        required: true
    },
    farmerId:{
        type: String,
        required: true,
    },
    image:{
        type: String,
        required: true  
    },

});

const Product = mongoose.model('Product',productSchema);

module.exports = Product;