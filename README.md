For this project you will be building an app to help two friends agree on what movie to watch. The two persons will be using with the same iPhone with the app installed, simply by handing it back and forth between them. Your app will access The Movie Database (https://www.themoviedb.org). Unlike the Star Wars API which you used for project 5, the Movie Database API is not completely open, hence an API key is required. You need to request the API key as one of the first steps.

We encourage you to contemplate and experiment with the best way to get two people to select a movie. Explore the API documentation (refer to the two links provided in the Project Resource section) to see what functionalities and data are available to you. As you may discover it is often easier to think about ways you would like to fetch, parse and match the data, than it is to actually implement them. We suggest that you begin with a one or two steps matching process before embarking on anything more complex.

For the workflow of the app, one approach would be to first query for the most popular actors and have each user take turns selecting 5 actors they like (this could be done using a TableView or Picker). Then, based on the selections, query for movies with combinations of those actors and display the list of movies in a TableView which the users can again select from. The final result would then be based on matches in the lists. Alternatively, you could have each user select a fews genres and then bring up a list of recent movies in the overlapping genres.

Use your creativity to decide how the workflow should be. Please do note that the primary objective of this project is for you to demonstrate the proficiency with TableViews, API calls and data modeling, rather than creating complex matching algorithms. That said, once the primary objective is achieved, feel free to experiment with more creative, elegant, or complex matching algorithms.

We provided some sample mockups, image assets and icons. Feel free to use them, or find or create your own design elements, so long as it provides a good user experience.

Please note that this project is more open-ended than the previous ones. Experiment and give the app your own personal touch. There are many valid ways you could approach this problem.


