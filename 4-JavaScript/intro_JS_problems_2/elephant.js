/*
First write a constructor function for an elephant. 
Each elephant should have a name, height (in inches), and array of tricks in 
gerund form (e.g. "painting a picture" rather than "paint a picture").

Next write a few prototype functions that will be shared among all elephants:

1. Elephant.prototype.trumpet: should print "(name) the elephant goes 
'phrRRRRRRRRRRR!!!!!!!'"
2. Elephant.prototype.grow: should increase the elephant's height by 12 inches
3. Elephant.prototype.addTrick(trick): add a new trick to their existing repertoire
4. Elephant.prototype.play: print out a random trick, e.g. "(name) is (trick)!"
Hint: look up some JS Math methods!
Make sure to create an elephant and test all of these functions out on them method style!
*/

class Elephant {
    constructor(name, height_in = 96, tricks = []) {
        this.name = name;
        this.height_in = height_in;
        this.tricks = tricks;
    }
    trumpet() {
        console.log(this.name + " the elephant goes 'phrRRRRRRRRRRR!!!!!!!'");
    }
    grow() {
        this.height_in += 12;
    }
    addTrick(trick) {
        this.tricks.push(trick);
    }
    play() {
        let trick_id = Math.floor(Math.random() * this.tricks.length);
        console.log(this.name + " is " + this.tricks[trick_id] + "!");
    }
};



let dumbo = new Elephant("Dumbo");
console.log(dumbo);
dumbo.trumpet();

console.log(dumbo.name + 'height: ' + dumbo.height_in);
console.log('growing ' + dumbo.name);
dumbo.grow();
console.log(dumbo.name + 'height: ' + dumbo.height_in);
console.log('growing ' + dumbo.name);
dumbo.grow();
console.log(dumbo.name + 'height: ' + dumbo.height_in);
console.log('growing ' + dumbo.name);
dumbo.grow();
console.log(dumbo.name + 'height: ' + dumbo.height_in);

dumbo.addTrick('standing on an egg')
dumbo.addTrick('balancing on a ball')
dumbo.addTrick('painting')
dumbo.play();
dumbo.play();
dumbo.play();
dumbo.play();
dumbo.play();
dumbo.play();
dumbo.play();


let ellie = new Elephant("Ellie", 185, ["giving human friends a ride", "playing hide and seek"]);
let charlie = new Elephant("Charlie", 200, ["painting pictures", "spraying water for a slip and slide"]);
let kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
let micah = new Elephant("Micah", 143, ["trotting", "playing tic tac toe", "doing elephant ballet"]);

let herd = [ellie, charlie, kate, micah, dumbo];

const paradeHelper = (eleph) => {
    console.log(eleph.name + ' is trotting by!')
};

herd.forEach(paradeHelper);

// PRE-ES2015!
/* 
function Elephant(name, height_in = 96, tricks = []) {
    this.name = name;
    this.height_in = height_in;
    this.tricks = tricks;
};

Elephant.prototype.trumpet = function () {
    console.log(this.name + " the elephant goes 'phrRRRRRRRRRRR!!!!!!!'")
};

Elephant.prototype.grow = function () {
    this.height_in += 12;
};

Elephant.prototype.addTrick = function (trick) {
    this.tricks.push(trick)
}

Elephant.prototype.play = function () {
    let trick_id = Math.floor(Math.random() * this.tricks.length);
    console.log(this.name + " is " + this.tricks[trick_id] + "!");
}
*/