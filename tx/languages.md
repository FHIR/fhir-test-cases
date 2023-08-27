# How Languages work 

The tests assume that the client might want to do one of three things:

* just accept whatever language the server is going to return, based on the server default and the code system definitions
* specify the return language desired, and whether or not to fall back to other langages if the desired language isn't available
* specify the return language and in addition, request designations from additional languages (all, or specified languages)

the tests here test out these combinations. To test this, we define four code systems, all basically related
to each other:

* codesystem-en-single.json - a set of codes with english displays
* codesystem-de-single.json - the same set of codes with german displays
* codesystem-en-multi.json - the same set of codes with english displays and additional displays and definitions in german with a smattering of other variants
* codesystem-de-multi.json - the same set of codes with german displays and additional displays and definitions in english with a smattering of other variants

Then a set of value sets are defined on this, that include all codes from one of those code systems. Some of the value sets specify the language of expansion (discussed below)

## Simple Echo

The first four tests simply echo the four code systems back with no language rules

* **language-echo-en-none**: just return codes from an english based code system. All codes get english displays
* **language-echo-de-none**: just return codes from an german based code system. All codes get german displays
* **language-echo-en-multi-none**: Just return codes from an english based code system that also has other designations (which are also requested)
* **language-echo-en-multi-none**: Just return codes from an english based code system that also has other designations (which are also requested)

## Specify the language that already exists

You can specify the language of the displays to return in four different ways: 
* Using a displayLanguage parameter in the request
* Using a displayLanguage parameter in the value set using the 
http://hl7.org/fhir/tools/StructureDefinion/valueset-expansion-param extension
* Using the http Accept-Language header 
* ValueSet.language

All accept multiple languages with weights per the Accept-Language specification; which to use is a matter 
of operational control on the client. These tests require that a server support all four. The sequence of 
pre-eminance is as in the list given above.

Each of the tests below comes as a set of variants, depending on how the language is specified:
* -param: using the displayLanguage parameter
* -vs: using the displayLanguage parameter in the value set
* -header: using the http header
* -vslang: using the value set language
* -mixed: mixing them up (testing precedence)

* **language-echo-en-en**: Specify to return the english code system in english (null operation)
* **language-echo-de-de**: Specify to return the german code system in german  (null operation)
* **language-echo-en-multi-en**: Specify to return the english code system in english, but since the code system has german designations, get them too
* **language-echo-de-multi-de**: Specify to return the german code system in german, but since the code system has english designations, get them too

## Change the language 

Having done these, we turn to the really interesting tests, switching the display language. These tests use the weight feature of the language, 
specifying to return en: ```displayLanguage: en```. By default, the wildcard is understood to be present at some low weight: ```displayLanguage: en, *; q=0.1```.
This results in the client getting displays in the language of it's choice, *if there are any*, and otherwise falling back to whatever is available. 
If the client wants to insist that it only get displays if they are in the specified language, it has to turn the wild card of explicitly: 
```displayLanguage: en, *; q=0```

For these tests, it's anticipated that the parameter handling tested out in the previous tests is working, so instead, these tests come in three 
variants:
* -soft
* -default
* -hard

* **language-xform-en-multi-de**: English to German
* **language-xform-de-multi-en**: German to English

## Restricting the designations

Finally, we turn to an efficiency concern - restricting the set of designations that we get back
using the designation parameter. We asked for designations, but we may only want a subset of the 
full set available. We could filter them on the client side, but it might be quite lot of traffic.

* language-echo-en-designation - only spanish designations
* language-echo-en-designations - german and english designations

## Validation

The validation use cases around language include tests for language 
specified as an http header, as a value set parameter, a value set language, 
and for various combinations of laguage weights.

Note that by default, the wildcard is understood to not be present.
