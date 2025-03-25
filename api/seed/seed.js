const { log } = require("console");
const newsModel = require("../model/news");
const fs = require("fs");
const { default: mongoose } = require("mongoose");
const path = require("path");

const dataPath = path.join(__dirname, "data.json");
const newsData = JSON.parse(fs.readFileSync(dataPath, "utf-8"));
mongoose
  .connect(process.env.MONGO_URI_REMOTE)
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((err) => {
    log.error("Error connecting to MongoDB", err);
  });
const seedDatabase = async () => {
  try {
    await newsModel.deleteMany();
    await newsModel.insertMany(newsData); // Insert new data
    console.log("Database Seeded Successfully!");
  } catch (err) {
    console.error("Seeding Error:", err);
  }
};
seedDatabase();
