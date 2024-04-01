"use strict";
const mysql = require("promise-mysql");
const config = require("../config/db/eshop.json");
// const { query } = require("express");


async function getCustomers() {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL get_customers();
    `;
    let res = await db.query(sql);

    await db.end();

    return res[0];
}



async function getProducts() {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL get_products();
    `;
    let res = await db.query(sql);

    await db.end();

    return res;
}


async function getCategories() {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL get_category();
    `;
    let res = await db.query(sql);

    await db.end();

    return res;
}

async function getproductsAndCategories() {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL get_product_and_its_category();
    `;
    let res = await db.query(sql);

    await db.end();

    return res;
}



async function insertProduct(data) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL insert_product(?,?,?);
    `;
    let res = await db.query(sql, [data.product_id, data.name, data.price]);

    await db.end();

    return res;
}


async function getProductByID(productID) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL get_product_by_id(?);
    `;
    let res = await db.query(sql, [productID]);

    await db.end();

    return res[0][0];
}



async function updateProduct(data) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL update_product(?,?,?);
    `;
    let res = await db.query(sql, [ data.name, data.price, data.product_id]);

    await db.end();
    return res;
}


async function deleteProductByID(productID) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL delete_product(?);
    `;
    let res = await db.query(sql, [productID]);

    await db.end();

    return res;
}

//
// cli.js
//

async function logDetails(limit) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL log_details(?);
    `;
    let res = await db.query(sql, [limit]);

    await db.end();

    return res[0];
}


async function getShelves() {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL get_shelves();
    `;
    let res = await db.query(sql);

    await db.end();

    return res[0];
}

async function getFilteredSearch(theFilter) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL get_filtered_inventory(?);
    `;
    let res = await db.query(sql, [`%${theFilter}%`]);


    return res;
}

async function addToInventory(productID, shelfID, amount) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL add_to_inventory(?,?,?);
    `;
    let res = await db.query(sql, [productID, shelfID, amount]);

    await db.end();

    return res;
}


async function deleteFromInventory(productID, shelfID, amount) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL delete_inventory(?,?,?);
    `;
    let res = await db.query(sql, [productID, shelfID, amount]);

    await db.end();

    return res;
}



async function getStockShelfProducts() {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL get_stock_shelf_products();
    `;
    let res = await db.query(sql);

    await db.end();

    return res;
}

async function getRowCount() {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL get_products_row_count();
    `;
    let res = await db.query(sql);

    await db.end();

    return res[0];
}


//
// KMOM=6
//



// async function getCustomers() {
//     const db = await mysql.createConnection(config);

//     let sql = `
//     CALL get_all_customers();
//     `;
//     let res = await db.query(sql);

//     await db.end();

//     return res[0];
// }


async function getAllOrdersAndCustomers() {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL get_all_orders_and_customers();
    `;
    let res = await db.query(sql);

    await db.end();

    return res[0];
}


async function getCustomerOrders(customerID) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL get_customer_orders(?);
    `;
    let res = await db.query(sql, [customerID]);

    await db.end();

    return res[0];
}




async function createOrder(customerID) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL create_order(?);
    `;
    let res = await db.query(sql, [customerID]);

    await db.end();

    return res;
}



async function getPickListItemDetails(orderID) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL pick_list_item_details(?);
    `;
    let res = await db.query(sql, [orderID]);

    await db.end();

    return res[0];
}

async function additemToPickList(data) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL add_item_to_picklist(?, ?, ?);
    `;

    let res = await db.query(sql, [data.order_id, data.product_id, data.number_to_buy]);

    await db.end();

    return res;
}

async function updateStatusOrder(orderID) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL updateOrderDate(?);
    `;

    let res = await db.query(sql, [orderID]);

    await db.end();

    return res;
}


// kmom06 cli.js



async function getOrderDetailsAndCustomerID() {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL get_order_details_and_customers_id();
    `;
    let res = await db.query(sql, []);

    await db.end();

    return res[0];
}





async function getOrderDetailsAndCustomerIDFilteredById(theFilter) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL get_orders_and_customers_filtered_by_id(?);
    `;
    let res = await db.query(sql, [theFilter]);

    await db.end();

    return res[0];
}

async function shipOrderByID(orderID) {
    const db = await mysql.createConnection(config);

    let sql = `
    CALL ship_order_by_id(?);
    `;
    let res = await db.query(sql, [orderID]);

    await db.end();

    return res[0];
}


module.exports = {
    getCustomers: getCustomers,
    getProducts: getProducts,
    getCategories: getCategories,
    getproductsAndCategories: getproductsAndCategories,
    insertProduct: insertProduct,
    updateProduct: updateProduct,
    getProductByID: getProductByID,
    deleteProductByID: deleteProductByID,
    logDetails: logDetails,
    getShelves: getShelves,
    getFilteredSearch: getFilteredSearch,
    addToInventory: addToInventory,
    deleteFromInventory: deleteFromInventory,
    getStockShelfProducts: getStockShelfProducts,
    getRowCount: getRowCount,
    // getCustomers: getCustomers,
    getAllOrdersAndCustomers: getAllOrdersAndCustomers,
    getCustomerOrders: getCustomerOrders,
    createOrder: createOrder,
    getPickListItemDetails: getPickListItemDetails,
    additemToPickList: additemToPickList,
    updateStatusOrder: updateStatusOrder,
    getOrderDetailsAndCustomerID: getOrderDetailsAndCustomerID,
    getOrderDetailsAndCustomerIDFilteredById: getOrderDetailsAndCustomerIDFilteredById,
    shipOrderByID: shipOrderByID

};
