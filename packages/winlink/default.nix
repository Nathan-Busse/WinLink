{
  stdenv,
  lib,
  fetchFromGitHub,
  makeWrapper,
  freerdp3,
  dialog,
  libnotify,
  netcat,
  iproute2,
  ...
}:
let
  rev = "a4d30724b588cea9c3c60279d8773d320f621594";
  hash = "sha256-k6T4YkIxqvmPB9XIdFL+p3Dh+jL3Xg/Co+q3xbCcsoc=";
in
stdenv.mkDerivation rec {
  pname = "winlink";
  version = "0-unstable-2025-04-19";

  src = fetchFromGitHub {
    owner = "winlink-org";
    repo = "winlink";

    inherit rev hash;
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [
    freerdp3
    libnotify
    dialog
    netcat
    iproute2
  ];

  patches = [
    ./winlink.patch
    ./setup.patch
  ];

  postPatch = ''
    substituteAllInPlace bin/winlink
    substituteAllInPlace setup.sh
    patchShebangs install/inquirer.sh
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    mkdir -p $out/src

    cp -r ./ $out/src/

    install -m755 -D bin/winlink $out/bin/winlink
    install -m755 -D setup.sh $out/bin/winlink-setup

    for f in winlink-setup winlink; do
      wrapProgram $out/bin/$f \
        --set LIBVIRT_DEFAULT_URI "qemu:///system" \
        --prefix PATH : "${lib.makeBinPath buildInputs}"
    done

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/winlink-org/winlink";
    description = "Run Windows applications (including Microsoft 365 and Adobe Creative Cloud) on GNU/Linux with KDE, GNOME or XFCE, integrated seamlessly as if they were native to the OS. Wayland is currently unsupported.";
    mainProgram = "winlink";
    platforms = platforms.linux;
    license = licenses.agpl3Plus;
  };
}
