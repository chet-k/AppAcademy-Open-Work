Array.prototype.myEach = function (func) {
    for (let i = 0; i < this.length; i++) {
        func(this[i]);
    }
};

// let myArr = [1, 2, 3];
// myArr.myEach(el => console.log(el))

Array.prototype.myMap = function (func) {
    
};