## 0.0.3

* Accessibility: `Growable`'s collapsed and expanded parts are their own
  semantics nodes, so screen readers reach their text instead of it merging
  into a tappable header.
* `GrowableButton` reports expanded or collapsed to screen readers and takes
  an optional `semanticLabel`; a `GrowableIcon` on its own reads "Expand" or
  "Collapse".
* New `GrowableSemantics` for custom toggles (e.g. a `ListTile` whose
  `onTap` toggles the controller).
* `GrowablePanel`'s tap-the-body shortcut no longer turns the body into a
  button for screen readers.

## 0.0.1

* Initial release.
