const express = require("express");
const bodyParser = require("body-parser");
const dotenv = require("dotenv");
const connectDB = require("./config/db");
const newsRoutes = require("./routes/news");
const cors = require("cors"); // Import the cors package

dotenv.config();
connectDB();

const app = express();
app.use(cors());

app.use(bodyParser.json());
app.use("/api/news", newsRoutes);

const categories = [
  { name: "All", icon: "All" },
  { name: "Technology", icon: "Computer" },
  { name: "Sports", icon: "sports_basketball" },
  { name: "Health", icon: "health_and_safty" },
  { name: "Entertainment", icon: "All" },
  { name: "Science", icon: "All" },
  { name: "Business", icon: "All" },
];

app.get("/api/categories", (req, res) => {
  res.json({ sucess: true, data: categories });
});

app.get("/", (req, res) => {
  res.send("Hello World!");
});

const PORT = process.env.PORT || 4500;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
