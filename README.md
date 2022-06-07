# toxicity_checker
A new Flutter project used for checking the toxicity of various products.

## Local Development
* Run release version of application locally `flutter run --release`

## Flutter Documentation

[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Flutter Dependencies
* [Google Fonts](https://pub.dev/packages/google_fonts)
* [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
* [Material UI](https://docs.flutter.dev/development/ui/widgets/material)
* [Mockito](https://pub.dev/packages/mockito)
* [Open Food Facts - Dart Plugin](https://github.com/openfoodfacts/openfoodfacts-dart/blob/master/DOCUMENTATION.md)

## Local Development Issues
* You may have an issue when you run locally. If you see an error related to `Iproxy` you need to open the `sdk/bin/cache/artifacts/usbmuxd/iproxy`
file with right click on Mac OSX and allow it permissions.

## Color Scheme
* [Reference](https://uxdesign.cc/how-the-60-30-10-rule-saved-the-day-934e1ee3fdd8)
### Application Colors
| %  	| Color                                                                      	| Code    	| Purpose                      	|
|----	|----------------------------------------------------------------------------	|---------	|------------------------------	|
| 60 	| <span style="color:#F5F5F5;background-color:#375501"> *Smoke White*</span> 	| 0xFFF5F5F5| - dominant<br>- background   	|
| 30 	| <span style="color:#375501">*Dark Green*</span>                            	| 0xFF375501| - secondary<br>- sub-widgets 	|
| 10 	| <span style="color:#69FF00">*Light Green*</span>                           	| 0xFF69FF00| - accent<br>- CTAs           	|

### Flutter Codes and Opacity
Flutter aspects the colors in the code in the following format `Colors(0xFFF5F5F5)` where the first two characters are the opacity
the opacity can be changed in the following manner.

<ul dir="auto">
<li>100% — FF</li>
<li>95% — F2</li>
<li>90% — E6</li>
<li>85% — D9</li>
<li>80% — CC</li>
<li>75% — BF</li>
<li>70% — B3</li>
<li>65% — A6</li>
<li>60% — 99</li>
<li>55% — 8C</li>
<li>50% — 80</li>
<li>45% — 73</li>
<li>40% — 66</li>
<li>35% — 59</li>
<li>30% — 4D</li>
<li>25% — 40</li>
<li>20% — 33</li>
<li>15% — 26</li>
<li>10% — 1A</li>
<li>5% — 0D</li>
<li>0% — 00</li>
</ul>

