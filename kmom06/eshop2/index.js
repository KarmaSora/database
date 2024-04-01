"use strict";

const path = require("path");
const port = 1337;
const express = require("express");
const app = express();
//OWN:
const middleware = require("./middleware/index.js");
const routeEShop = require("./route/eshop.js");

app.set("view engine", "ejs");

app.use(middleware.logIncomingToConsole);
app.use(express.static(path.join(__dirname, "public")));

//för att ha nested object i req.body. används för formulär som den i create.ejs
app.use(express.urlencoded({ extended: true }));

// makes sure that all /bank and its subroutes are handled by routeBank
app.use("/eShop", routeEShop);


app.get("/", (req, res) => {
    res.redirect("/eShop/index"); // used to redirect user to /bank/balance
}
);


app.listen(port, logStartUpDetailsToConsole);

/**

Log app details to console when starting up.*
@return {void}
*/
function logStartUpDetailsToConsole() {
    let routes = [];

    // Find what routes are supported
    app._router.stack.forEach((middleware) => {
        if (middleware.route) {
            // Routes registered directly on the app
            routes.push(middleware.route);
        } else if (middleware.name === "router") {
            // Routes added as router middleware
            middleware.handle.stack.forEach((handler) => {
                let route;

                route = handler.route;
                route && routes.push(route);
            });
        }
    });

    console.info(`Server is listening on port ${port}`);
    console.info("Available routes are:");
    console.info(routes);
}



// app.use("/bank", routeBank);
