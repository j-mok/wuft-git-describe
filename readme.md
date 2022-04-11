# Versioning With git-describe

This is a small demonstration of how `git-describe` tool can be used to derive artifact (assembly)
version directly from Git. How to test it:
- Regular Debug build of the project produces a console application that prints out its own assembly, file
and informational version:
```
> TellYourVersion.exe
Hello, World from version:
 assembly      : 1.0.0.0
 file          : 1.0.0.0
 informational : 1.0.0
```
* `build.ps1` simulates an automated CI build. It produces a Release assembly and a NuGet package whose version is determined
by the output from `git-describe` and indirectly by the current commit (here for v2.0.0):
```
> TellYourVersion.exe
Hello, World from version:
  assembly      : 2.0.0.0
  file          : 2.0.0.0
  informational : v2.0.0
```
---
Note: check out commits starting at `v1.0.0` and later - these are "dummy" commit used to simulate
source code development.
