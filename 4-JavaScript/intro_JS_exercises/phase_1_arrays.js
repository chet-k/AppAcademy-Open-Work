Array.prototype.uniq = function() {
    let uniqueArray = [];
    let hashSet = new Set();
    
    this.forEach ( el =>  hashSet.add(el) );

    for (const el of hashSet) uniqueArray.push(el);
    
    return uniqueArray 
};

// my_arr = [1, 2, 5, 3, 3, 4, 4, 4, 5];
// console.log(my_arr.uniq());

Array.prototype.twoSum = function(target = 0) {
    let pairs =  new Map();
    let i = 0;
    let j;
    let k;
    let searching = true;
    while (i < this.length && searching) {
        if (pairs.has(this[i])) {
            j = pairs.get(this[i]);
            k = i;
            searching = false
        }
        pairs.set(target - this[i],  i);
        i += 1;
    }
    let out;
    // 0 is falsy in JS, so must check both j and k before returning undefined
    if (j || k) out = [j, k] 
    return out
};

// my_arr = [2, 3, -9, -2, -3]
// console.log(my_arr.twoSum(-6))