{ stdenv, lib, fetchFromGitHub, buildPackages, pkg-config, cmake
, alsa-lib, glib, libpulseaudio
, AudioUnit, CoreAudio, CoreMIDI, CoreServices
}:

stdenv.mkDerivation rec {
  pname = "fluidsynth";
  version = "2.2.8";

  src = fetchFromGitHub {
    owner = "FluidSynth";
    repo = "fluidsynth";
    rev = "v${version}";
    sha256 = "sha256-zJMe2skFeXhrAx9vBcTXWJLfivI/iXyc0JFlNKpBETQ=";
  };

  nativeBuildInputs = [ buildPackages.stdenv.cc pkg-config cmake ];

  buildInputs = [ glib ]
    ++ lib.optionals stdenv.isLinux [ alsa-lib libpulseaudio ]
    ++ lib.optionals stdenv.isDarwin [ AudioUnit CoreAudio CoreMIDI CoreServices ];

  cmakeFlags = [ "-Denable-framework=off" "-Denable-jack=off" "-Denable-libsndfile=off" ];

  meta = with lib; {
    description = "Real-time software synthesizer based on the SoundFont 2 specifications";
    homepage    = "https://www.fluidsynth.org";
    license     = licenses.lgpl21Plus;
    maintainers = with maintainers; [ goibhniu lovek323 ];
    platforms   = platforms.unix;
  };
}
