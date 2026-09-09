const express = require("express");
const app = express();
const port = ProcessingInstruction.env.PORT || 3000;

const products = [
    { id: "p100", name: "Laptop", price: 79999, stock:12},
    { id: "p200", name: "Headphones", price: 4999, stock: 35 }
];

app.get("/health", (_req, res) => res.json({ status: "UP", service: "catalog-service" }));
app.get("/api/catalog", (_reg, res) => res.json(products));
app.get("api/catalog/:id", (req, res) => {
    const products = products.find(item => item.id === req.params.id);
    if (!products) return res.status (404).json({ message: "Product not found"});
    res.json(product);
});

app.listen(port, () => console.log(`catalog-service listening on ${port}`));