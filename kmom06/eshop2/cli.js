"use strict";

const readline = require("readline-promise").default;
const helpers = require("./src/helpers");

const r1 = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function exitProgram(exit = 0) {
    console.log("exiting program with code: " + exit);
    process.exit(exit);
}
function showMenu() {
    console.log(`
    Choose something from menu:
    ______________________________________________________________________________________
    |commands <input>                           |  Description                           |
    |___________________________________________|________________________________________|
    |  exit, quit, q, clear                     |  Exits program                         |    
    |                                           |                                        |
    |  menu, help, h                            |  Show this menu                        | 
    |                                           |                                        |
    |  about, 1                                 |  About the Devs                        |
    |                                           |                                        |
    |  log, logs, 2                             |  Show logs                             |
    |  log <number> :defult number is 5         |  Show logs with number                 |
    |                                           |                                        |
    |  product, products, 3                     |  Show products                         |
    |                                           |                                        |
    |  shelf, shelves, 4                        |  Show shelves                          |
    |                                           |                                        |
    |  inv, inventory, 5                        |  Show inventory                        |
    |  inv <filter>                             |  Show inventory with filter            |
    |                                           |                                        |
    |  invadd, inventoryadd, add, 6             |  Add to inventory                      |
    |  invadd <product_id> <shelf_row> <amount> |                                        |
    |  example: invadd 13 test 10               |                                        |
    |                                           |                                        |
    |  invdel <productid> <shelf> <number>      |  Delete from inventory                 |
    |  example: invdel 13 test 10               |                                        |
    |                                           |                                        |
    |  order, orders                            |  Show orders                           |
    |  order <filter>                           |  show orders with filter               |
    |                                           |                                        |
    |  picklist <order_id>                      |  show picklist for order               |
    |                                           |                                        |
    |                                           |                                        |
    |  ship <order_id>                          |  ship order                            |
    |                                           |                                        |
    |___________________________________________|________________________________________|
    
    `);
}

async function main() {
    //const db = await mysql.createConnection(config);
    showMenu();
    r1.setPrompt("Enter input:");
    r1.prompt();

    r1.on("close", exitProgram);
    //r1.on("line", showMenu);

    r1.on("line", async function(input) {
        console.log(input);
        input = input.trim();
        let parts = input.split(" ");
        let res;

        switch (parts[0]) {
            case "quit":
            case "exit":
            case "clear":
            case "q":
                exitProgram();
                break;
            case "menu":
            case "help":
            case "h":
                showMenu();
                break;
            case "about":
            case "1":
                console.log(`About this program: 
                created by:
                Karam Matar and Abduvohid Ilhomov
                akronymer:
                kamt23 and abil23`);
                break;
            case "log":
            case "logs":
            case "2":
                if (parts.length < 2) {
                    res = await helpers.logDetails(5);
                    console.table(res);
                } else {
                    res = await helpers.logDetails(parts[1]);
                    console.table(res);
                }
                break;
            case "product":
            case "products":
            case "3":
                res = await helpers.getProducts();
                console.table(res[0]);
                break;
            case "shelf":
            case "shelves":
            case "4":
                res = await helpers.getShelves();
                console.table(res);
                break;
            case "inv":
            case "inventory":
            case "5":
                if (parts.length < 2) {
                    res = await helpers.getStockShelfProducts();
                    console.log("no filter");
                    console.table(res[0]);
                } else {
                    res = await helpers.getFilteredSearch(parts[1]);

                    console.table(res[0]);
                }
                break;
            case "invadd":
            case "inventoryadd":
            case "add":
            case "6":
                res = await helpers.addToInventory(parts[1], parts[2], parts[3]);
                console.table(res);
                break;
            case "invdel":
                res = await helpers.deleteFromInventory(parts[1], parts[2], parts[3]);
                console.table(res);
                break;
            case "order":
            case "orders":
                if (parts.length < 2) {
                    res = await helpers.getOrderDetailsAndCustomerID();
                    console.table(res);
                } else {
                    res = await helpers.getOrderDetailsAndCustomerIDFilteredById(parts[1]);
                    console.table(res);
                }
                break;
            case "picklist":
                res = await helpers.getPickListItemDetails(parts[1]);
                console.table(res);
                break;
            case "ship":
                res = await helpers.shipOrderByID(parts[1]);
                console.table(res);
                break;
            default:
                showMenu();
                break;
        }
        r1.prompt();
    });
}
main();
