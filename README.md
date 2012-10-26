dvd-chaos
=========

DVD Catalog Handler and Other Stuff.

Overview
----------------
My general strategy with this project (in order of priority) was to:
1) Spend some time learning about the rails framework.  You notice commit churn as I
   did this.
2) Use cucumber and FactoryGirl to build tests before (or during) feature development.
   I did not do any UI related JS testing, and I didn't muck with the controller tests
   automatically created.
3) Complete as many of the requirements and optional use cases as possible.
4) Implement a killer UI (I never got to this one...as you'll see)

Given those priorities, I focused the majority of my efforts on test coverage as opposed
to the UI.  You'll notice the UI is simple (at best), but I believe I have 100%
*use case* coverage (didn't have time to wire up code coverage tools) with a few
exceptions below.

It is also worth pointing out that I used RubyMine for this.  All of the project files
are checked in.  My rails command line skills couldn't keep pace...yet.

Use Case Misses
----------------
* Searching by age range for actors/directors.  Just ran out of time given the deadline.
  Search was the last thing I did, and isn't cleaned up like I wanted it to be.  For
  example, the controller code to handle search  could be generic and in a helper...
  but is isn't.
* Ability to add actors/directors not already present while creating a dvd.  I chose not
  to do this one because I see it as purely a UI task (and I didn't focus on the UI).
  The underlying API should strictly deal with resources and not create side effects
  (good or bad) like automatically adding actors/directors.  In other words, that is
  and orchestration challenge the UI (or curl, etc.) can deal with.

General Comments
----------------
* Rails blows away python/django.  Was very impressed with the amount of effort
  put into generators, etc.  Very easy/efficient to use.
* You'll notice varying degrees or proper tests.  Took me a bit to get the feel of
  cucumber, and I didn't have time to go back and refactor the early tests.  In
  addition, I am sure there are better ways to validate results that one picks
  up over time.  I also went back and forth on how generic/specific to make the
  test steps.  Seems like an interesting topic.