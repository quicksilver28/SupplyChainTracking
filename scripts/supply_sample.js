// Contracts
const SupplyChain = artifacts.require("SupplyChain")

module.exports = async function (callback) {
    try {
        // Fetch accounts from wallet - these are unlocked
        const accounts = await web3.eth.getAccounts()

        // Fetch the deployed exchange
        const supply = await SupplyChain.deployed()
        console.log('SupplyChain fetched', supply.address)

        var productId = 0

        console.log("Adding new item...")
        var productName = "13 x 8 Photo Frame (Black)"
        var manufacturedDate = new Date().toLocaleString() //new Date().toISOString().slice(0, 10)
        await supply.addProduct(productName, manufacturedDate)
        console.log(`Added product ${productName} on ${manufacturedDate}`)
        console.log("")

        console.log("Updating item logistics ")
        //let currentLocation = navigator.geolocation.getCurrentPosition(getLocation);
        var currentLocation = "17.439421526638238, 78.37571028379635"
        var currentDate = new Date().toLocaleString() //new Date().toISOString().slice(0, 10)
        await supply.addState(productId, currentDate, currentLocation)
        console.log(`Product Id ${productId} is at location ${currentLocation} on ${currentDate}`)
        console.log("")
        productId += 1

        console.log("Adding new item...")
        var productName = "Cat Lamp"
        var manufacturedDate = new Date().toLocaleString() //new Date().toISOString().slice(0, 10)
        await supply.addProduct(productName, manufacturedDate)
        console.log(`Added product ${productName} on ${manufacturedDate}`)
        console.log("")

        console.log("Current Items:")

        for (var i = 0; i <= productId; i++) {
            var item1 = await supply.searchProduct(i)
            console.log(`${item1}`)
            console.log("")
        }

        /*var item1 = await supply.searchProduct(0)
        console.log(`${item1}`)
        console.log("")
        var item2 = await supply.searchProduct(1)
        console.log(`${item2}`)*/
    }


    catch (error) {
        console.log(error)
    }

    callback()
}