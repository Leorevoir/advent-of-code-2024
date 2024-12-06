if ! command -v crystal 2>&1 >/dev/null; then
    cat << EOF
ERROR:
    please install crystal compiler to run this code.
    this repo contains a Nix flake
    try: `nix develop` at its root.
EOF
    exit 84
fi

crystal build --release --no-debug -O3 -o day06 day06.cr

