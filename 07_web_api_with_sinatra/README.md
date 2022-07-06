## 7. Web API with Sinatra 
### SWBAT

- [ ] Review databases vs servers vs APIs
- [ ] Review client-side vs server-side routing
- [ ] Review HTTP verbs
- [ ] Explain what MVC is and why it’s a popular pattern
- [ ] Observe how to create a controller and handle routing w/ controller actions
- [ ] Observe how to create dynamic routes
- [ ] Explain what params are and how to access them
- [ ] Observe using Postman to test server-side routes

## Deliverables:

Build out the following endpoints:

| Endpoint | info from client in request | info from server in response |
|---|---|---|
| `get '/dogs'` | none | an array of objects (in JSON format) containing dogs and their data |
| `get '/dogs/:id'` | id | a specific dog given the id |

## Understanding Sinatra

[Sinatra](http://sinatrarb.com/) is a DSL (Domain Specific Language) for quickly creating web applications in Ruby with minimal effort:

Sinatra gives us a collection of methods we can use to create web applications. 

Okay, but what does web application mean? Simply put, a web application is a program that runs on a web server instead of on your local machine. So, in order for users to interact with a web application they have to interact with that web server. 

---

## Different Types of Requests

There are different types of HTTP requests that you should be aware of. These are called request methods. The following are the most relevant to what we'll be working with in Sinatra and later in Rails.

- [GET](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/GET) - for retrieving (not modifying) information
- [POST](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/POST) - for sending new information
- [PUT](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PUT) - for replacing existing information (full update)
- [PATCH](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PATCH) - for updating existing information (partial update)
- [DELETE](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/DELETE) - for deleting stored information

---

# Getting Started with Sinatra

When we're first building web applications as an API backend, our focus is on building out endpoints. An endpoint is a route to which requests can be sent in order to retrieve a particular response. When we speak about a `route` we mean a path that a user can take through your application to go from a request to a response. The main ideas we have to manage when building a route/endpoint for our API are these:

> The terms route and endpoint are used interchangeably when talking about possible requests we can send to an API.

- the HTTP verb (get, post, put, patch, or delete)
- the path (`"/"`, `"/dogs"`, `"/walks"`)
- the JSON that we want to send back as a response
  - We might make a query to our database using `Dog.all` and then convert the results to JSON and return that 

An example might look like this:

```rb
get "/dogs" do
    Dog.all.to_json
end
```

---

# Details and Configuration

Other HTTP details we'll have to account for:
- any headers we need to include
  - `"Accept": "application/json"`
  - `"Content-Type": "application/json"`
- Allowing requests across origins 
  - important so that we can ensure that our API will respond if we make a fetch request from another domain.
  - this is necessary because we may be deploying the react app somewhere like [Netlify](https://www.netlify.com/) while our Sinatra API is deployed on [Heroku](https://www.heroku.com/). They would both have different web addresses, so we'd need to make sure that our API on Heroku will accept requests originating from our react app on Netlify.


## Exploring the Starter Codebase 

- `app/models`: Our Active Record models. Responsible for code that accesses and updates data in our database using classes that inherit from ActiveRecord::Base. We'll have the models we've been working on throughout the phase here.
- `config`: Code in this folder is responsible for our environment setup, like requiring files/gems, and establishing a connection to the database.
- `db/migrate`: Our Active Record migrations. Responsible for creating and altering the structure of the database (making new tables, adding columns to existing tables, etc).
- `db/seeds.rb`: Lets us easily add sample data to the database.
- `Gemfile`: Lists all the gems our application depends on.
- `Rakefile`: Code for common tasks that we can easily run from the command line, like `rake console` and `rake server` to run our local dev server.
- `config.ru`: Essential file that all Sinatra applications require. Contains instructions on how to run the rack web server.
- `app/controllers/application_controller.rb` - inherits from `Sinatra::Base` which allows us to define api endpoints like `get '/dogs'`. Sets up configuration to allow cross origin requests (CORS) so our react app can get data from our Sinatra API.

--- 

## Introducing MVC

Before we can hop in and start writing code, we need to understand one of the main design patterns that Ruby on Rails follows. This is important now because we'll be applying that same design pattern to our Sinatra application. This pattern is called **Model-View-Controller**, or **MVC** for short. It looks something like this:

![](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVnObsmAMBWv4xbev4TmmLezWslQ87Ugtn2g&usqp=CAU)

Connecting the diagram to our HTTP request/response cycle, we can say that the React client in our Browser sends a request to our server and the controller is the part of our sinatra code that decides how to respond. It may interact with one of our Models to get data from the database and then render a response back to the browser utilizing a view. 

> The way we've used React so far, we've been doing all rendering of HTML within the browser. While Sinatra has the ability to render html from the server side, we won't be doing so because we want to do that in React. Instead, we'll be thinking of our *view* code as a way of describing what the JSON representation of our data should look like when we send a response back to our client side react code.

---

## Restaurant Analogy

[![Restaurant Analogy](https://image.slidesharecdn.com/introductiontolightninglifecyclevirtualmeetup-190605220136/95/introduction-to-lightning-lifecycle-19-638.jpg?cb=1559772205)](https://blog.yechiel.me/welcome-to-the-mvc-restaurant-fb1709047914)

- Models <=> Chefs
- Controllers <=> Waiters
- Views <=> Tables/Silverware/Plates/other presentational stuff (React in our case)

This [blog post on the MVC Restaurant](https://blog.yechiel.me/welcome-to-the-mvc-restaurant-fb1709047914) gives a fun explanation of the analogy in more detail.

---

## Key Concepts:

- **Model** - class that inherits from ActiveRecord::Base that can make queries to the DB and get a collection of objects back
- **Controller** - class that defines routes and decides how our server will respond to incoming requests
- **View** - the code that determines the structure of the JSON that the controller will respond with. Later, we can move this code to separate files called serializers, but for now, we'll keep this code right inside our controller's routes. If we're thinking of our full stack application holistically, we could say that our view code is our react frontend code.

Models should be familiar at this point, so the new concepts are the Controller and the View. In Sinatra, the controller is where we define the routes our application will respond to. 

---

## Our First API endpoint

Let's jump in and try some stuff out. First, let's add this to the application controller.
```rb
get "/hi" do 
  { hello: "world" }.to_json
end
```

Next, we'll use `rake server` to start our development server. 

```bash
rake server
```

You should see something like this:

```bash
10:34:57 [rerun] Api launched
10:34:57 [rerun] Rerun (16074) running Api (16092)
2021-08-20 10:34:58 -0700 Thin web server (v1.8.1 codename Infinite Smoothie)
2021-08-20 10:34:58 -0700 Maximum connections set to 1024
2021-08-20 10:34:58 -0700 Listening on localhost:9292, CTRL+C to stop
10:34:59 [rerun] Watching . for **/*.{rb,js,coffee,css,scss,sass,erb,html,haml,ru,yml,slim,md,feature,c,h} with Darwin adapter
```

---

## Testing it Out

Now, let's go over to the browser and visit:

```
http://localhost:9292/hi
```

---

![json output](https://github.com/DakotaLMartinez/intro_to_sinatra/raw/main/img/json-output.png) 

---

## Prettifying the Output
If it doesn't look so nice for you, I recommend installing the [JSONView](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc?hl=en) chrome extension. After installing, reload the page in the browser and you should see the same formatting as the image above.

---

# API Endpoint Checklist

So, when it comes to building out an API endpoint (route) these are the 3 things we need to do:

1. define the request method (get/post/patch/put/delete)
2. define the path to the route ('/hi')
3. pass a block that returns a JSON formatted string (which will be our response body)

---

## Devtools and Debugging

- Browser for get requests using [JSONView](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc?hl=en) chrome extension for pretty JSON output
- Network Tab in Chrome when using react
- Postman for testing non GET requests
- rake server logs
- binding.pry within `rake server` terminal
- puts statements within `rake server` terminal

--- 

# Important Gotchas & Troubleshooting steps

## Problem - Routes paths must start with `/`!
  
If you add this:

```rb
get 'dogs' do 
  'hi there'
end
```

And then visit `http://localhost:9292/dogs`, you'll see this:

![404](https://res.cloudinary.com/dnocv6uwb/image/upload/v1629480277/Screen_Shot_2021-08-20_at_10.24.00_AM_p8nfb0.png)

---
## Fix - Routes paths must start with `/`!

fix the problem by adding the preceding `/`

```rb
get '/dogs' do 
  'hi there'
end
```

Now, you'll see

![hi there](https://res.cloudinary.com/dnocv6uwb/image/upload/v1629481002/Screen_Shot_2021-08-20_at_10.35.45_AM_ufdnsl.png)

---

# Problem - Server won't start because port is in use

If you start your server and see something like this:

```
10:27:06 [rerun] Api launched
10:27:06 [rerun] Rerun (14359) running Api (14521)
2021-08-20 10:27:07 -0700 Thin web server (v1.8.1 codename Infinite Smoothie)
2021-08-20 10:27:07 -0700 Maximum connections set to 1024
2021-08-20 10:27:07 -0700 Listening on localhost:9292, CTRL+C to stop
Traceback (most recent call last):
        15: from /Users/dakotamartinez/.rvm/gems/ruby-2.6.6/bin/ruby_executable_hooks:24:in `<main>'
        14: from /Users/dakotamartinez/.rvm/gems/ruby-2.6.6/bin/ruby_executable_hooks:24:in `eval'
        13: from /Users/dakotamartinez/.rvm/gems/ruby-2.6.6/bin/rackup:23:in `<main>'
        12: from /Users/dakotamartinez/.rvm/gems/ruby-2.6.6/bin/rackup:23:in `load'
        ... stack trace abridged here ...
         2: from /Users/dakotamartinez/.rvm/gems/ruby-2.6.6/gems/thin-1.8.1/lib/thin/backends/tcp_server.rb:16:in `connect'
         1: from /Users/dakotamartinez/.rvm/gems/ruby-2.6.6/gems/eventmachine-1.2.7/lib/eventmachine.rb:531:in `start_server'
/Users/dakotamartinez/.rvm/gems/ruby-2.6.6/gems/eventmachine-1.2.7/lib/eventmachine.rb:531:in `start_tcp_server': no acceptor (port is in use or requires root privileges) (RuntimeError)
```

---

# Fix - Server won't start because port is in use

that means there's already a server running somewhere. You need to find the running process and kill it. To do that, you can run the following command:

```bash
ps -ax | grep rackup
```

And you'll see a list of all processes that include `rackup` in them.

> **Aside**: The `grep` command is a search tool and we're piping the output of `ps -ax` to it, `ps -ax` will print a list of the running processes including their process ids and the path to the executable file itself. This will give us a list of processes that include `config.ru`. We should only see 2. The first will be the server process we need to kill, the second will be the search (which also contains `config.ru` in the command)

---

# Example of Fix

```bash
> ps -ax | grep rackup
21736 ttys008    0:03.02 ruby /Users/dakotamartinez/.rvm/gems/ruby-2.7.4/bin/rerun -b rackup -p 9292    
21780 ttys008    0:01.69 ruby /Users/dakotamartinez/.rvm/gems/ruby-2.7.4/bin/rackup -p 9292    
21918 ttys009    0:00.00 grep rackup
```
The number at the beginning of the line is the process id that we need to kill.

```bash
kill -9 21736
kill -9 21780
```

We can confirm that it worked by running the `ps -ax | grep config.ru` again:
```bash
> ps -ax | grep rackup
22194 ttys009    0:00.00 grep rackup
```

Now, we only see the search process and no other process containing `rackup`. At this point, we can try running the server again using `rake server`

```bash
> rake server
10:34:57 [rerun] Api launched
10:34:57 [rerun] Rerun (16074) running Api (16092)
2021-08-20 10:34:58 -0700 Thin web server (v1.8.1 codename Infinite Smoothie)
2021-08-20 10:34:58 -0700 Maximum connections set to 1024
2021-08-20 10:34:58 -0700 Listening on localhost:9292, CTRL+C to stop
10:34:59 [rerun] Watching . for **/*.{rb,js,coffee,css,scss,sass,erb,html,haml,ru,yml,slim,md,feature,c,h} with Darwin adapter
```
If you see something like the above then you're good to go!


---

## Sending Requests via Postman

Try opening [this workspace](https://www.postman.com/dakota27/workspace/dogwalkerapplication/request/3907819-afb45b42-8a10-4ca2-9e59-4a5a2c45048a) in Postman to get the details for the requests we want to send.

When we create a dog, we'll send this as the raw body in JSON format:

```json
{
    "name": "Baby Lennon",
    "birthdate": "2020-08-31",
    "breed": "Pomeranian",
    "image_url": "https://res.cloudinary.com/dnocv6uwb/image/upload/v1609370238/dakota-and-lennon-square-medium-compressed_qpwki6.jpg"
}
```

## How to Test
- You can test out your progress by using Postman to send requests to the API 
  - make sure that `rake server` is running
  - verifying the responses are what you expect
  - You can also check the `rake server` logs after sending a request through Postman to see the SQL queries fired off
  - check the SQLite explorer to see the impact on your database.
- You can also boot up the react client using `npm start`
  - keep an eye on the network tab in the chrome devtools, this will show you the requests that are being sent and the responses received as well.
  - If you click on the navbar link to `/walks` you should see a list of walks there if you've completed the first endpoint.
  - If you fill in the form in the react client to create a walk, it will appear in the browser if the endpoint is properly configured
  - If you click on the trash can icon in the react client, it should remove the walk from the database. 