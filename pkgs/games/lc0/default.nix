{ stdenv
, fetchFromGitHub
, cmake
, meson
, ninja
# , boost
# , opencl-headers
# , ocl-icd
# , qtbase
# , zlib
}:

stdenv.mkDerivation rec {
  pname = "lc0";
  version = "0.22.0";

  src = fetchFromGitHub {
    owner = "LeelaChessZero";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "1hy2sqksf7g0xvvh8abdraxwqj1wbxnwsm9h60rgp7a44ax90r0f";
    fetchSubmodules = true;
  };

  # buildInputs = [ boost opencl-headers ocl-icd qtbase zlib ];

  nativeBuildInputs = [ cmake meson ninja ];

  enableParallelBuilding = true;

  patchPhase = ''
    patchShebangs build.sh
  '';

  buildPhase = ''
    ./build.sh release
  '';

  meta = with stdenv.lib; {
    description = "Chess engine modeled after AlphaGo Zero";
    homepage    = https://lczero.org/;
    license     = licenses.gpl3;
    maintainers = [ maintainers.peanutbutter144 ];
    platforms   = platforms.linux;
  };
}
