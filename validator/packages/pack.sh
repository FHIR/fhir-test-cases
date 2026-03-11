#!/bin/bash

cd hl7.fhir.test.verA#1.0.0
tar -czf hl7.fhir.test.verA#1.0.0.tgz package
cd ..
cp hl7.fhir.test.verA#1.0.0/hl7.fhir.test.verA#1.0.0.tgz hl7.fhir.test.verA#1.0.0.tgz
rm hl7.fhir.test.verA#1.0.0/hl7.fhir.test.verA#1.0.0.tgz

cd hl7.fhir.test.verA#2.0.0
tar -czf hl7.fhir.test.verA#2.0.0.tgz package
cd ..
cp hl7.fhir.test.verA#2.0.0/hl7.fhir.test.verA#2.0.0.tgz hl7.fhir.test.verA#2.0.0.tgz
rm hl7.fhir.test.verA#2.0.0/hl7.fhir.test.verA#2.0.0.tgz

cd hl7.fhir.test.verB#1.0.0
tar -czf hl7.fhir.test.verB#1.0.0.tgz package
cd ..
cp hl7.fhir.test.verB#1.0.0/hl7.fhir.test.verB#1.0.0.tgz hl7.fhir.test.verB#1.0.0.tgz
rm hl7.fhir.test.verB#1.0.0/hl7.fhir.test.verB#1.0.0.tgz

cd hl7.fhir.test.verB#2.0.0
tar -czf hl7.fhir.test.verB#2.0.0.tgz package
cd ..
cp hl7.fhir.test.verB#2.0.0/hl7.fhir.test.verB#2.0.0.tgz hl7.fhir.test.verB#2.0.0.tgz
rm hl7.fhir.test.verB#2.0.0/hl7.fhir.test.verB#2.0.0.tgz

cd hl7.fhir.test.verC#1.0.0
tar -czf hl7.fhir.test.verC#1.0.0.tgz package
cd ..
cp hl7.fhir.test.verC#1.0.0/hl7.fhir.test.verC#1.0.0.tgz hl7.fhir.test.verC#1.0.0.tgz
rm hl7.fhir.test.verC#1.0.0/hl7.fhir.test.verC#1.0.0.tgz
