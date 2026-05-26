#!/bin/bash
# ============================================================
# GitHub Push Script — CodeAlpha Power BI Internship
# Run this from inside the CodeAlpha_Power_BI_Internship folder
# ============================================================

# STEP 1: Initialize git (skip if already done)
git init

# STEP 2: Set your identity (change these)
git config user.name "Your Name"
git config user.email "your.email@example.com"

# STEP 3: Stage everything
git add .

# STEP 4: First commit
git commit -m "Initial commit: Add all 3 Power BI task datasets and implementation guides"

# STEP 5: Add your GitHub remote (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/CodeAlpha_Power_BI_Internship.git

# STEP 6: Push to GitHub
git branch -M main
git push -u origin main

echo ""
echo "✅ Repository pushed to GitHub!"
echo "Visit: https://github.com/YOUR_USERNAME/CodeAlpha_Power_BI_Internship"
