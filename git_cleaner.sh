#!/bin/bash

# Authentication using Personal Access Token (PAT)
GIT_TOKEN="ENTER YOUR PAT ACCCESS TOKEN HERE"
GIT_HOST="https://github.com"  # Replace with your Git hosting service URL
USERNAME="mooazsayyed"       # Replace with your username

# List your personal repositories
REPO_LIST=$(curl -s -H "Authorization: token $GIT_TOKEN" "$GIT_HOST/api/v3/user/repos")

# Loop through the list of repositories and perform cleanup actions
for repo in $REPO_LIST; do
        echo "Repository URLs: $REPO_LIST"
        repo_name=$(basename "$repo_url")
        git clone "$repo" "$CLONE_DIR/$repo"
    # Navigate to the cloned repository
        cd "$CLONE_DIR/$repo" || continue
    # 1. Branch cleanup
    # Identify and list stale branches here based on criteria.
        BRANCHES=$(git ls-remote --heads "$repo" | cut -f2)
        STALE_BRANCHES=()
        for branch in $BRANCHES; do
                #Check the last commit date of the branch
                last_commit_date=$(git log -n 1 --format=%cd --date=short "$branch")

        # Calculate the number of days since the last commit
                last_commit_unix=$(date -d "$last_commit_date" +%s)
                current_unix=$(date +%s)
                days_since_last_commit=$(( (current_unix - last_commit_unix) / 86400 ))

        # Check if the branch is stale (no commits in the last 120 days)
                if [ "$days_since_last_commit" -gt 120 ]; then
                STALE_BRANCHES+=("$branch")
                fi
        done

          
    # If there are stale branches, prompt the user for cleanup
    if [ ${#STALE_BRANCHES[@]} -gt 0 ]; then
        echo "Stale branches in $repo:"
        for stale_branch in "${STALE_BRANCHES[@]}"; do
            echo "- $stale_branch"
                done
        read -p "Do you want to delete these branches in $repo? (y/n): " cleanup_choice
        if [ "$cleanup_choice" == "y" ]; then
            for branch_to_delete in "${STALE_BRANCHES[@]}"; do
                git push --delete "$repo" "$branch_to_delete"
                echo "Deleted branch $branch_to_delete in $repo"
            done
        else
            echo "Branch cleanup in $repo skipped."
        fi
    fi
    cd ..
done


for repo_info in $REPO_LIST; do
    # Extract repository name from JSON response
    repo=$(echo "$repo_info" | jq -r '.name')

    # Check if the repository has had no commits in the last 120 days
    last_commit_date=$(git log -n 1 --format=%cd --date=short "$repo")
    last_commit_unix=$(date -d "$last_commit_date" +%s)
    current_unix=$(date +%s)
    days_since_last_commit=$(( (current_unix - last_commit_unix) / 86400 ))

    # Check if the repository has protection rules
    protection_rules=$(curl -s -H "Authorization: token $GIT_TOKEN" "$GIT_HOST/repos/$USERNAME/$repo/branches/master/protection/rules")

    # Check if the repository has open pull requests
    open_pull_requests=$(curl -s -H "Authorization: token $GIT_TOKEN" "$GIT_HOST/repos/$USERNAME/$repo/pulls?state=open")

    # Define criteria to delete the repository
    if [ "$days_since_last_commit" -gt 120 ] && [ "$protection_rules" == "[]" ] && [ "$open_pull_requests" == "[]" ]; then
        # Delete the repository
        curl -X DELETE -H "Authorization: token $GIT_TOKEN" "$GIT_HOST/repos/$USERNAME/$repo"
        echo "Deleted repository $repo"
    fi
done
