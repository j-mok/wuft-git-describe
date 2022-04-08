using System.Diagnostics;
using System.Reflection;

var executingAssembly = Assembly.GetExecutingAssembly();
var assemblyName = executingAssembly.GetName();
var fileVersionInfo = FileVersionInfo.GetVersionInfo(executingAssembly.Location);

Console.WriteLine("Hello, World from version:");
Console.WriteLine(" assembly      : " + assemblyName.Version);
Console.WriteLine(" file          : " + fileVersionInfo.FileVersion);
Console.WriteLine(" informational : " + fileVersionInfo.ProductVersion);
