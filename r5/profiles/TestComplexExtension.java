package org.hl7.fhir.r5.profiles;

import java.util.List;
import java.util.ArrayList;
import java.util.Date;

import java.math.BigDecimal;
import javax.annotation.Nullable;

import org.hl7.fhir.r5.context.IWorkerContext;
import org.hl7.fhir.r5.model.*;
import org.hl7.fhir.r5.profilemodel.PEBuilder;
import org.hl7.fhir.r5.profilemodel.PEInstance;
import org.hl7.fhir.r5.profilemodel.PEBuilder.PEElementPropertiesPolicy;
import org.hl7.fhir.r5.profilemodel.gen.PEGeneratedBase;
import org.hl7.fhir.r5.profilemodel.gen.Min;
import org.hl7.fhir.r5.profilemodel.gen.Max;
import org.hl7.fhir.r5.profilemodel.gen.Label;
import org.hl7.fhir.r5.profilemodel.gen.Doco;
import org.hl7.fhir.r5.profilemodel.gen.BindingStrength;
import org.hl7.fhir.r5.profilemodel.gen.ValueSet;
import org.hl7.fhir.r5.profilemodel.gen.MustSupport;
import org.hl7.fhir.r5.profilemodel.gen.Definition;


// Generated by the HAPI Java Profile Generator, {date}

/**
 * A complex extension - an extension with 2 levels
 *
 */
public class TestComplexExtension extends PEGeneratedBase {

  public static final String CANONICAL_URL = "http://hl7.org/fhir/test/StructureDefinition/pe-extension-complex|0.1";

  @Min("1") @Max("*") @Doco("Additional content defined by implementations")
  @Definition("May be used to represent additional information that is not part of the basic definition of the element. To make the use of extensions safe and managable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer can define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension.")
  private List<Extension> extensions = new ArrayList<>();// @NotNull  // Additional content defined by implementations

  @Min("0") @Max("2") @Doco("A code")
  @MustSupport(true)
  @Definition("A code for the extension")
  private List<Coding> slice1s = new ArrayList<>();  // A code

  @Min("0") @Max("*") @Doco("More Details")
  @Definition("More details")
  private List<StringType> slice2s = new ArrayList<>();  // More Details

  @Min("1") @Max("1") @Doco("Justification Details")
  @MustSupport(true)
  @Definition("Justification Details.")
  private Extension slice3;// @NotNull  // Justification Details


  /**
   * Parameter-less constructor.
   *
   */
  public TestComplexExtension() {
  }

  /**
   * Used when loading other models 
   *
   */
  public static TestComplexExtension fromSource(PEInstance source) {
    TestComplexExtension theThing = new TestComplexExtension();
    theThing.workerContext = source.getContext();
    theThing.load(source);
    return theThing;
  }

  public void load(PEInstance src) {
    clear();
    for (PEInstance item : src.children("extension")) {
      extensions.add((Extension) item.asDataType());
    }
    for (PEInstance item : src.children("slice1")) {
      slice1s.add((Coding) item.asDataType());
    }
    for (PEInstance item : src.children("slice2")) {
      slice2s.add((StringType) item.asDataType());
    }
    if (src.hasChild("slice3")) {
      slice3 = (Extension) src.child("slice3").asDataType();
    }

  }

  public void save(PEInstance tgt, boolean nulls) {
    tgt.clear("extension");
    for (Extension item : extensions) {
      tgt.addChild("extension", item);
    }
    tgt.clear("slice1");
    for (Coding item : slice1s) {
      tgt.makeChild("slice1").data().setProperty("value[x]", item);
    }
    tgt.clear("slice2");
    for (StringType item : slice2s) {
      tgt.makeChild("slice2").data().setProperty("value[x]", item);
    }
    tgt.clear("slice3");
    if (slice3 != null) {
      tgt.makeChild("slice3").data().setProperty("value[x]", slice3);
    }

  }

  /**
   * May be used to represent additional information that is not part of the basic 
   * definition of the element. To make the use of extensions safe and managable, 
   * there is a strict set of governance applied to the definition and use of 
   * extensions. Though any implementer can define an extension, there is a set of 
   * requirements that SHALL be met as part of the definition of the extension.
   *
   */
  public List<Extension> getExtensions() {
    if (extensions == null) { extensions = new ArrayList<>(); }
    return extensions;
  }

  public boolean hasExtensions() {
    return extensions != null && !extensions.isEmpty();
  }

  public Extension addExtension() {
    Extension theThing = new Extension();
    getExtensions().add(theThing);
    return theThing;
  }

  public boolean hasExtension(Extension item) {
    return hasExtensions() && extensions.contains(item);
  }

  public void removeExtension(Extension item) {
    if (hasExtension(item)) {
      extensions.remove(item);
    }
  }


  /**
   * A code for the extension
   *
   */
  public List<Coding> getSlice1s() {
    if (slice1s == null) { slice1s = new ArrayList<>(); }
    return slice1s;
  }

  public boolean hasSlice1s() {
    return slice1s != null && !slice1s.isEmpty();
  }

  public Coding addSlice1() {
    Coding theThing = new Coding();
    getSlice1s().add(theThing);
    return theThing;
  }

  public boolean hasSlice1(Coding item) {
    return hasSlice1s() && slice1s.contains(item);
  }

  public void removeSlice1(Coding item) {
    if (hasSlice1(item)) {
      slice1s.remove(item);
    }
  }


  /**
   * More details
   *
   */
  public List<StringType> getSlice2s() {
    if (slice2s == null) { slice2s = new ArrayList<>(); }
    return slice2s;
  }

  public boolean hasSlice2s() {
    return slice2s != null && !slice2s.isEmpty();
  }

  public StringType addSlice2() {
    StringType theThing = new StringType();
    getSlice2s().add(theThing);
    return theThing;
  }

  public boolean hasSlice2(StringType item) {
    return hasSlice2s() && slice2s.contains(item);
  }

  public void removeSlice2(StringType item) {
    if (hasSlice2(item)) {
      slice2s.remove(item);
    }
  }


  /**
   * Justification Details.
   *
   */
  public Extension getSlice3() {
    if (slice3 == null) { slice3 = new Extension(); }
    return slice3;
  }

  public TestComplexExtension setSlice3(Extension value) {
    this.slice3 = value;
    return this;
  }
  public boolean hasSlice3() {
    return slice3 != null;
  }



  public void clear() {
    extensions.clear();
    slice1s.clear();
    slice2s.clear();
    slice3 = null;

  }

}
