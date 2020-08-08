
# UISearchController
IOS research. New UISearchController features in IOS 13.

## <div dir="rtl"> اجرای پروژه </div>
محسن دهقان کار
97105928
زهرا یوسفی جمارانی
97102717

## <div dir="rtl"> اجرای پروژه </div>
<p dir="rtl">
این پروژه قابلیت های جدید UISearchController درIOS 13 را بررسی می کند.
برای شروع به کار ابتدا محتوا ریپازیتوری را clone کرده و با xcode بخش 
LISTED.xcodeproj را اجرا کنید.
</p>
<p dir="rtl">
	پس از باز کردن پروژه می توانید آن را build&run کنید، توضیحات زیر برای کلاس های اصلی این پروژه داده شده اند.
</p>
<p dir="rtl">
منبع اصلی این پروژه:
</p>
https://www.raywenderlich.com/9218753-what-s-new-with-uisearchcontroller-and-uisearchbar 
</br>

README:
* [English](#the-project)

* [Persian](#پروژه)

	
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

* implement [ResultsTableViewDelegate.didSelect](https://github.com/sharif-dev/UISearchController/blob/master/MainViewController.swift#L185) in MainViewController.swift:
   get the search text, insert the token that we get to the end of the tokens for this text field at the end start searching.
   
* set delegate of resultsTableViewController, mainController.[like this](https://github.com/sharif-dev/UISearchController/blob/master/MainViewController.swift#L57)

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

## Customize search bar
* change [textField](https://github.com/sharif-dev/UISearchController/blob/master/MainViewController.swift#L69) color to green
* change [background](https://github.com/sharif-dev/UISearchController/blob/master/MainViewController.swift#L171) color of search bar. 
* change color of [token](https://github.com/sharif-dev/UISearchController/blob/master/MainViewController.swift#L70)  
<img src ="https://github.com/sharif-dev/UISearchController/blob/master/images/custom.png"  width ="840"  height="800" />


## <div dir="rtl">پروژه</div>
<p dir="rtl">
پروژه اصلی دارای یک searchBar است که با آن می توان نام یک کشور را جست و جو کرد و جمعیت آن را برحسب سال مشاهده کرد.
</p>
<ul dir="rtl">
<li>MainViewController</li>
<ul>
	<li>ابتدا یک شیء از جنس UISearchController ایجاد می کند.</li>
	<li>یک شیء از جنس resultsTableViewController نیز تولید می کند و آن را به searchController متصل می کند.
	<li>مقدار searchController.obscureBackgroundDuringPresentation را برابر false قرار می دهد، با این کار وقتی روی searchBar کلیک کنیم، تصویر پس زمینه وضوحش تغییر نمی کند.
	<li>یک رشته را بعنوان placeholder برای searchBar قرار می دهد.
	<li>با استفاده از searchController.searchBar.scopeButtonTitles یکسری دکمه جهت فیلتر کردن نتایج جست و جو (مثلا براساس سال) ایجاد می شود.
	<li> برای کلاس MainViewController یک extension به اسم UISearchBarDelegate را پیاده سازی می کند. شامل:
	<ul>
	<li> عملیات مربوطه پس از کلیک cancel
	<li> جست و جو کردن، پس از تغییر متن نوشته شده در searchBar
	<li> عملیات مربوط به کلیک شدن یکی از scopeButtonTitles
	</ul>
	<li>بقیه method های پیاده سازی شده مربوط به سلول‌های TableViewController هستند.
</ul>
<li>ResultsTableViewController
<ul>
	<li>UITableViewController را پیاده سازی می کند.
	<li> یک field‌تحت عنوان coutries موجود است که پس از هربار تغییر کردن (didSet)، نتایج ساخته شده و نمایش داده می شوند.
	<li> دو method در این کلاس پیاده سازی می شود که یکی مربوط به عمل کلیک کردن هر یک از سلول هاست و دیگری برای تعیین تعداد سطر های Table‌هست.
	<li> هنگامی که کاربر جست و جو می کند، MainViewController همچنان در صفحه باقی می ماند اما نتایج در ResultsViewController نمایش داده می شوند.
</ul>
</ul>

![alt text](https://koenig-media.raywenderlich.com/uploads/2020/03/listed-new-search-281x500.png "IOS App")
## <div dir="rtl">استفاده از UISearchResultsUpdating </div>
<p dir="rtl">
کلاس MainViewController می تواند UISearchResultsUpdating‌را پیاده سازی کند. (در IOS 13). هرموقع تغییری در نوار جست و جو رخ دهد، updateSearchResults فراخوانده می شود. اگر MainViewConrtoller را بعنوان searchResultsUpdater قرار دهیم، بعد از هر تغییر اعم از نوشتن یا کلیک کردن روی نوار جست و جو نتایج آپدیت می شوند. (قبل از این، اینگونه بود که با کلیک روی نوار جست و جو از یک لیست که همه‌ی کشور ها را داشت شروع می کردیم، اما الان با این کار لیست اولیه خالی خواهد بود.)

## <div dir="rtl">Search Token </div>
<p dir="rtl">
حالا که نتایج جست  و جو در ابتدا خالی است، می توان تعدادی token  در ابتدا نمایش داد که قابل انتخاب باشند. search token‌ها چیزی شبیه به tag‌برای جست و جو کردن هستند که نتایج را بر اساس یک ویژگی از آن ها (مثلا قاره) فیلتر می کنند. برای این کار در ResultsTableViewController یک سری تغییر بوجود می آوریم:
</div>
<ul dir="rtl">
	<li> یک field‌از جنس آرایه ای از UISearchTokens‌بوجود می آوریم.
	<li> یک method‌برای ساختن token  ها (token‌ها می توانند دارای متن و تصویر باشند.)
	<li> هر token یک فیلد تحت عنوان representedObject دارد. که می تواند از هر نوعی باشد (any?). این جا بعنوان نمونه، از جنس Continent خواهند بود.
	<li> چون token‌ها در همان لیستی که نتایج نشان داده می شوند، نشان داده خواهند شد. پس از یک فیلد bool برای تعیین نوع لیست استفاده می کنیم. پس متناسب با آن باید متدی که تعداد سطر ها را نشان می داد عوض کنیم.
</ul>

```
override func tableView(
  _ tableView: UITableView,
  numberOfRowsInSection section: Int
)
```

<ul dir="rtl">
<li>بطور مشابه، سایر method‌هایی که وظیفه بازگرداند سلول ها بودند را هم عوض می کنیم که یا token‌ها را برگرداند یا نتیجه جست و جو.
</ul>


![tokens](https://raw.githubusercontent.com/sharif-dev/UISearchController/master/images/searchToken.jpg)

## <div dir="rtl">اضافه کردن توکن ها به searchbar </div>
<p dir="rtl">
برای آگاه کردن mainController از اینکه کاربر یک توکن رو انتخاب کرده تا بتواند آنرا به searchbar اضافه کند باید کار های زیر را انجام دهیم:
</p>
<ul dir = "rtl">
	   <li>     باید یک نمونه از ResultsTableViewDelegateدر کنتلر جدولمان بسازیم.
	   <li> اگر توکنی انتخاب شده به نمونه گرفته شده را آگاه کند
	<li> توکنی که دریافت کردیم را به ادامه ی توکن های قبلی اضافه کنیم
		<li> maincontroller را به عنوان delegate در resultsTableViewController قرار دهیم.
</ul>
<p dir= "rtl">
حالا باید توکن ها را در جستجویمان تاثیر دهیم:
</p>
<ul dir="rtl">
	<li>دریافت توکن ها در mainController
		<li>الگوریتم جستجوی خود را تغییر میدهیم:
			ابتدا آرایه ای از تمام کشور ها و سال های انتخاب شده در نظر میگیریم سپس یک closure به filter میدهیم تا با استفاده از آن فیلتر کند
			<li> حالا آرایه ی فیلتر شده را به عنوان نتیجه جستجو خروجی میدهیم.
</ul>
 <img src ="https://github.com/sharif-dev/UISearchController/blob/master/images/token_result.png" width ="420"  height="800" />

## <div dir="rtl">مخفی کردن و نمایش scopeBar</div>
<p dir="rtl">
برای اینکار باید یک تابع برای نمایش یا عدم نمایش scopeBar بنویسیم و از حالت اتوماتیک آن را در بیاوریم.
اگر کاربر دکمه کنسل را بزند باید پنهان شود و در صورت انتخاب یک توکن نمایش داده شود
</p>

## <div dir="rtl">شخصی سازی</div>
<ul dir="rtl">
	<li>تغییر رنگ نوشته به سبز 
		<li> تغییر رنگ background به سبز 
			<li>تغییر رنگ توکن ها 
</ul>
<img src ="https://github.com/sharif-dev/UISearchController/blob/master/images/custom.png"  width ="840"  height="800" />

