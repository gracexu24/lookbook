const express = require("express");
const mysql = require("mysql2");

const db = mysql.createConnection({
    host: "viaduct.proxy.rlwy.net",
    user: "root",
    password: "GbBcfVxqlcExTsAhdKrcYAZraoRoAXYR",
    database: "railway",
    port: "3306"
});

db.connect((err) => {
    if (err) throw err;
    console.log("Database connected..railway?!");

});

const app = express();
//check for port or use local port 
const port = process.env.PORT || 5001;"5001";
const cors = require("cors");
app.use(cors());

app.get("/createdb", (req, res) => 
    {  let sql = "CREATE DATABASE lookbook";  
        db.query(sql, (err) => 
            {   if (err) {throw err;}    
                res.send("Database created");  
            }
        );
    }
);

app.listen(port, () => 
    {  console.log(`Server started on port ${port}`);}
);

