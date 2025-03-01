# bdd_demo

Demo BDD ideas with patrol

## Getting Started

Using
https://plugins.jetbrains.com/plugin/9164-gherkin

* You can see better formatted feature files etc
* But you may want to disable the inspections for now
* It does show the cucumber symbol in project view which is nice
* the vscode plugin has a *million* installs https://marketplace.visualstudio.com/items?itemName=alexkrechik.cucumberautocomplete


```shell
dart run build_runner watch --delete-conflicting-outputs
````
or if it complains about version solving failed
```shell
flutter pub run build_runner watch -d
```
