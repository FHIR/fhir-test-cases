-------------

ok. we're going to write a little FHIR server that implements the Nigerian immunization IG found at https://build.fhir.org/ig/IntelliSOFT-Consulting/Nigeria-Immunization-FHIR-IG/. We're not setting out to write a production server, just a little sandbox. 

So let's start by creating a node.js project that (a) defines a package.json, (b) a server.js that simply returns a capability statement that doesn't yet declare any end-points, and also, loads and initialises the FHIR java validator for the IG, using the FHIR validator wrapper ('fhir-validator-wrapper')at https://www.npmjs.com/package/fhir-validator-wrapper

The relevant details for the validator are attached

-------------

ok, let's add database support. The server will use an sqlite database that it'll create on the fly when it starts up if it doesn't already exist. there'll be a table for resources, that has a list of all the resources uploaded to the server. 

For each resource, there'll be a primary key, type (of resource), an id (the server will use autoincrementing global integer for the id), a blob containing the resource as json, and a version (again, an incrementing integer). 

In addition, there'll be an index table that contains a list of index values for supporting search parameters. The table will have a primary key reference to the main resources table, and index name, and an index value. Note that there might be more than one value per index name. 

We won't worry about threading/contention issues, since this isn't a production server.

------------

ok. so when a Patient resource is posted or put to the server, it needs to be valid, as defined by the validator checking it against the profile http://example.org/StructureDefinition/NEIRPatient which is found in fhir.nigeriaImmunization#current, so we also want the validator to load that package at start up

remember to use the FHIR mime type application/fhir+json 


