/*
1. order should be initialized to a starting order (e.g. scrambled eggs and bacon) 
    before the anonymous function can do its work.
2. The closure should capture/close over order
3. What should the return value of dinerBreakfast be?
4. Which function should take in the additional food as an argument?
*/

const dinerBreakfast = () => {
    
    let order = "I'd like cheesy scrambled eggs please.";
    
    console.log(order);

    return function (food) {
        order = `${order.slice(0, order.length - 8)} and ${food} please.`;
        console.log(order);
    };
};

let myOrder = dinerBreakfast();
myOrder("pancakes")
myOrder("bacon")

/*
Get it now. On the call 'myOrder('pancakes')', we're *invoking* 
the anonymous closure. The outer function has returned, but the inner function
still has access to the function's variables.

From http://javascriptissexy.com/understand-javascript-closures-with-ease/

One of the most important and ticklish features with closures is that the inner
 function still has access to the outer function’s variables even after the 
 outer function has returned. Yep, you read that correctly. When functions in 
 JavaScript execute, they use the same scope chain that was in effect when they 
 were created. This means that even after the outer function has returned, the 
 inner function still has access to the outer function’s variables. Therefore, 
 you can call the inner function later in your program.

*/