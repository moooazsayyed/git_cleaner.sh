# git_cleaner.sh
Introduction
Welcome to the Git Repository Cleaner project! This project is designed to help you maintain clean and organized Git repositories by automating the process of identifying and removing stale branches, tags, and repositories that are no longer actively used. Whether you're a developer or a DevOps engineer, this script can be a valuable tool to keep your version control system tidy.

Objective
The primary objective of this project is to create a powerful Git repository cleaner script that can perform three main tasks:

Branch Cleanup: Identify and remove stale branches in Git repositories.
Tag Cleanup: Identify and remove stale tags (e.g., release tags) in Git repositories.
Repository Cleanup: Identify and archive or delete repositories that are no longer actively used based on custom criteria such as last commit date, activity, and more.
Features
Our Git Repository Cleaner script offers the following features:

Automated Branch Cleanup
Tag Cleanup
Repository Cleanup
Integration with GitHub API
User-Friendly Prompts
For a detailed list of features and how to use them, please refer to the Features section below.

Getting Started
Prerequisites
Before using the Git Repository Cleaner script, ensure you have the following prerequisites:

A Git hosting service account (e.g., GitHub) where your repositories are hosted.
A Personal Access Token (PAT) with the necessary scopes to access your repositories via the API.
Installation
Clone this repository to your local machine:

bash

git clone https://github.com/your-username/git-repository-cleaner.git
Navigate to the project directory:

bash
cd git-repository-cleaner
Configure the script by replacing the following variables in the script:

GIT_TOKEN: Replace with your Personal Access Token (PAT) for authentication.
GIT_HOST: Replace with your Git hosting service URL (e.g., GitHub).
USERNAME: Replace with your username.
Usage
To use the Git Repository Cleaner script, follow these steps:

Ensure you've completed the Installation steps and configured the script with your information.

Run the script:

bash
Copy code
./git_cleaner.sh
Follow the on-screen prompts to perform branch, tag, and repository cleanup actions as needed.

Contributing
Contributions to this project are welcome! If you'd like to contribute, please follow the Contributing Guidelines.
