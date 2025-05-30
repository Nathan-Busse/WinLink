{
  stdenv,
  lib,
  fetchFromGitHub,
  makeWrapper,
  makeDesktopItem,
  callPackage,
  yad,
  ...
}:
let
  rev = "9b3f6c581791222a3a04508606755d6d0519f322";
  hash = "sha256-Hy/o5IY9HmTWaX54Ek5ABmppPpzgM+MdCrhzEzVmtwY=";
in
stdenv.mkDerivation rec {
  pname = "winlink-launcher";
  version = "0-unstable-2025-03-11";

  src = fetchFromGitHub {
    owner = "Nathan-Busse";
    repo = "WinLink-Launcher";

    inherit rev hash;
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [
    yad
    (callPackage ../winlink { })
  ];

  patches = [ ./WinLink-Launcher.patch ];

  postPatch = ''
    substituteAllInPlace WinLink-Launcher.sh
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r ./Icons $out/Icons

    install -m755 -D WinLink-Launcher.sh $out/bin/winlink-launcher
    install -Dm444 -T Icons/AppIcon.svg $out/share/pixmaps/winlink.svg

    wrapProgram $out/bin/winlink-launcher \
      --set LIBVIRT_DEFAULT_URI "qemu:///system" \
      --prefix PATH : "${lib.makeBinPath buildInputs}"

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "winlink";
      exec = "winlink-launcher";
      icon = "winlink";
      comment = meta.description;
      desktopName = "WinLink";
      categories = [ "Utility" ];
    })
  ];

  meta = with lib; {
    homepage = "https://github.com/Nathan-Busse/WinLink-Launcher";
    description = "Graphical launcher for WinLink. Run Windows applications (including Microsoft 365 and Adobe Creative Cloud) on GNU/Linux with KDE, GNOME or XFCE, integrated seamlessly as if they were native to the OS. Wayland is currently unsupported.";
    mainProgram = "winlink-launcher";
    platforms = platforms.linux;
    license = licenses.gpl3;
  };
}
