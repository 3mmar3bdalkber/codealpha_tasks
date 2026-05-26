
git init

git config user.name "3mmar3bdalkber"
git config user.email "1234amarabdalkber@gmail.com@example.com"

# STEP 3: Stage everything
git add .

# STEP 4: First commit
git commit -m "Finally Tasks Done"

# STEP 5: Add your GitHub remote (replace YOUR_USERNAME)
git remote add origin https://github.com/3mmar3bdalkber/codealpha_tasks.git

git branch -M main
git push -u origin main

echo ""
echo "✅ Repository pushed to GitHub!"
echo "Visit: https://github.com/3mmar3bdalkber/codealpha_tasks"
