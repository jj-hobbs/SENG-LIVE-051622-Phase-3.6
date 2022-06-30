---
presentation:
  enableSpeakerNotes: true
  showNotes: false
  width: 1200
  height: 900
---

<style>
  table {
    width: 100%;
    overflow: scroll;
  }
</style>

# Intro to Databases

---

<!-- slide data-separator="^\n\n\n"
         data-separator-vertical="^\n\n" data-separator-notes="^Note:"-->

## Key Concepts for the day:

- The benefit of databases in applications
- Relationship between a database and an API
- Domain modeling
- Mapping columns and rows to classes and instances
- Basic SQL queries
- Primary Keys
- Foreign Keys

<!-- slide -->

## Putting things in Context
Over the last few days one of the problems we've had is that the dogs that we create while we run the program only last while the program is running. We need to create them again every time the program runs.

Databases allow us to store our data outside of our code and we can do CRUD and have it persist to the next session.

<!-- slide -->

## ORM Analogy

![ORM Analogy](https://res.cloudinary.com/dnocv6uwb/image/upload/v1651161995/Flatiron%20Slideshow%20images/analogy.drawio.svg)

<!-- slide -->

## Where we're headed

![The Pattern](https://raw.githubusercontent.com/learn-co-students/phase3-lecture-repo-template/04_begin_intro_to_databases/04_intro_to_databases/demo/object-method-sql-query-return.drawio.svg?token=GHSAT0AAAAAABS54V3M5DXF4WXV6T3OUTPUYTJ6M6A)

<!-- slide -->

## The Flow

At the end of the phase, we'll be building out an API that will sit between our React app and our database:

- React App
- Fetch to API
- API interacts with Database
- Sends response back to Browser
- Resolved promise from fetch leads to change in state
- React updates the DOM

<!-- slide -->

## Google Sheets
[Database Examples](https://docs.google.com/spreadsheets/d/1nMukOUNtYQk29BaU6sQfPtuKNUO9VqpvnwZ3B3_Tlwg/edit?usp=sharing)
| id (primary key) | name (text) | birthdate (datetime) | breed (text) | image_url (text)                                                                                             | last_walked_at (datetime) | last_fed_at (datetime) |
| :--------------- | :---------- | :--------- | :----------- | :----------------------------------------------------------------------------------------------------------- | :------------------------ | :--------------------- |
| 1                | Lennon Snow | 1 year     | Pomeranian   | https://res.cloudinary.com/dnocv6uwb/image/upload/v1609370267/dakota-and-lennon-square-compressed_hoenfo.jpg |                           |                        |
									
						
<!-- slide -->

<iframe
  src="https://docs.google.com/spreadsheets/d/1nMukOUNtYQk29BaU6sQfPtuKNUO9VqpvnwZ3B3_Tlwg/edit?usp=sharing"
  class="frame"
  style="width: 800px; height: 900px;"
>
</iframe>

<!-- slide -->

The Following Slides outline the configuration changes necessary to integrate a SQLite database into our application.
  

<!-- slide -->

## DB Config

### Add sqlite3 gem to Gemfile

```bash
bundle add sqlite3
```


<!-- slide -->

## DB Config

### Add a Database called dog_walker.db

From the demo directory in the terminal:

```bash
sqlite3 db/dog_walker.db
```

<!-- slide -->

## DB Config

#### Create the Dogs Table

```sql
CREATE TABLE dogs(
  id INTEGER PRIMARY KEY,
  name TEXT,
  age TEXT,
  breed TEXT,
  favorite_treats TEXT,
  last_fed_at DATETIME,
  last_walked_at DATETIME
);
```

<!-- slide -->

## DB Config

Run the following command to create the dogs table:

```bash
sqlite3 db/dog_walker.db < db/01_create_dogs.sql
```

And insert rows in the table by running the following sql file:

```bash
sqlite3 db/dog_walker.db < db/02_insert_dogs.sql
```


<!-- slide -->

## DB Config

#### Add database configuration to config/environment.rb

Add these lines above the `require_all "lib"`

```rb
DB = SQLite3::Database.new("db/dog_walker.db")
DB.results_as_hash = true
```
