const express = require("express");
const app = express();
const indexRoutes = require("./routes/indexRoutes.js");
//const adminRoutes = require("./routes/adminRoutes.js");

const port = 1337;

app.set("view engine", "ejs");
app.use(express.static("public"));

//för att ha nested object i req.body. används för formulär som den i create.ejs
app.use(express.urlencoded({ extended: true }));

app.use(indexRoutes);


app.listen(port, () => {
    console.log(`Server is running/Lisining at port ${port}`);
}   );
