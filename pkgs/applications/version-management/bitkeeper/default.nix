{ stdenv, fetchurl, bison, gperf, groff, libXft, perl, pkgconfig }:

stdenv.mkDerivation rec {
  name = "bitkeeper-${version}";
  version = "7.2ce";

  src = fetchurl {
    url = "https://www.bitkeeper.org/downloads/latest/bk-${version}.src.tar.gz";
    sha256 = "057zgaiqjy0rd0gmr3qycs8j9k2cvlz6n2mkpf4xmkmgfdc7dklg";
  };
  sourceRoot = "bk-${version}/src";

  buildInputs = [
    bison
    gperf
    groff
    libXft
    perl
    pkgconfig
  ];

  buildFlags = [ "p" ];

  # doCheck = true;
  # checkFlags = [ "-Ct" ];

  installFlags = [ "BINDIR=$(out)/opt/bitkeeper" ];
  postInstall = ''
    install -d -- "$out/bin" "$out/share/man/man1"
    ln -s -- "$out/opt/bitkeeper/bk" "$out/bin/bk"
    find "$out/opt/bitkeeper/man/man1" -type f -name 'bk*.1' -print0 | xargs -0 ln -st "$out/share/man/man1" --
  '';

  meta = {
    description = "The original distributed source management system";
    longDescription = ''
      BitKeeper is a fast, enterprise-ready, distributed SCM that scales up to
      very large projects and down to tiny ones.
    '';
    homepage = https://www.bitkeeper.org/;
    license = stdenv.lib.licenses.asl20;
  };
}
