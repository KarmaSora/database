/**   kommer synas i terminalen
 * Route for bank.
 */
"use strict";

const express = require("express");
const router  = express.Router();
const eshop    = require("../src/helpers.js");


router.get("/", (req, res) => {
    res.redirect("/eShop/index");
}
);

router.get("/index", (req, res) => {
    let data = {
        title: "Welcome | The Shop"
    };

    res.render("eShop/index.ejs", data);
});

router.get("/product", async (req, res) => {
    let data = {
        title: "products | The shop"
    };

    data.product = await eshop.getproductsAndCategories();
    console.log(data.product[0]);
    res.render("eShop/product.ejs", data);
});


router.get("/category", async (req, res) => {
    let data = {
        title: "Category | The shop"
    };

    data.categories = await eshop.getCategories();

    res.render("eShop/category.ejs", data);
});

router.get("/about", async (req, res) => {
    let data = {
        title: "About | The shop"
    };

    res.render("eShop/about.ejs", data);
});


router.get("/createProduct", async (req, res) => {
    let data = {
        title: "createProduct | The shop"
    };

    data.rowCounter = await eshop.getRowCount();
    console.log(data.rowCounter[0].row_count);
    res.render("eShop/createProduct.ejs", data);
});


router.post("/createProduct", async (req, res) => {
    console.log(req.body);


    await eshop.insertProduct(req.body);
    res.redirect("./product");
});


router.get("/updateProduct/:id", async (req, res) => {
    let data = {
        title: "updateProduct | The shop"
    };

    data.theProduct = await eshop.getProductByID(req.params.id);
    // console.log(data.theProduct);
    // console.log(data.theProduct.name);

    res.render("eShop/updateProduct", data);
});

router.post("/updateProduct", async (req, res) => {
    console.log(req.body);

    await eshop.updateProduct(req.body);
    res.redirect("./product");
});



router.get("/deleteProduct/:id", async (req, res) => {
    let data = {
        title: "updateProduct | The shop"
    };

    data.theProduct = await eshop.getProductByID(req.params.id);
    // console.log(data.theProduct);
    // console.log(data.theProduct.name);

    res.render("eShop/deleteProduct", data);
});


router.post("/deleteProduct", async (req, res) => {
    console.log(req.body);

    await eshop.deleteProductByID(req.body.product_id);
    res.redirect("./product");
});




router.get("/customer", async (req, res) => {
    let data = {
        title: "Customers | The shop"
    };

    data.customers = await eshop.getCustomers();
    res.render("eShop/customer.ejs", data );
});




router.get("/order", async (req, res) => {
    let data = {
        title: "Orders | The shop"
    };

    data.orders = await eshop.getAllOrdersAndCustomers();
    console.log(data.orders);
    res.render("eShop/order.ejs", data );
});

router.get("/order/create",  (req, res) => {
    res.redirect("../customer" );
});

router.get("/order/create/:id", async (req, res) => {
    let data = {
        title: "Customer Orders | The shop"
    };

    data.orders = await eshop.getCustomerOrders(req.params.id);
    data.customers_id = req.params.id;
    console.log(data.customers_id);
    res.render("eShop/customerOrder.ejs", data );
});


router.get("/pickList/stockShelves/:order_id", async (req, res) => {
    let data = {
        title: "The List | The shop"
    };

    data.theShelves = await eshop.getproductsAndCategories();
    console.log(data.theShelves);
    data.order_id = req.params.order_id;
    // console.log("trying to log params: " + req.params.order_id);

    res.render("eShop/stockshelves.ejs", data );
});

router.get("/pickList/:order_id", async (req, res) => {
    let data = {
        title: "The List | The shop"
    };

    data.order_id = req.params.order_id;
    data.pickList = await eshop.getPickListItemDetails(req.params.order_id);
    console.log(data.pickList);
    // console.log("trying to log params: " + req.params.order_id);

    res.render("eShop/pickList.ejs", data );
});

router.post("/pickList", async (req, res) => {
    console.log(req.body);

    await eshop.additemToPickList(
        req.body
    );
    res.redirect("./pickList/"+ req.body.order_id);
});


router.post("/order", async (req, res) => {
    console.log(req.body);
    await eshop.createOrder(
        req.body.customer_id,
    );
    res.redirect("./order");
} );


router.post("/confirmedOrder", async (req, res) => {
    console.log(req.body);
    await eshop.updateStatusOrder(
        req.body.order_id
    );
    res.redirect("./order");
} );



module.exports = router;
