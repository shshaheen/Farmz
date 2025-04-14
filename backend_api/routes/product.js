const express = require('express');
const Product = require('../models/product');

const productRouter = express.Router();

productRouter.post('/api/add-product', async (req, res) => {
    try {
        const {productName, productPrice,location, speciality, farmerId,image} = req.body;
        const product = new Product({productName, productPrice,location, speciality, farmerId,image});
        await product.save();
        return res.status(201).send(product);
    } catch (e) {
        res.status(500).json({error: e.message});
    }
});

// New route for retrieving products by category
productRouter.get('/api/products-by-category/:speciality', async(req, res) =>{
    try {
        const {speciality} = req.params;
        const products = await Product.find({speciality});
        if(!products || products.length == 0){
            return res.status(404).json({msg:"Product not found"});
        }else{
            return res.status(200).json(products)
        }
    } catch (e) {
        res.status(500).json({error: e.message});
    }
});


productRouter.get('/api/get-products', async (req, res) => {
    try {
        const products = await Product.find({});
        if(!products || products.length == 0){
            return res.status(404).json({msg:"Product not found"});
        }else{
            return res.status(200).json(products)
        }
    } catch (e) {
        res.status(500).json({error: e.message});
    }
})
module.exports = productRouter;