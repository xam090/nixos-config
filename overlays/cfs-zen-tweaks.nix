final: prev:
{
  cfs-zen-tweaks = prev.cfs-zen-tweaks.overrideAttrs (old: {
    pname = "cfs-zen-tweaks";
    version = "1.2.0-1";

    src = prev.fetchFromGitHub {
      owner = "igo95862";
      repo = "cfs-zen-tweaks";
      rev = "3289bf3486c273d2666544a090d19909617945a4";
      sha256 = "aD3g/qH6VbL4O/RQ+SIcuNPILS2ROXlMegt62HKLTrk=";
    };

    patches = [
      ./cfs-zen-tweaks.patch
    ];

    postPatch = ''
      mv set-cfs-zen-tweaks.sh set-cfs-zen-tweaks.bash
    '' + old.postPatch;

    postInstall = ''
      chmod +x $out/lib/cfs-zen-tweaks/set-cfs-zen-tweaks.bash
    '';
  });
}
