/*
Define a function fizzBuzz(array) that takes an array and returns a new array 
of every number in the array that is divisible by either 3 or 5, but not both.
*/

const fizzBuzz = arr => {
    return arr.filter (n => {
        let div3 = n % 3 === 0;
        let div5 = n % 5 === 0;
        return (div3 || div5) && !(div3 && div5);
    });
};

// console.log(fizzBuzz([1, 2, 3, 4, 5, 6, 7, 8, 15, 16, 18]))
// => [ 3, 5, 6, 18 ]