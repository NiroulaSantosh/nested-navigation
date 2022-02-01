# nested_nav

**Challanges**
- How to add persistence appbar and bottom nav bar.
- How to handle h/w backbutton pressed (like in android) --> if you are inside /home/details and you pressed the back button on android this will close the app.

**Solution**
- Create new Navigator widget for each of the tab item and send them the GLobalKey<NavigatorState> and handle there respective route inside there Navigator widget
- In Main Navigator of page you have to add WillPopScope widget and pop screen based on the current route state(which is given by the navigator key of respective pages). If route will allow pop then pop the screen during the h/w backbutton action.
  to find if route is ready or not add the followingn logic
  ```
  WillPopScope(
      onWillPop: () async {
        return !await _navKeys[_currentTab].currentState!.maybePop();
      },
     child: // your main scaffold
  );
