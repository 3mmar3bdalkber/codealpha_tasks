#!/bin/bash
# ============================================================
# GitHub Push Script — CodeAlpha Power BI Internship
# Repo: https://github.com/3mmar3bdalkber/codealpha_tasks
# ============================================================

echo "============================================"
echo "  CodeAlpha Power BI — GitHub Push Script"
echo "============================================"
echo ""

# ── 1. Init git if not already ──────────────────────────────
if [ ! -d ".git" ]; then
    echo "→ Initializing git repository..."
    git init
else
    echo "→ Git already initialized. Skipping init."
fi

# ── 2. Set identity ─────────────────────────────────────────
git config user.name "3mmar3bdalkber"
git config user.email "1234amarabdalkber@gmail.com"   # ← Change this to your real email

# ── 3. Stage all files ──────────────────────────────────────
echo ""
echo "→ Staging all files..."
git add .

# ── 4. Commit ───────────────────────────────────────────────
echo "→ Creating commit..."
git commit -m "Add Power BI Internship Tasks: Financial Health, HR Analytics, Real Estate Trends"

# ── 5. Set remote ───────────────────────────────────────────
echo ""
echo "→ Setting remote origin..."
# Remove old remote if it exists to avoid conflicts
git remote remove origin 2>/dev/null
git remote add origin https://github.com/3mmar3bdalkber/codealpha_tasks.git

# ── 6. Push ─────────────────────────────────────────────────
echo ""
echo "→ Pushing to GitHub..."
echo ""
echo "⚠️  When prompted:"
echo "   Username: 3mmar3bdalkber"
echo "   Password: paste your Personal Access Token (NOT your GitHub password)"
echo "   Get token → https://github.com/settings/tokens/new  (check 'repo' scope)"
echo ""

git branch -M main
git push -u origin main

# ── 7. Done ─────────────────────────────────────────────────
echo ""
echo "============================================"
echo "✅ Done! View your repo at:"
echo "   https://github.com/3mmar3bdalkber/codealpha_tasks"
echo "============================================"
