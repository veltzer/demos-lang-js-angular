# TOFIX

Findings from a code scan on 2026-10-04.

## Medium

- `src/material/toolbar.html:47` - `<div flex=>` is a malformed attribute (empty unquoted value); make it `<div flex></div>` so the spacer actually gets Angular Material's `flex` layout.
- `src/basic/ng_init.html:17` - `<span data-ng-bind="firstName"/>` is not a void element in HTML, so the `/>` is ignored and the span stays open until `</p>`; write `<span data-ng-bind="firstName"></span>`.
- `src/material/hello.html:18` - loads `angular-messages` 1.5.3 while every other angular script on the page (and in all other demos) is 1.5.7; mixing AngularJS module versions is unsupported. Use 1.5.7, or drop the script since `src/material/hello.js:3` does not depend on `ngMessages`.

## Low

- `src/material/list.js:17` - `AppCtrl` (selectedIndex/secondLocked/next/previous) is a copy of `src/material/tabs.js:17` and nothing in `src/material/list.html` uses it; the same state is also unused in `src/material/tabs.html`. Trim both controllers to what the pages reference, and drop the `.config()` blocks whose only body is commented out (`src/material/list.js:7`, `src/material/tabs.js:7`).
- `src/material/tabs.css:1` - the `.md-tab` rule contains only a commented-out property; delete it or reduce the file to the "(none yet)" stub used by the other component stylesheets.
- `src/material/list.html:30` - uses `ng-click` while every other directive in the repo uses the `data-ng-*` form; switch to `data-ng-click` for consistency (and HTML validity).
- `config/project.lua:5` - keyword `typescript`, but the repo has no TypeScript (AngularJS 1.5 with plain JS); remove the keyword.
- `src/basic/hello.html:8` (and every other page) - typo "neccessary" -> "necessary"; also every page has the same `<title>simple angular.js demo</title>`, give each page a distinct title.
- `.oxlintrc.json:7` - fleet-wide shared file: `$schema` points at `./node_modules/oxlint/configuration_schema.json`, which does not exist in this repo (no npm, no node_modules); point it at the published schema URL or drop the key, everywhere at once.
