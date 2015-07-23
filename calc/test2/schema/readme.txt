Contains demonstration of generating ElementTypes document from a sample schema.

To run the ElementTypes generator:

Prerequisite:
1) Java JDK 1.6 or later
2) maven 3.0 or equivalent installed configured with Java JDK from 1)

From command prompt: 
1) Set working directory to the directory containng this readme.txt file and the pom.xml file
2) Run maven command : mvn clean compile
3) View the SampleElementTypes.xml document generated in the working directory.



To Modify Example or Replace with another Schema
You can proceed in one of the following ways:
1)      Manipulate the Sample schema provided in the example. 
        You can add additional element to the Sample schema and run the ElementTypes generator again to see the results.
2)      Or they can Substitute in another schema and update the pom.xml file to identify the new schema file, 
        the name of the schema root element and the name of the parent element that contains the “form” elements. 
        These parameters are defined in the pom.xml file in the Schema directory under the Schema Sample:

        <properties>
            <!-- Parameters - Change these as needed or override via -D when running maven command -->
            <inputFile>Sample/Sample.xsd</inputFile>                    
            <outputFile>SampleElementTypes.xml</outputFile>
            <elementRoot>/Root</elementRoot>
            <formRoot>/Root/Data</formRoot>
            <includeAnnotations>false</includeAnnotations>     
            <includeFacets>false</includeFacets>
               …
        </properties>

        The inputFile parameter identifies the name of the schema File. This can be a simple one file schema or it can be the file containing the root element when the schema has been broken up into multiple files using include statements.
        The outputFile parameter identifies the name of the output ElementTypes file.
        The elementRoot parameter identifies the name of the root element within the schema. Note that schemas are not required to have a single root element and this how the root is disambiguated.
        The formRoot parameter identifies the name of the element containing the form elements. Specifying this allow the forms to be identified in the output ElementTypes document.
