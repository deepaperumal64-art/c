const express = require("express");
const cors = require("cors");
const { Pool } = require("pg");

const app = express();

app.use(cors());
app.use(express.json());

const pool = new Pool({
    user: "postgres",
    host: "localhost",
    database: "chocomart",
    password: "ChocoMart@123",
    port: 5432
});

app.get("/", (req, res) => {
    res.json({ message: "Choco Mart Backend Running" });
});

app.post("/api/register", async (req, res) => {
    try {
        const { name, email, password, date_of_birth, role } = req.body;

        const result = await pool.query(
            `INSERT INTO users (name, email, password, date_of_birth, role)
             VALUES ($1, $2, $3, $4, $5)
             RETURNING id, name, email, role`,
            [name, email, password, date_of_birth || null, role || "buyer"]
        );

        res.json({
            success: true,
            message: "Registration successful",
            user: result.rows[0]
        });
    } catch (error) {
        res.status(400).json({
            success: false,
            message: error.message
        });
    }
});

app.post("/api/login", async (req, res) => {
    try {
        const { email, password, role } = req.body;

        const result = await pool.query(
            `SELECT id, name, email, role
             FROM users
             WHERE email = $1 AND password = $2 AND role = $3`,
            [email, password, role]
        );

        if (result.rows.length === 0) {
            return res.status(401).json({
                success: false,
                message: "Invalid email, password or role"
            });
        }

        res.json({
            success: true,
            message: "Login successful",
            user: result.rows[0]
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message
        });
    }
});
app.get("/api/products", async (req, res) => {
    try {
        const result = await pool.query(
            `SELECT id, name, description, price, stock, category, image_url
             FROM products
             ORDER BY id`
        );

        res.json(result.rows);
    } catch (error) {
        console.error(error);

        res.status(500).json({
            success: false,
            message: error.message
        });
    }
});