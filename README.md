# ClearSkies Weather App

## Running the appp

1. Ruby version: `3.1.1` AND Rails version: `7.0.3`
2. In a terminal window, clone the project and `cd` into the project directory
3. Run `bundle install` to install gems required by the project
4. Start the application by running `./bin/dev`
5. Visit http://127.0.0.1:3000 in a browser window to visit the app


## Dependencies/Gems used

1. http gem
2. geocoder gem (fetching zip code based on address)
3. tailwind css rails gem

## Example Screenshots

### Home Page
- Includes both an address input field along with a select dropdown for choosing the number of days for the weather forecast.
<img width="1683" alt="Screenshot 2023-01-05 at 1 53 41 PM" src="https://user-images.githubusercontent.com/1103708/210868261-2d3451e7-3745-4170-bf3b-fef5a675f0bd.png">

### Weather Results (Color coded based on day temperature) - Not Cached
- _Fresh_ means the results are the latest and not cached.
<img width="983" alt="Screenshot 2023-01-05 at 1 57 57 PM" src="https://user-images.githubusercontent.com/1103708/210869068-427f47d9-a9db-430f-b13c-3a53b0afc5b4.png">

### Weather Results - Cached by zip code
- NOTE: hovering over the _cached_ indicator shows a tooltip with last updated at time of the weather results
<img width="961" alt="Screenshot 2023-01-05 at 1 57 11 PM" src="https://user-images.githubusercontent.com/1103708/210869090-c9bf55bd-1c98-42f9-9667-c606d6f1815f.png">

### Form validation - Empty address field
<img width="1685" alt="Screenshot 2023-01-05 at 1 46 55 PM" src="https://user-images.githubusercontent.com/1103708/210869272-05019be1-d7a8-4588-a9b8-437dc19d8b3e.png">

## Form validation - Invalid address
<img width="1683" alt="Screenshot 2023-01-05 at 1 47 03 PM" src="https://user-images.githubusercontent.com/1103708/210869298-f2faf871-5a4d-49d1-9f49-e947f90d77e6.png">


## How caching is implementing

- I used `Rails.cache` which by default uses an In Memory Cache. 
- Cached Weather results based on the zip code and number of forecast days expire after 30 mins. 


