{
  lib,

  buildDotnetModule,
  fetchFromGitHub,

  dotnetCorePackages,
  fetchNuGet,
  mkNugetDeps,
}:

buildDotnetModule rec {
  pname = "IronyModManager";
  version = "1.26.173";

  src = fetchFromGitHub {
    owner = "bcssov";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-xlwDt937lyal/URomWB+l7UlSFnG3w9HsO5r8pyfqPQ=";
  };

  dotnet-sdk = dotnetCorePackages.sdk_8_0;
  dotnet-runtime = dotnetCorePackages.runtime_8_0;

  projectFile = [ "src/IronyModManager/IronyModManager.csproj" ];

  executables = [ "IronyModManager" ];

  nugetDeps = #./deps.nix;
  [
    (fetchNuGet {
      pname = "CWTools.Irony-Private";
      version = "0.4.0-alpha8";
      url = "https://github.com/bcssov/IronyModManager/files/7798143/CWTools.Irony-Private.0.4.0-alpha8.zip";
      sha256 = "sha256-HO+9XhH2EvoLz4XeII7NGPeCvcldPa6gOx9bfje4i+c="; })
  ];


  meta = with lib; {
    description = "Mod Manager for Paradox Games.";
    mainProgram = "IronyModManager";
    homepage = "https://github.com/bcssov/IronyModManager";
    longDescription = ''
      Irony Mod Manager is a new advanced mod manager for Paradox Games, it started out as
      a Stellaris oriented Mod Manager at first with plans to add additional games later. Not all of
      the advanced Stellaris equivalent features might be available for most supported games
      but that might change depending on community support in these games. In order to have
      a fully operational conflict solver Irony needs to understand the game structure and
      whether certain game folders utilize FIOS\LIOS rules.
    '';
    license = licenses.mit;
    platforms = with platforms; linux;
  };
}
