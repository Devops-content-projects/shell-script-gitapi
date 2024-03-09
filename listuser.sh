#!/bin/bash

# GitHub Organization name
ORG_NAME="your_organization_name"

# GitHub Personal Access Token
# Make sure this token has the necessary permissions (read:org scope) to list organization members
ACCESS_TOKEN="your_personal_access_token"

# GitHub API endpoint to list organization members
API_ENDPOINT="https://api.github.com/orgs/$ORG_NAME/members"

# Make a GET request to the GitHub API to fetch organization members
response=$(curl -s -H "Authorization: token $ACCESS_TOKEN" $API_ENDPOINT)

# Check if request was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch organization members"
    exit 1
fi

# Parse the JSON response and extract usernames
usernames=$(echo $response | jq -r '.[].login')

# Check if there are any users
if [ -z "$usernames" ]; then
    echo "No users found in the organization: $ORG_NAME"
    exit 0
fi

# Display the list of usernames
echo "Users in the organization $ORG_NAME:"
echo "$usernames"
