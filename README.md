# README

- Ruby version: 2.7.2
- Configuration.
  1. Execute ```bundle install```
  2. configure gem figaro.
    - create  config/application.yml
    - append  .gitignore
    - add code at file application.yml
      ```development:
        username_postgres: postgres
        password_postgres: "password"
        port_postgres: "5432"
        host_postgres: localhost ```
- Database creation.
  1. Execute the creation of the data base ```rails db:create```
  2. Execute the migration of the data base ```rails db:migrate```
- How to run the test suite.
  1. Execute ```rspec```
- Routes.
  - The following lines of code are API paths
  ```
  GET http://localhost:port/api/v1/book
  POST http://localhost:port/api/v1/book
  
  ### Generate USER (CONSOLE) ###
    curl -X POST http://localhost:port/api/v1/authenticate -H "Content-Type: application/json" -d '{"username": "Book", "password": "Password1"}'
  ### Generate BOOK (CONSOLE) ###
    curl --header "Authorization: Bearer ###GENERATE TOKEN###" --header "Content-Type: application/json" --request POST --data '{"book": { "tile": "Eloquent Ruby" }, "author": { "fist_name": "Russ", "last_name": "Olsen", "age": 30 }}' http://localhost:port/api/v1/book -v
  
  ```
  - Generate BEARER TOKEN
  ```
  1. https://jwt.io/
  3. PAYLOAD:
    {
      "user_id": "Example"
    }
  4. VERIFY SIGNATURE - Copy: secretK3y
  ```
