# api_fetch_bloc

Fetch a list of Post from [JSONPlaceholder API](https://jsonplaceholder.typicode.com) progressively.
The post is fetched by 20. The first batch is requested during the launch of the app. The remaining posts are  fetched whenever the user scrolls at the bottom of the list.



## Topic viewed
* API request using `package:http`
* Handling http errors and transforming the body into a `Model`
* Throttling events to avoid being rate-limited by the API server
* Listen to scrolling event to query a new batch of Post

## Features
- [x] Display a list of Post
- [x] Create a new Post
- [x] Edit a post
- [x] Delete a post
- [] Display a post inside a BottomSheet w/ the user's info