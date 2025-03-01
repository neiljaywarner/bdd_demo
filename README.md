# bdd_demo

Demo BDD ideas with patrol

## Getting Started

Using
https://plugins.jetbrains.com/plugin/9164-gherkin

* You can see better formatted feature files etc
* see: https://github.com/neiljaywarner/bdd_demo/issues/2#issuecomment-2691822719
* But you may want to disable the inspections for now
* see: https://github.com/neiljaywarner/bdd_demo/issues/2#issuecomment-2691826690
* It does show the cucumber symbol in project view which is nice
* the vscode plugin has a *million* installs https://marketplace.visualstudio.com/items?itemName=alexkrechik.cucumberautocomplete

Miscellaneous:
* also see https://github.com/neiljaywarner/very_good_coffee/commit/c70e3f86286e5ab435c2c547e2600832ab1025ba#diff-65043151f1be51e719751c1a211de4d0a73d837a7eca8266abb20a1fb2253ae0
* https://pub.dev/packages/gits_cucumber
* https://www.npmjs.com/package/cucumber-html-reporter.

Note:
* textfields can use keys or tooltip
* https://pub.dev/packages/uuv_flutter
* patrol finders make finding things mcuh easier
* in listile and textfield hints etc
to run use:
(you may have to stop and restart when modify build.yaml)
```shell
dart run build_runner watch --delete-conflicting-outputs
````
or if it complains about version solving failed
```shell
flutter pub run build_runner watch -d
```
