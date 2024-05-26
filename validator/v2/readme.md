This directory contains the test cases for the base definitions of v2 as a set of FHIR Logical models

How these work:

* Messages, Segments and Structures are declared directly as their own types
* There's a base type for each of these that is an empty abstract class
* There's a profile for each of the types that applies rules to the definitions
* the profiles are supported by a set of code systems that lists each of the possible instantiations of the type
