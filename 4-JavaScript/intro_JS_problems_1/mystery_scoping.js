function mysteryScoping1() {
    var x = 'out of block';
    if (true) {
        var x = 'in block';
        console.log(x);
    }
    console.log(x);
}
// in block
// in block


function mysteryScoping2() {
    const x = 'out of block';
    if (true) {
        const x = 'in block';
        console.log(x);
    }
    console.log(x);
}
// in block
// out of block
// you *can* declare constants of the same names in nested scopes


function mysteryScoping3() {
    const x = 'out of block';
    if (true) {
        var x = 'in block';
        console.log(x);
    }
    console.log(x);
}
// trying to redeclare a constant with a var or let by the same 
// name will raise an error.

function mysteryScoping4() {
    let x = 'out of block';
    if (true) {
        let x = 'in block';
        console.log(x);
    }
    console.log(x);
}
// in block
// out of block
// remember *let* is block scoped, while *var* is function scoped

function mysteryScoping5() {
    let x = 'out of block';
    if (true) {
        let x = 'in block';
        console.log(x);
    }
    // let x = 'out of block again'; // causes error
    x = 'out of block again'; // no error, re-assigning
    console.log(x);
}
// raises error
// can't declare x again in same scope


// mysteryScoping1()
// mysteryScoping2()
// mysteryScoping3()
// mysteryScoping4()
// mysteryScoping5()