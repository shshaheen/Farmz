const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    username: {
        type: String,
        required: true,
        trim: true
    },
    email: {
        type: String,
        required: true,
        trim: true,
        validate:{
            validator: function(value) {
                const result = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return result.test(value);
            },
            message: 'Please enter a valid email address'
        }
    },
    village:{
        type: String,
        required: true,
    },

    password: {
        type: String,
        required: true,
        validate:{
            validator:(value)=>{
                //check if password is at least 8 characters long,
                return value.length>=8;
            },
            message: 'Password must be at least 8 characters long'
        }
    },

});

const Consumer = mongoose.model('consumers', userSchema);
module.exports = Consumer;