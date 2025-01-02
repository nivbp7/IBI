# IBI - Products Store
Login Credentials:
* username - IBI
* password - password


Login screen:
* User has the option to tap the action button to log into the app using Face ID/Touch ID.
* The user can enter their username and password to log in to the app.
* Alert errors are presented to the user if the authentication fails.

Products and favorite screens:
* Fetching the products is kicked off when the view loads. There is also a Reload button, if there was an error or if the phone was offline.
* The view model handles memory storage of all the products and the favorite ones.
* Selecting a favorite is done in the detail view.
* Favorite products are stored in User Defaults. The view model handles the synchronization of the data (e.g. if a product was added to the favorites).

Information about the code:
* The UI is built programmatically.
* The app is built using the MVVM pattern. The `ProductsViewModel` handles the information needed for requesting and displaying products.
* The `FavoritesViewController` is a subclass of `ProductsListViewController` since they share a common UI.
* The app Uses [SDWebImage](https://github.com/SDWebImage/SDWebImage) to download and cache images.

Known Issues:
* Not all errors are shown to the user.
* Adding a scroll view to the logic screen so that the user can tap the login button when the keyboard is showing.
* Localization is implemented using Xcode's built-in [String Catalog](https://developer.apple.com/documentation/xcode/localizing-and-varying-text-with-a-string-catalog). It appears that there is no simple way to update the localization without resetting the app. A different approach could be to have a language dictionary, in which a string that indicates the purpose can be translated for each language, making it work on the fly.
* Displaying images in the detail screen would be better implemented with a Collection View.
* Pagination is working, however it would be nicer to add a loading spinner at the bottom and also during the initial load. 
* Creating the URL should be done with `URLComponents` and not string literals.
