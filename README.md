# sormuras/modules

The main goal of this project is to collect [Unique Java Modules](#unique-java-modules).
As a side product, it also assembles an overview of "almost all" Java modules published at Maven Central since August 2018.

> You're welcome to extend [The Watch](#watchlist), because _modules are coming_... and soon the rhyme goes "Modules, Modules, every where!"


## Unique Java Modules

Here's the daily updated 🦄 [modules.properties](com.github.sormuras.modules/com/github/sormuras/modules/modules.properties) file of unique modules.

This project considers a Java module to be **unique**:

- if it is an explicit module with a compiled module descriptor,
- and if its module name that starts with its Maven Group ID or a well-known alias.

Well-known aliases are defined as:

```java
static String computeMavenGroupAlias(String group) {
  return switch (group) {
    case "com.fasterxml.jackson.core" -> "com.fasterxml.jackson";
    case "com.github.almasb" -> "com.almasb";
    case "javax.json" -> "java.json";
    case "net.colesico.framework" -> "colesico.framework";
    case "org.jetbrains.kotlin" -> "kotlin";
    case "org.jfxtras" -> "jfxtras";
    case "org.openjfx" -> "javafx";
    case "org.ow2.asm" -> "org.objectweb.asm";
    case "org.projectlombok" -> "lombok";
    case "org.swimos" -> "swim";
    default -> group.replace("-", "");
  };
}
```

Find module `com.github.sormuras.modules` also attached as an executable JAR and [ToolProvider](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/spi/ToolProvider.html) in the assets of [releases/tag/0-ea](https://github.com/sormuras/modules/releases/tag/0-ea).
Stable versions of it are published to [releases](https://github.com/sormuras/modules/releases); with [releases/latest](https://github.com/sormuras/modules/releases/latest) pointing to the latest stable release.


## More Modules found at Maven Central

This [doc](doc) directory hosts lists of Maven `Group:Artifact` coordinates in text files.
They are taken as an input of the scan process.
The [scanner](.bach/build/build/Scanner.java) generates overview tables showing the state of modularization for each `Group:Artifact` coordinate.
All JAR files published to Maven Central that were analyzed and recorded by the [modulescanner](https://github.com/sandermak/modulescanner) are evaluated using their latest version.
That modulescanner was activated in mid of August 2018 - meaning earlier publications can not be evaluated here.

You'll find the following summary at the start of each overview.

- 🧩 denotes a Java module that contains a compiled module descriptor.
  It therefore provides a stable module name and an explicit modular API using `exports`, `provides`, `opens` and other directives.

- ⬜ denotes an automatic Java module, with its stable module name derived from `Automatic-Module-Name` manifest entry.
  Its API is derived from JAR content and therefore may **not** be stable.

- ⚪ denotes an automatic Java module, with its **not** stable module name derived from the JAR filename.
  Its API is derived from JAR content and therefore may **not** be stable.

- ➖ denotes an unrelated artifact, like BOM, POM, and other non-JAR packaging types.
  It also denotes old JAR files, as the scan process can only evaluate artifacts that were deployed after mid August 2018.

### WatchList

📜 [WatchList](doc/WatchList.txt.md) overview.

Compiled from [WatchList.txt](doc/WatchList.txt), which contains a community-curated list of Maven `Group:Artifact` lines.

### Top1000-2020

📜 [Top1000-2020.txt.md](doc/Top1000-2020.txt.md)

[Top1000-2010.txt](doc/Top1000-2020.txt) contains 1,000 Maven `Group:Artifact` lines sorted by download popularity as of December 2020.
This list may include some non-JAR entries (`pom`, `bom`, ...).
It also contains entries that were not updated since August 2018.

### Top1000-2019

📜 [Top1000-2019.txt.md](doc/Top1000-2019.txt.md)

[Top1000-2019.txt](doc/Top1000-2019.txt) contains 1,000 Maven `Group:Artifact` lines sorted by download popularity as of December 2019.
This list also includes non-JAR entries (`pom`, `bom`, ...).
It also contains entries that were not updated since August 2018.


## Suspicious Artifacts

Find lists of suspicious Maven artifacts in the [doc/suspicious](doc/suspicious) directory.

For example, a Maven artifact is considered to be suspicious if its JAR file contains an illegal `Automatic-Module-Name` manifest entry.
Illegal? An empty name, a name that contains `-` characters, a name starting numbers, a name that contains Java keywords, etc., is illegal.
Consult chapter [Module Declarations](https://docs.oracle.com/javase/specs/jls/se9/html/jls-7.html#jls-7.7) of the Java Language Specification for details.
TLDR; the name must be usable in `requires NAME;` directives of other modules. 

Another example is a Maven artifact that contains one or more `module-info.class` files from one or more other Maven artifacts that are already packaged as Java modules. 
Usually, this is an unwanted side-effect of shad(ow)ing 3rd-party libraries.
