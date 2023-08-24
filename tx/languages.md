# How Languages work 

The tests assume that the client might want to do one of three things:

* just accept whatever language the server is going to return, based on the server default and the code system definitions
* specify the return language desired
* specify the return language and in addition, request designations from additional languages (all, or specified languages)

the tests here test out these combinations


## Simple Echo

* **language-echo-en-none**: just return codes from an english based code system. All codes get english displays
* **language-echo-de-none**: just return codes from an german based code system. All codes get german displays
* **language-echo-en-multi-none**: Just return codes from an english based code system that also has german designations (which are also requested)


## Specify the language

You can specify the language three different ways: 
* Using a displayLanguage parameter
* Using the http Accept-Language header 

The Accept-Language header is theoretically better since you specify multiple languages with weights, but it's not clear
what the point would be. The displayLanguage language parameter has exactly the same semantics as the Accept-Language header,
but overrides the HTTP header if it's provided. The primary advantage of the displayLanguage parameter is that you specify 
it at a higher level in the stack. In addition, the value set itself can specify the parameter using the 
http://hl7.org/fhir/tools/StructureDefinion/valueset-expansion-param extension. Note that this overrides the http header but not 
the expansion parameter. The sequence of pre-eminance is:
* Expansion Parameter provided in the call
* Expansion parameter provided in the value set
* HTTP Header

* **language-echo-en-en**: Specify to return in english. Three variants which all have the same response:
  * language-echo-en-en-param: using the displayLanguage parameter
  * language-echo-en-en-vs: using the displayLanguage parameter in the value set
  * language-echo-en-en-header: using the http header

* **language-echo-de-de**: Specify to return in german. Three variants which all have the same response:
  * language-echo-de-de-param: using the displayLanguage parameter
  * language-echo-de-de-vs: using the displayLanguage parameter in the value set
  * language-echo-de-de-header: using the http header

* **language-echo-en-multi-en**: Specify to return in english, but since the code system has german designations, get them too. Three variants which all have the same response:
  * language-echo-en-multi-en-param: using the displayLanguage parameter
  * language-echo-en-multi-en-vs: using the displayLanguage parameter in the value set
  * language-echo-en-multi-en-header: using the http header

* **language-xform-en-multi-de-soft**: Specify to return in german, switching designations and displays, but fall-back to english if no german is found, by specifying language as ```de,*```. Three variants which all have the same response:
  * language-xform-en-multi-de-param: using the displayLanguage parameter
  * language-xform-en-multi-de-vs: using the displayLanguage parameter in the value set
  * language-xform-en-multi-de-header: using the http header