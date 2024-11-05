# README File

**Name**: BRIGHT MONEY APP by Tammy

### This application runs on the following versions:

- **Ruby**: 3.2.5
- **Rails**: 7.2.2
- **PostgreSQL**: 14.13

**NOTE**: Use a Ruby version manager like [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://rvm.io/) to install and manage your Ruby version.

## Table of Contents

- [Introductory Notes](#introductory-notes)
- [Prerequisites](#prerequisites)
- [Step 1: Clone the Repository](#step-1-clone-the-repository)
- [Step 2: Install Dependencies](#step-2-install-dependencies)
- [Step 3: Set up Configurations](#step-3-set-up-configurations)
- [Step 4: Run the Application](#step-4-run-the-application)
- [Step 5: Run Test Suite](#step-5-run-test-suite)
- [Step 6: Deployment Instructions](#step-6-deployment-instructions)
- [Step 7: Additional Notes](#step-7-additional-notes)

## Introductory Notes

This README provides a comprehensive guide to setting up and running the BRIGHT MONEY APP backend API application, including installation instructions, configurations, and testing procedures.

## Prerequisites

1. **Visual Studio Code (VSCode)**: Download from [code.visualstudio.com](https://code.visualstudio.com/) if you haven’t already.
2. **Package Managers**: Homebrew (for Mac) or Chocolatey (for Windows) is recommended to help install dependencies.
3. **Terminal Access**: Command Prompt, Git Bash, or Terminal in VS Code

## Step 1: Clone the Repository

Open VS Code, then open the Terminal (View > Terminal) and clone the repository to your local machine:

```bash
git clone https://github.com/tammytamayao/expense-app-backend.git
cd expense-app-backend
```

## Step 2: Install Dependencies

Open VS Code, then open the Terminal (View > Terminal):

Install Ruby

```bash
# For macOS
brew install ruby

# For Windows
choco install ruby
ruby --version
```

Install Rails

```bash
gem install rails
rails --version
```

Install Postgresql

```bash
# For macOS
brew install postgresql
psql --version
brew services start postgresql  # To start the service
# brew services stop postgresql   # To stop the service (if needed)

# For Windows
choco install postgresql
# Start the PostgreSQL service (you may need to adjust this depending on your setup)
net start postgresql-x64-14
```

## Step 3: Set-up Configurations

Navigate to the project directory and run:

```bash
bundle install
```

Create and Migrate the Database: Ensure PostgreSQL is running, then run:

```bash
rails db:create #if starting on a new environment with no database
rails db:migrate
```

## Step 4: Run the Application

```bash
rails server
```

Open your browser and go to http://127.0.0.1:3000 or http://localhost:3000 to access the app.

## Step 5: Run Test Suite

Run test code to ensure everything is functioning as expected

```bash
rails test
```

## Step 6: Deployment Instructions

Check out the [Rails deployment documentation](https://guides.rubyonrails.org/tuning_performance_for_deployment.html) for more details.

## Step 7: Additional Notes

- Ensure you have PostgreSQL running before creating the database.
- Confirm that the application is running on http://127.0.0.1:3000 or http://localhost:3000
- If you encounter issues, refer to the logs or check for any missing dependencies.
- Feel free to reach out for support at **tammytamayao@gmail.com**

### Sample Database Connection Info

When configuring your database connection, you may need to adjust the config/database.yml file in your Rails application. Here is an example of the configuration:

```bash
development:
  adapter: postgresql
  encoding: unicode
  database: app_name_development   # Replace with your database name
  username: your_username          # Replace with your PostgreSQL username
  password: your_password          # Replace with your PostgreSQL password or leave it blank
  host: localhost                  # or 'http://127.0.0.1'
  port: 5432
```

Make sure to replace your_username and your_password with your actual PostgreSQL credentials. This information is necessary to establish a connection to the PostgreSQL database.

You may also opt to use Table Plus and use the above sample information to establish a connection.

Thank you.
