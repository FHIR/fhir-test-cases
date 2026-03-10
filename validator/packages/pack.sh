#!/bin/bash

cd hl7.fhir.test.v1
tar -czf hl7.fhir.test.v1.tgz package
cd ..
cp hl7.fhir.test.v1/hl7.fhir.test.v1.tgz hl7.fhir.test.v1.tgz
rm hl7.fhir.test.v1/hl7.fhir.test.v1.tgz

cd hl7.fhir.test.v2
tar -czf hl7.fhir.test.v2.tgz package
cd ..
cp hl7.fhir.test.v2/hl7.fhir.test.v2.tgz hl7.fhir.test.v2.tgz
rm hl7.fhir.test.v2/hl7.fhir.test.v2.tgz

cd hl7.fhir.test.v3
tar -czf hl7.fhir.test.v3.tgz package
cd ..
cp hl7.fhir.test.v3/hl7.fhir.test.v3.tgz hl7.fhir.test.v3.tgz
rm hl7.fhir.test.v3/hl7.fhir.test.v3.tgz