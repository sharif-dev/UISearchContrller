# UISearchController
IOS research. New UISearchController features in IOS 13.

## The Project
The main project has a search bar to search the name of a country and shows the population.
* MainViewController (implements UITableViewController)
	* First, it creates a UISearchController object. 
	* Instantiates a resultsTableViewController object and links it to the searchController.
	* by setting searchController.obscureBackgroundDuringPresentation to false, prevents background to be transparent while focusing on search bar.
	* sets a place holder for seachBar
	* searchController.searchBar.scopeButtonTitles, creates the buttons that can be used for filtering results. (By Year).
	* There is an extension of MainViewController that implements UISearchBarDelegate. It implements the actions that should happen when:
		* Cancel button is pressed
		* Text in searchBar is changed
		* One of the scopeButtonTitles is pressed.  
	* Other methods implement the methods related to TableViewController cells and searching.

* ResultsTableViewController
	* It also implements the UITableViewController.
	* It has a field called countries. When this filled is set ( didSet() ), It reloads the data and cells to show the results.
	* It implements two methods for the action of selecting a cell and specifying number of rows in TableView.
	* When user starts to search, the main view controller stays visible but the results will be shown in the result view controller.


![alt text](https://koenig-media.raywenderlich.com/uploads/2020/03/listed-new-search-281x500.png "IOS App")
## Using UISearchResultsUpdating
The MainViewController can implement USearchResultsUpdating (new in IOS 13). When there is a change in searchBar, the updateSearchResults will be called. By assigning the MainViewController to be the searchResultsUpdater, after each change (writing or tap) on searchBar, results will be updated.
Before this, all the countries where in the list before searching, by setting resultsUpdating, searching will start from an empty list.

## Search Tokens
Now the search result view is empty at first. It would be great to show some search tokens in a list to choose. Search Tokens are something like tags in searching. They help to focus our search for example in a specific Continent.
We make some changes in ResultsTableViewController:
* Create a field called searchTokens as an array of UISearchToken.
* Adding a method to make tokens. UISearchToken can have an image an a text (Continent Name).
* Each Token can have a represented object (searchToken.representedObject), it can have any types. For example. our represented Object for each token is an object of Continent class.
* We use a field of type boolean to determine if the table should have countries as a list of results or have a list of tokens (before searching anything). So we change the method which returns number of rows:
```
override func tableView(
  _ tableView: UITableView,
  numberOfRowsInSection section: Int
)
```
* Similarly, the other method that was responsible for returning cells, should be changed to weather assign a token or a country to each cell.

![tokens](https://raw.githubusercontent.com/sharif-dev/UISearchController/master/images/searchToken.jpg)

## Adding search tokens 
we use delegate protocol to notify the mainController when user taps a token, and add the token to the search bar like the screen below:
* frist add ResultsTableViewDelegate protocol in ResultsTableViewController.swift and make a weak varible of it.

* then if country has not been choosen it inform the delegate instance(it sends the selected token with didSelect function)

* implement [ResultsTableViewDelegate.didSelect](https://github.com/sharif-dev/UISearchController/blob/master/MainViewController.swift#L134) in MainViewController.swift:
   get the search text, insert the token that we get to the end of the tokens for this text field at the end start searching.
   
* set delegate of resultsTableViewController, mainController.[like this](https://github.com/sharif-dev/UISearchController/blob/master/MainViewController.swift#L44)
<img src="https://github.com/sharif-dev/UISearchController/blob/master/images/token.png" width="420" height="800" />

now we should modify our search with the choosen token:
* get the tokens in the mainController.
* change search function:
  - make arrays of selectedYers and allCountries
  - to find the search result we pass a closure to filter on allCountries array:
    it check the year and the token, if we just searched by token, it returns the country if it matches the year and the token’s continent; else if we have text it will return the country if the year matches, the tokens match and the country’s name contains any of the characters in the search text.
  - set the filtered array to the result.
 <img src ="https://github.com/sharif-dev/UISearchController/blob/master/images/token_result.png" width ="420"  height="800" />

## Hide and show scope bar
To control it we shouldn't automatically show scopeBar, and make a function for showing scopebar , If the search text is not empty, the scope bar should be shown;when the user taps the search bar’s Cancel button,the scope bar should be hide , and when the user selects a token,scope bar will be shown.
  
