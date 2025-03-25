const mongoose = require("mongoose");

const newsSchema = new mongoose.Schema(
  {
    title: {
      type: String,
      required: [true, "Please provide a title"],
    },
    description: {
      type: String,
    },
    content: {
      type: String,
    },
    imageUrl: {
      type: String,
    },
    category: {
      type: String,
      enum: ["technology", "science", "sports", "health", "entertainment"],
      required: [true, "Please provide a category"],
    },
    createAt: {
      type: Date,
      default: Date.now,
    },
    sorce: {
      type: String,
    },
  },
  { timestamps: true }
);

const newsModel = mongoose.model("News", newsSchema);

module.exports = newsModel;
