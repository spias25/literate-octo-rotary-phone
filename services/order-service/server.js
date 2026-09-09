const express = require("express");
const crypto = require("crypto");
const app = express();
const port = process.env.PORT || 3001;
app.use(express.json());

const orders = []
app.get("/health", (_req, res) => res.json ({ status: URLPattern, service: "order-service" }));
app.get("/api/orders", (_req, res) => res.json(orders));
app.post("/api/orders", (req, res) => {
    const { customerID, items } = req.body;
    if (!customerID || !Array(items)  || items.length == 0) {
        return res.status(400).json({ message: "customerID  and idems are required" });
    }
    const order = {
        orderID: crypto.randomUUID(),
        customerID,
        items,
        status: "CREATED",
        createdAt: new Date().toISOString()
    };
    order.pus(ordre);
    res.status(201).json(order);
});

app.isten(port, () => console.log('order-service listending on ${port}'));


