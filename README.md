# Weather App

A one page weather app built in Flutter

## Notes:
On a real life project I would’ve argued not to use the two endpoints listed in the brief as they don’t provide the accurate information that the brief wants to display, instead I would’ve suggested to use this endpoint: https://openweathermap.org/api/one-call-api which provides all the data combined from both the other endpoints as well as accurate daily weather descriptions and calculated max, min temperatures for both current day as well as forecast. But since the brief specifically listed two other endpoints to use I have used those exclusively to calculate the data as following:
- Max & min temp: showing the max/min temperature calculated from iterating over the 3hours slots provided in the forecast API. This means that the last day of the 5 day forecast only will have so much data if you are looking at it early in the morning, as the API would’ve only provided data up until that time on that last day, thus the min/max for the last forecasted day won’t be accurate.
- Based on the brief I have provided a min/max temp for the current day, this is based on data from the current time until the end of the day. However to get an accurate reading of the current day min and max I would need historical data for the time passed in the day (which using the other endpoint mentioned above would’ve solved).
- Forecast Weather description: I have chosen to show the weather for the closest available slot supplied by the api to local Noon every day. I don’t think this is necessarily ideal but it is something I would’ve wanted to discuss options for and improve on if this was a real life project.
- Weather Forecast Info: I have chosen to assume that the listing of “current temp” under the info expected for the forecast is a typo as there is no current temp for a forecast and thus only listed max and min temperatures.
- Assumption: App will only work if you have internet connection to fetch weather data.
- App left intentionally in debug mode as it is not ready for release.

##### Tested on:
- Android Nexus 5X (8.1.0)
- Simulator: iPhone 11 (13.4.1)
- Emulator Pixel 3 (Q 10.0)

##### Screenshots
- Android: http://josefin.fundin.com/images/weather_app/android.png
- iPhone: http://josefin.fundin.com/images/weather_app/iphone.png


## Potential Improvements:

##### Code:
- I would update to use the more extensive API endpoint to provide more accurate data, that would also allow me to show hourly forecast for the current day
- Spend additional time on readability in the backend. I used an automated JSON-parser to get started with unpacking the JSON data and have improved upon it and cleared out the unused data but I think there is still a bit of work that could be done in that layer to clear things up a bit.

##### Features:
- A toggle button between Celsius and Fahrenheit
- A Search field to input city name (that will then result in getting weather for that particular city)
- Function to hold result from last API call even after app has been closed.
- Handle rare case of not having internet connection first time the app is opened
- Refresh on pull down gesture

##### Design features and ideas:
- Nighttime mode theme
- Adjusted background depending on weather
- A better more elaborate icon library (as material design have limited icons for weather representation)
- Update app name and launch icons for iOS
- Handle landscape mode

##### Testing:
- Higher test coverage with possible mock object for the API call
- Automated widget testing
- Visual QA on more devices and os versions


## Other notes:
- Skyline image used is a open source file