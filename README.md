# nested_nav

**Challanges**
1. How to add persistence appbar and bottom nav bar.
2. How to handle h/w backbutton pressed (like in android) --> if you are inside `/home/details` and you pressed the back button on android this will close the app.

**Solution**
1. Create new Navigator widget for each of the tab item and send them the `GlobalKey<NavigatorState>` and handle there respective route inside there Navigator widget
2. In Main Navigator of page you have to add WillPopScope widget and pop screen based on the current route state(which is given by the navigator key of respective pages). If route will allow pop then pop the screen during the h/w backbutton action.
  to find if route is ready or not add the followingn logic
  ```
  WillPopScope(
      onWillPop: () async {
        return !await _navKeys[_currentTab].currentState!.maybePop();
      },
     child: // your main scaffold
  );
  
  ```
  
  **Pros**
  - you can handle each tab navigation separately. Avoid navigation crowd in main route. 
  - Helps to code modularization. 
  
  **Cons**
  - Each time you tab bottom nav tab new widget is build, unlike tab view the widget are not placed inside stack. For this you can use `IndexedStack` widget of flutter. But this will not work for me (I don't know how to do). If you have idea share.
  - You have to use generated route.
