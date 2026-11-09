## 0.0.4

* `Growable.showCollapsedWhenExpanded`: false makes `expanded` replace
  `collapsed`, cross-fading between them as `expandable`'s `Expandable` does,
  for a preview that gives way to the whole. Defaults to true, the existing
  behavior, where `collapsed` stays above `expanded`.

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
