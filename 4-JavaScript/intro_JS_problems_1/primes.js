const isPrime = n => {
    if (n < 2) {
        return false;
    } else {
        for(let i = 2; i <= n/2; i++) {
            if (n % i === 0) return false;
        };
        return true;
    };
};

const firstNPrimes = n => {
    let out = [];
    let i = 0;
    while (out.length < n) {
        if (isPrime(i)) out.push(i);
        i += 1
    };
    return out;
};

const sumOfNPrimes = n => {
    let primes = firstNPrimes(n);
    return primes.reduce((sum, currentValue) => {
        return sum + currentValue;
    }, 0);
};

// console.log(isPrime(1)) // => false
// console.log(isPrime(2)) // => true
// console.log(isPrime(10)) // => false
// console.log(isPrime(15485863)) // => true
// console.log(isPrime(3548563)) // => false

console.log(firstNPrimes(5)); // => [ 2, 3, 5, 7, 11 ]
console.log(sumOfNPrimes(5)); // => 28
console.log(firstNPrimes(0)); // => [ ]
console.log(sumOfNPrimes(0)); // => 0