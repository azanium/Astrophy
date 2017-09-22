# Astro TV Guide
An Astro TV Guide App 

# Descriptions
This is a app for iOS using Swift 3.x for proof of concept of Astro TV Programming Challenge

# Architecture
The architecture is using VIP (View Interactor Presenter) clean architecture with template from 
http://clean-swift.com

# Git branching model
http://nvie.com/posts/a-successful-git-branching-model/

# Reactive
The app uses RxCocoa along with RxSwift for binding data into TableView

# Detail Task
- Display list of Astro Channels with features: 
  * Sort Channel Number
  * Sort Channel Name
  * Tag a favorite channel
  * Persist favorite channel with Realm Database
  * Removed favorite channel from Main page

- Astro TV Guide with features
  * Display channels as sliders with it's programmes events automatically synced with Top Bar Time Seeker
  * Create a time seeker custom component that can seek time
  * Adapat channel programmes' show time from UTC into local time
  * Sort Channel Number
  * Sort Channel Name
  * Channel list loaded using pagination with 10 rows per request
  * Channel list pagination loaded using lazy loading. Loading new page will be triggered, once scroll reached to bottom.
  

# Dependencies
* Framework dependency manager using Cocoapods
* HTTP framework using Alamofire 4.4
* Image Cache framework using Kingfisher
* RxSwift 
* RxCocoa
* RealmSwift
* SnapKit
* SwiftyJSON
* Hue
