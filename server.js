const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");
const bodyParser = require("body-parser");


const db = mysql.createConnection({
    host: "viaduct.proxy.rlwy.net",
    user: "root",
    password: "jDFjwbNHaacVMTHojYcizTWOERgoVdik",
    database: "railway",
    port: "22511"

});


//MUST CREATE THE DATABASE FIRST
db.connect((err) => {
    if (err) {
        console.log("ERROR!!!", err)
        throw err
    };

    console.log("Database connected!!!");

    const createUsersTable = `
        CREATE TABLE IF NOT EXISTS users (  
            id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
            username VARCHAR(255) NOT NULL
        )`

    const createPostsTable = `
        CREATE TABLE IF NOT EXISTS posts (
            id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
            image VARCHAR(255),
            details VARCHAR(500), 
            caption VARCHAR(500),
            username VARCHAR(255)
        )`;

    db.query(createUsersTable);
    db.query(createPostsTable);

    console.log("Tables created (if not already).");

})

const app = express();
const port = process.env.PORT || 5001;
app.use(cors());

app.get("/", (req, res) => {
    console.log("route hit")
    res.send('hi')
})

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

app.get("/showUsers", (req, res) => {
    db.query("SELECT * FROM users", (err, result) => {
        if (err) return err;
        res.send(result);
    })
});

app.get("/showPosts", (req, res) => {
    db.query("SELECT * FROM posts", (err, result) => {
        if (err) return err;
        res.send(result);
    })
});

app.get("/addUser/:name", (req, res) => {
    const name = req.params.name;

    // Use parameterized query to prevent SQL Injection
    const query = "INSERT INTO users (username) VALUES (?)";

    db.query(query, [name], (err, result) => {
        if (err) {
            console.error("Error adding user:", err);
            return res.status(500).send("Error adding user");
        }
        res.send("User added successfully!");
    });
});


app.post("/addPost", (req, res) => {
    const { image, details, username, caption } = req.body;

    if (!image || !details || !username || !caption ) {
        return res.status(400).send("Missing required fields");
    }


    const query = "INSERT INTO posts (image, details, username, caption) VALUES (?, ?, ?, ?)";
    db.query(query, [image, details, username, caption], (err, result) => {
        if (err) {
            console.error("Error inserting post:", err);
            return res.status(500).send("Error adding post");
        }

        // Check if the insertion was successful
        if (result.affectedRows === 0) {
            console.log("Failed to add post.");
        }


        res.send("Post added successfully!");
    });
});





/*
db.connect((err) => {
    if (err) throw err;
    console.log("Database connected..railway?!");

    //I had to get ride of this to create the database and then added it back
    // Create tables
    const createUsersTable = `
        CREATE TABLE IF NOT EXISTS Users (
            id INT AUTO_INCREMENT PRIMARY KEY,
            username VARCHAR(255) NOT NULL UNIQUE
        )`;

    const createCafesTable = `
        CREATE TABLE IF NOT EXISTS Cafes (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL UNIQUE
        )`;
    
    //stores pairs (user, cafe) to relate the two other tables to each other. 
    // Can also search for all cafes a user liked
    //many to many relationship 
    //only used if there is a like relationship 
    const createUserCafesTable = `
        CREATE TABLE IF NOT EXISTS UserCafes (
            user_id INT NOT NULL,
            cafe_id INT NOT NULL,
            PRIMARY KEY (user_id, cafe_id),
            FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
            FOREIGN KEY (cafe_id) REFERENCES Cafes(id) ON DELETE CASCADE
        )`;

    db.query(createUsersTable);
    db.query(createCafesTable);
    db.query(createUserCafesTable);


    console.log("Tables created (if not already).");
});

const app = express();
//check for port or use local port 
const port = process.env.PORT || 5001;"5001";
const cors = require("cors");
app.use(cors());

app.get("/createdb", (req, res) => 
    {  let sql = "CREATE DATABASE liked_cafes";  
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

app.get("/showUsers", (req, res) => {
    db.query("SELECT * FROM Users", (err, result) => {
        if (err) return err;
        res.send(result);
    })
});

app.get("/showCafes", (req, res) => {
    db.query("SELECT * FROM Cafes", (err, result) => {
        if (err) return err;
        res.send(result);
    })
});

app.post("/showUserCafes", (req, res) => {
    db.query("SELECT * FROM UserCafes", (err, result) => {
        if (err) return err;
        res.send(result);
    })
});

app.get("/addUser/:name", (req, res) => {
    console.log("Route hit!"); 
    const name = req.params.name;

    const query = "INSERT IGNORE INTO Users (username) VALUES (?)";
    db.query(query,[name], (err, result) => {
        if (err) return res.send(err);
        res.send("User added successfully!");
    });
});

app.get("/addCafe/:cafe", (req, res) => {
    const cafe = req.params.cafe;
    const query = "INSERT IGNORE INTO Cafes (name) Values (?)"
    db.query(query, cafe, (err, result) => {
        if (err) throw err;
        res.send("Cafe added successfully!");
    })git
});

// Like a cafe for a user --> use the name of the user and the name of the cafe
app.get("/users/:username/cafes/:cafename", (req, res) => {
    const userName = req.params.username;
    const cafeName = req.params.cafename;

    // Query to get user_id from username
    const getUserIdQuery = "SELECT id FROM Users WHERE username = ?";
    db.query(getUserIdQuery, [userName], (err, userResult) => {
        if (err) {
            console.error("Error fetching user ID:", err);
            return res.status(500).send("Database error");
        }
        if (userResult.length === 0) {
            return res.status(404).send("User not found");
        }
        const userId = userResult[0].id;

        // Query to get cafe_id from cafeName
        const getCafeIdQuery = "SELECT id FROM Cafes WHERE name = ?";
        db.query(getCafeIdQuery, [cafeName], (err, cafeResult) => {
            if (err) {
                console.error("Error fetching cafe ID:", err);
                return res.status(500).send("Database error");
            }
            if (cafeResult.length === 0) {
                return res.status(404).send("Cafe not found");
            }
            const cafeId = cafeResult[0].id;

            // Insert into UserCafes table
            const insertQuery = "INSERT IGNORE INTO UserCafes (user_id, cafe_id) VALUES (?, ?)";
            db.query(insertQuery, [userId, cafeId], (err, result) => {
                if (err) {
                    console.error("Error inserting into UserCafes:", err);
                    return res.status(500).send("Failed to like cafe");
                }
                res.send(`User '${userName}' liked cafe '${cafeName}'`);
            });
        });
    });
});

// Get liked cafes for a user <-- uses name of user
app.get("/users/:userName/cafes", (req, res) => {
    const userName = req.params.userName;
    
    const getUserIdQuery = "SELECT id FROM Users WHERE username = ?";
    db.query(getUserIdQuery, [userName], (err, userResult) => {
        if (err) {
            console.error("Error fetching user ID:", err);
            return res.status(500).send("Database error");
        }
        if (userResult.length === 0) {
            return res.status(404).send("User not found");
        }
        const userId = userResult[0].id;

        const query = `
        SELECT Cafes.name
        FROM Cafes
        JOIN UserCafes ON Cafes.id = UserCafes.cafe_id
        WHERE UserCafes.user_id = ?
    `   ;
        db.query(query, [userId], (err, results) => {
            if (err) throw err;
            res.json(results);
        });
    });
});*/