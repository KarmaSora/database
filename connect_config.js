/**
 * To verify that mysql is installed and is working.
 * Create a connection to the database and execute
 * a query without actually using the database.
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("./config.json");

/**
 * Main function.
 * @async
 * @returns void
 */
(async function() {
    const db = await mysql.createConnection(config);

    // rest of code
    let sql = "SELECT 1+1 AS Sum";
    let res = await db.query(sql);

    console.info(res);

    db.end();
})();
