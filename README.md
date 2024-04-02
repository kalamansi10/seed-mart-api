# Seed-Mart - Rails API Backend

This repository contains the Rails backend API for Seed-Mart.

## Getting Started

After cloning the repository, use the following commands to deploy the API:

Note: Must have PostgreSQL installed and running on the background.

```bash
bundle install
rails db:create
rails db:migrate
rails db:seed
rails s
```

```bash
Seed account:

email: aaa@aaa
password: aaa@aaa

```

##  API Backend Features

### User Sessions and Authentication

The API currently uses the Devise gem for authentication, although it's not well supported for my current use case. I utilize the built-in session middleware for handling sessions and implement CSRF protection through token generation, which is sent through cookies and returned by the front end via the HTTP response header for requests other than GET.

### Database and Item Queries

The API utilizes PostgreSQL as its database management system and relies on the built-in ORM, Rails Active Record, for interacting with the database.

# About Seed-Mart

Seed-Mart is a personal project of mine designed to showcase my current proficiency in web development. It is an e-commerce website that focuses on modularity and scalability. Every component of the application was made with flexibility in mind.

My vision for the project was to create different versions of the frontend app using various frameworks, along with multiple versions of the backend server, each deployed separately. The aim was to seamlessly integrate them, allowing any frontend version to function with any backend version.

But as I continue my web development journey, I've come to realize that separating the frontend and backend isn't always practical, especially for websites handling forms, user sessions, and authentication. Opting for a framework that integrates both, following the MVC pattern, would save considerable time compared to building them separately, thanks to the well-supported libraries in this kind of implementation.

I'm determined to achieve my goal, even though this project will primarily serve as practice. Being bilingual (English and Tagalog), I often hear a phrase: "If you can translate a foreign language to your native language, you're proficient in that language." I believe the same applies to coding. If I can translate an app I've built into a different framework or language, it indicates a solid understanding of the new framework or language I'm learning.

## Seed-Mart Versions

- [seed-mart-front-reactjs](https://github.com/kalamansi10/seed-mart-front-reactjs)
- [seed-mart-api-rails](https://github.com/kalamansi10/seed-mart-api-rails)
- [seed-mart-api-nodejs](https://github.com/kalamansi10/seed-mart-api-nodejs)
