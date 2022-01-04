# coronavirus_rest_api

An app that reads the number of coronavirus cases, confirmed cases, suspected cases, deaths and recoveries from the RESTApi https://ncov2019-admin.firebaseapp.com/#/

I was able to get all the data from the endpoint and display it to the user through a dashboard. I was also able to implement a data caching service that loads the previous data gotten from the endpoint while the user is offline and also implemented a refresh indicator that refreshes when the user is back online.

I was also able to implement some error handling such that the user is shown a dialog when he is offline (SocketException) and an Unknown error dialog for other unknown errors.

Here is the live link for testing https://appetize.io/app/3da9z99wm0rfahrrb0k96yk974

And also a mini screen record showing all the features
https://user-images.githubusercontent.com/59648161/148062046-2cb92bcb-8d80-4ef9-953e-ceb270e1f4db.mp4

