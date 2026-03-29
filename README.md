# Social Graph: A Relational Analytics Engine for Community Engagement 

# 📖 Table of Contents

* [Project Overview](#project-overview)
* [Project Objective](#project-objective)
* [Tools & Technologies](#tools--technologies)
* [Database Architecture](#database-architecture)
* [Advanced Technical Features](#advanced-technical-features)
* [Business Intelligence & Reporting](#business-intelligence--reporting)
* [Key SQL Skills Demonstrated](#key-sql-skills-demonstrated)
* [Conclusion](#conclusion)

## 📊 Project Overview
This project involves the design and implementation of a robust relational database for a social media platform. The system handles user relationships, content engagement (likes/comments), automated notification systems, and analytical reporting for business insights.

## Project Objective
The objective of this project is to design a fully normalized relational database that ensures data integrity and scalability for a social media ecosystem. It implements backend automation via triggers and stored procedures to handle real-time user interactions like notifications. Finally, it provides actionable business intelligence through complex analytical queries that identify viral trends and user engagement patterns.

## 🛠️ Tools & Technologies
- **Language:** SQL (Structured Query Language)
  
  The language used to communicate with the database. I demonstrated three distinct sub-languages:

  - **DDL (Data Definition):** Creating tables and constraints.
  - **DML (Data Manipulation):** Complex INSERT and CASE-based UPDATE logic.
  - **DQL (Data Query):** Advanced Joins, Correlated Subqueries, and Window-like logic.

## Database Architecture

The schema is designed using Relational Logic and Normalization principles to  ensure data integrity and scalability. 

- **Users & Relationships:** Manages profiles and a self-referencing Followers table for a many-to-many social graph.
- **Content Management:** Posts table with automated timestamps and a hashtags system.
- **Junction Tables:** Utilizes post_hashtags to link content and tags efficiently.
- **Engagement Layer:** Likes and Comments tables linked via Foreign Keys to both users and posts.

## Advanced Technical Feature
  **Automation with Triggers**

  I implemented an Active Notification System. When a user "Likes" a post, a   trigger automatically identifies the post owner and inserts a personalized alert   into the notifications table.

  **User Defined Function (UDF)**
  
  Developed a User-Defined Function, GetUserEngagement(user_id), which calculates a "Social Score" by aggregating a user's total interaction (Likes + Comments) across the platform.

  **Stored Procedures**

  Created reusable procedures like GetPostsByUsername to encapsulate complex joins, making the backend more maintainable and reducing code duplication.

## Business Intelligence & Reporting

The project includes several analytical queries used to drive platform growth:

**Virality Filter:** Uses Correlated Subqueries to identify posts performing 3x better than the platform average.

**Time-Series Analysis:** Extracts posting patterns by DAYNAME to identify peak user activity days.

**Trend Spotting:** A triple-join query that identifies the top 5 trending hashtags within a rolling 30-day window.

 
  ## Key SQL Skills Demonstrated  


 ### 🛠️ Technical Implementation Breakdown

| 📂 Category | 🔧 Techniques Used |
| :--- | :--- |
| **Data Definition** | `CREATE`, `ALTER`, `DROP`, Constraints (`PK`, `FK`, `Unique`, `Check`) |
| **Data Manipulation** | `INSERT`, `UPDATE` (with `CASE` logic), `DELETE` |
| **Complex Queries** | `JOIN` (`Inner`, `Left`), `UNION`, `Subqueries`, `CTEs` |
| **Analytics** | `GROUP BY`, `HAVING`, `Window Functions`, `DATE_SUB` |
| **Database Objects** | `Views`, `Stored Procedures`, `Functions`, `Triggers` |

  
## Conclusion

This project successfully bridges the gap between static data storage and active backend automation. Through the strategic use of triggers, stored procedures, and multi-table joins, I have built a system that not only stores user content but actively reacts to it. The result is a robust, 'business-ready' schema capable of delivering high-speed insights into user virality and platform growth.

