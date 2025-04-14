const express = require('express');
const User = require('../models/consumer');
const bcrypt = require('bcryptjs');
const consumerAuthRouter= express.Router();
const jwt = require('jsonwebtoken');

//End point for sign up api
consumerAuthRouter.post('/api/consumer/signup',async (req,res)=>{
try {
    const {username, email,village, password} = req.body; 
    const existingEmail = await User.findOne({email});
    if (existingEmail) {
        return res.status(400).json({message:"User with same email already exists"});
    }
    else{
        const hashedPassword = await bcrypt.hash(password, 8);
        const newUser = new User({username, email,village, password: hashedPassword});
        await newUser.save();
        res.status(201).json({message:"User registered successfully"});
    }
} catch (error) {
    res.status(500).json({error: error.message});
}
});



//End point for sign in api
consumerAuthRouter.post('/api/consumer/signin', async (req,res)=>{
try {
    const {email, password: inputPassword} = req.body;
    const user = await User.findOne({email});
    if (!user) {
        return res.status(400).json({message:"User not found"});
    }
    const isMatch = await bcrypt.compare(inputPassword, user.password);
    if (!isMatch) {
        return res.status(400).json({message:"Invalid credentials"});
    }
    const token = jwt.sign({id: user._id}, "passwordKey");
    // remove sensitive information
    const {password, ...userWithoutPassword} = user._doc;
    
    // send the response
    res.json({token,consumer: userWithoutPassword});
} catch (error) {
    res.status(500).json({error: error.message});
}
});




module.exports = consumerAuthRouter;