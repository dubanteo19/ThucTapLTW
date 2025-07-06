# 🛍️ Full-Stack E-Commerce Platform

A production-ready, feature-complete online shopping system built with **Java Servlets & JSP**, **MySQL**, and vanilla **HTML/CSS/JS**—no heavyweight frameworks required. The project covers everything from user authentication and secure order signing to admin dashboards, inventory forecasting, and Excel-based bulk operations.

## ✨ Key Features

| Module | Highlights |
| ------ | ---------- |
| **Catalog** | Categories ➜ Products ➜ Product Detail ➜ Similar Products |
| **Discovery** | Text search • Multi-criteria filters (price, rating, category) • Sort (popularity, newest, price) |
| **Ratings & Reviews** | 1-to-5 star ratings, average rating display |
| **Cart & Checkout** | Add/update/remove items • COD payment flow • Order signing & verification (RSA) |
| **Auth** | Register • Login • OTP-based e-mail password reset • JWT session cookies |
| **User Profile** | Address book • Profile edit • Password change • Order history |
| **Admin** | Dashboard cards (latest orders, customers, revenue, stock) • CRUD for products, categories, users, metadata (carousel, policy page) |
| **Warehouse** | Manual imports + Excel bulk import/export • Standard-deviation forecast recommending when to restock |
| **Analytics** | User event logs (logins, cart, ratings) |
| **Security** | RSA keypair management • Order signing/verification • BCrypt passwords • CSRF & XSS guards |

## 🏗️ Tech Stack

| Layer | Tech |
| ----- | ---- |
| Backend | Java 17, Servlets 4.0, JSP 2.3, JSTL, Apache Commons, Gson |
| Database | MySQL 8 (+ JDBC connection pool) |
| Build / Deploy | Maven, Apache Tomcat 10|
| Client | HTML5, Bootstrap 4, Jquery ,Vanilla JS, |
| Tooling | Apache POI (Excel), BCrypt, JavaMail |

## 🖼️ Architecture at a Glance

```
Browser ──► Servlet Controller ──► Service Layer ──► DAO ──► MySQL
▲ │
(JSP View) ◄──┘ └─► Utility Services
• MailService (OTP)
• CryptoService (RSA)
• ExcelService (import/export)
• ForecastService (σ restock)
```

## 🚀 Getting Started

### 1. Prerequisites

- JDK 17+
- Maven 3.9+
- MySQL 8.x (UTF-8 collation)
- Git

## 📈 Inventory Forecasting

`ForecastService` uses a moving window of past sales to compute mean ± σ. When current stock falls below mean + 0.5 σ, the admin dashboard flags the product as “Low Stock—Restock Suggested”.

## 📊 Excel Import / Export

- **Import**: Upload `.xlsx` with SKU, Name, Price, Quantity → bulk insert/update.
- **Export**: One-click dump of current catalog + stock.
- Built with Apache POI, supports >10k rows.

