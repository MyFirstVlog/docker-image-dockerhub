

let times = 0;

const syncDB = () => {
    times ++;
    console.log('Tick every 5 deconds multiple', times);

    return times;
}

module.exports = {
    syncDB
}