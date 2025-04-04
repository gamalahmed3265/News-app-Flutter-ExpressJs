const express = require("express");
const router = express.Router();
const News = require("../model/news");
router.get("/", async (req, res) => {
  const { page = 1, limit = 10, category, keyword } = req.query;
  const query = {};
  if (category) {
    query.category = category;
  }
  if (keyword) {
    query.title = {
      $regex: keyword,
      $options: "i",
    };
  }
  try {
    const news = await News.find(query)
      .limit(limit * 1)
      .skip((page - 1) * limit)
      .sort({ createdAt: -1 });
    const total = await News.countDocuments(query);
    res.json({
      sucess: true,
      data: news,
      currentPage: parseInt(page),
      totalPages: Math.ceil(total / limit),
      totalArticles: total,
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

router.post("/", async (req, res) => {
  const { title, description, imageUrl, content, category } = req.body;
  if (!title || !content || !category) {
    return res.status(400).json({
      success: false,
      message: "Title, content and category are required",
    });
  }
  try {
    const news = await News.create({
      title,
      description,
      imageUrl,
      content,
      category,
    });
    res.status(201).json({ success: true, data: savedNews });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
