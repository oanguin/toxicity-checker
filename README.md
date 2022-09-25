# toxicity_checker
A new Flutter project used for checking the toxicity of various products.

## Local Development
* Run release version of application locally `flutter run --release`

## Production Builds
* Run the following command to do a production build/run
  * `flutter build --dart-define=SOME_VAR=SOME_VALUE --dart-define=OTHER_VAR=OTHER_VALUE`
  * `flutter run --dart-define=SOME_VAR=SOME_VALUE --dart-define=OTHER_VAR=OTHER_VALUE`
* These are the required values for a production build/run. Please check LastPassword or some other
  keystore for these values.
  * `GOOGLE_ADS_MANAGER_UNIT_ID_ANDROID`
    * Used for Google Ads Manager to load banner ads on Android 
  * `GOOGLE_ADS_MANAGER_UNIT_ID_IOS`
    * * Used for Google Ads Manager to load banner ads on IOS 
  * `NUTRITIONIX_URL`

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
## Testing Mocks
* Generate mocks using `flutter packages pub run build_runner build --delete-conflicting-outputs`

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

## API Documentation
### [nutritionix](https://developer.nutritionix.com/)
This API is used to get information related to ingredients. Specifications can be found [here](https://docs.google.com/document/d/1_q-K-ObMTZvO0qUEAxROrN3bwMujwAN25sLHwJzliK0/edit#).

### [food-api-solutions](https://geekflare.com/food-api-solutions/)
This website shows other related food check APIs which can be used in the future.

