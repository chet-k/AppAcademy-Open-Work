const nameToTitle = nameStr => {
    return 'Mx. ' + nameStr + ' Jingleheimer Schmidt';
};

const titleize = (nameArr, printCallback) => {
    nameArr.forEach(nameStr => {
        console.log(printCallback(nameStr));
    });
};

// console.log(titleize(["Mary", "Brian", "Leo"], nameToTitle))