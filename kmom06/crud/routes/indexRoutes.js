const express = require("express");
const router = express.Router();
const bank = require("../src/helpers.js");


router.get("/", (req, res) => {
    // res.send("Hello World root route");
    res.render("../views/pages/index.ejs");
}  );

router.get("/today", (req, res) => {
    let data = {};

    data.today = new Date().toLocaleDateString();

    data.arr = [0, "one", "two", "three", 4, 5, 6];

    res.render("../views/pages/today.ejs", data);
}  );


router.get("/bank", async (req, res) => {
    let data = {};

    data.allAccounts = await bank.showAll();
    // console.log(data.allAccounts[0][0].name);
    res.render("../views/pages/bank.ejs", data);
}  );


router.get("/about", (req, res) => {
    console.log(req.params);
    // res.send("Hello World about route");
    res.render("../views/pages/about.ejs");
}  );

router.get("/create", async (req, res) => {
    let data = {};

    data.title ="Create entry";

    res.render("../views/pages/create.ejs", data);
}
);


router.post("/create", async (req, res) => {
    await bank.insertAccount(req.body);

    res.redirect("/bank");
}
);

router.get("/update/:id", async (req, res) => {
    let data = {};

    data.title = "update";
    console.log(req.params.id);
    let theAccount = await bank.theAccount(req.params.id);

    console.log(data.theAccount);

    data.onlyTheAcount = theAccount[0];

    res.render("pages/update.ejs", data);
}
);

router.post("/update", async (req, res) => {
    await bank.updateAccount(req.body);
    res.redirect("/bank");
}
);


router.get("/delete/:id", async (req, res) => {
    let data = {};

    data.title = "Delete";
    console.log(req.params.id);
    let theAccount = await bank.theAccount(req.params.id);
    // console.log(data.theAccount);

    data.onlyTheAcount = theAccount[0];

    res.render("pages/delete.ejs", data);
}
);
router.post("/delete", async (req, res) => {
    await bank.deleteAccount(req.body.f_userID);
    res.redirect("/bank");
}
);


router.get("/kmom06", async (req, res) => {
    let data = {};

    data.title = "kmom06";


    res.render("pages/kmom06.ejs", data);
}
);

module.exports = router;
