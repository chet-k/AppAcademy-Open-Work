const nameToTitle = nameStr => {
    return 'Mx. ' + nameStr + ' Jingleheimer Schmidt';
};

const titleize = (nameArr, printCallback) => {
    nameArr.forEach(nameStr => {
        console.log(printCallback(nameStr));
    });
};

// titleize(["Mary", "Brian", "Leo"], nameToTitle)