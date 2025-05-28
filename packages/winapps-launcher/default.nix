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
  pname = "winux-launcher";
  version = "0-unstable-2025-03-11";

  src = fetchFromGitHub {
    owner = "winux-org";
    repo = "Winux-Launcher";

    inherit rev hash;
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [
    yad
    (callPackage ../winux { })
  ];

  patches = [ ./Winux-Launcher.patch ];

  postPatch = ''
    substituteAllInPlace Winux-Launcher.sh
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r ./Icons $out/Icons

    install -m755 -D Winux-Launcher.sh $out/bin/winux-launcher
    install -Dm444 -T Icons/AppIcon.svg $out/share/pixmaps/winux.svg

    wrapProgram $out/bin/winux-launcher \
      --set LIBVIRT_DEFAULT_URI "qemu:///system" \
      --prefix PATH : "${lib.makeBinPath buildInputs}"

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "winux";
      exec = "winux-launcher";
      icon = "winux";
      comment = meta.description;
      desktopName = "Winux";
      categories = [ "Utility" ];
    })
  ];

  meta = with lib; {
    homepage = "https://github.com/winux-org/Winux-Launcher";
    description = "Graphical launcher for Winux. Run Windows applications (including Microsoft 365 and Adobe Creative Cloud) on GNU/Linux with KDE, GNOME or XFCE, integrated seamlessly as if they were native to the OS. Wayland is currently unsupported.";
    mainProgram = "winux-launcher";
    platforms = platforms.linux;
    license = licenses.gpl3;
  };
}
