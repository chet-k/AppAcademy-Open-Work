/*
Write a function that takes three strings - a verb, an adjective, and a noun - 
uppercases and interpolates them into the sentence 
    "We shall VERB the ADJECTIVE NOUN".
Use ES6 template literals.
*/
function madLib(verb, adj, noun) {
    return `We shall ${verb.toUpperCase()} the ${adj.toUpperCase()} ${noun.toUpperCase()}`
}

// console.log(madLib('make','best','guac'));