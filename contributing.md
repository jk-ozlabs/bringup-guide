Contributing to the bringup guide
=================================

To avoid messy sources, the indenting rules for our docbook source are quite
strict. They are:

 * One-space indents, no tabs
 * A start tag always increases indent, an end tag decreases it
 * End tags on the same line as text, but only close one block per line
 * Wrap at 80 columns, where possible
 * Splitting a tag is fine

For example:

    <section id="opal-platform-slot-table">
     <!-- <section> start tag increases our indent -->
     <title>PCI slot tables</title>
     <para>Another component of the OPAL platform defintion is the PCI slot
      <!-- start tag also increases our indent here -->
      tables. These define the physical layout of the PCI bus hardware, and
      assign names to individual slots (whether or not those slots have a
      user-accessible connector).</para> <!-- end tag at the end of text -->

     <warning>
      <para>A PCI slot table can only be verified manually. If in doubt,
       disable the slot table.</para>
     </warning> <!-- not </para></warning> -->

Vi users:

    :set sw=1 tw=80 wrap et

Building the pdf
----------------

There are a few dependencies for building the pdf guide, mostly to support the
fop, xsl stylesheets and syntax highlighting.

You'll need:
  * A working java environment
  * The docbook 5 schema & stylesheets
  * The saxon XML library
  * The xslthl syntax highighter
  * The apache formatting objects processor (fop) package

On an Ubuntu machine, you should be able to:

    sudo apt-get install docbook-xsl docbook-xsl-ns docbook5-xml \
	    libsaxon-java libxerces2-java libxslthl-java fop fonts-inconsolata

The makefile & XSL sources expect system XML data to be installed in
`/usr/share/xml`, and the java libraries under `/usr/share/java`. If this isn't
the case in your build environment, you may want to set the `java_libdir` and
`xml_dir` make variables to point to the relevant install locations.
