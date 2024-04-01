"use strict";
const mysql = require("promise-mysql");
const config = require("../config/db/bank.json");



async function showAll() {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL get_all();
    `;
    let res = await db.query(sql);

    await db.end();

    return res[0];
}


async function insertAccount(data) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL insert_account(?,?,?);
    `;
    let res = await db.query(sql, [data.f_userID, data.f_name, data.f_balance]);

    await db.end();

    return res;
}

async function theAccount(id) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL get_account(?);
    `;
    let res = await db.query(sql, [id]);

    await db.end();

    return res[0];
}


async function updateAccount(data) {
    const db = await mysql.createConnection(config);

    let sql = `
    UPDATE account SET name = ?, balance = ? WHERE id = ?; 
    `;
    let res = await db.query(sql, [data.f_name, data.f_balance, data.f_userID]);

    await db.end();
    return res;
}


async function deleteAccount(userID) {
    const db = await mysql.createConnection(config);

    let sql = `
    DELETE FROM account WHERE id = ?; 
    `;
    let res = await db.query(sql, [userID]);

    await db.end();
    return res;
}


module.exports = {
    showAll: showAll,
    insertAccount: insertAccount,
    updateAccount: updateAccount,
    theAccount: theAccount,
    deleteAccount: deleteAccount
};
