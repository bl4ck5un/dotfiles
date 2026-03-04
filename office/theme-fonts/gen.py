#!/usr/bin/env python3
from __future__ import annotations

import argparse
import os
import re
from pathlib import Path

try:
    import yaml  # type: ignore
except ImportError as e:
    raise SystemExit(
        "Missing dependency: pyyaml\n"
        "Install with: pip3 install pyyaml"
    ) from e


def safe_filename(s: str) -> str:
    s = s.strip()
    s = re.sub(r"\s+", "_", s)
    s = re.sub(r"[^A-Za-z0-9._-]+", "", s)
    return s or "theme_font"


def render(template: str, scheme_name: str, major: str, minor: str) -> str:
    out = template
    out = out.replace("{{SCHEME_NAME}}", scheme_name)
    out = out.replace("{{MAJOR_LATIN}}", major)
    out = out.replace("{{MINOR_LATIN}}", minor)
    return out


def main() -> None:
    ap = argparse.ArgumentParser(description="Generate Office Theme Font XML files.")
    ap.add_argument("--template", default="template.xml", help="Path to template XML")
    ap.add_argument("--pairs", default="pairs.yaml", help="Path to YAML pairs file")
    ap.add_argument("--out", default="out", help="Output directory")
    ap.add_argument("--overwrite", action="store_true", help="Overwrite existing XML files")
    args = ap.parse_args()

    base = Path(__file__).resolve().parent
    template_path = (base / args.template).resolve()
    pairs_path = (base / args.pairs).resolve()
    out_dir = (base / args.out).resolve()

    template = template_path.read_text(encoding="utf-8")

    data = yaml.safe_load(pairs_path.read_text(encoding="utf-8"))
    pairs = data.get("pairs", [])
    if not isinstance(pairs, list) or not pairs:
        raise SystemExit("pairs.yaml must contain a non-empty 'pairs:' list")

    out_dir.mkdir(parents=True, exist_ok=True)

    written = 0
    for p in pairs:
        scheme_name = str(p["scheme_name"])
        major = str(p["major"])
        minor = str(p["minor"])

        xml = render(template, scheme_name, major, minor)

        fname = safe_filename(scheme_name) + ".xml"
        dest = out_dir / fname

        if dest.exists() and not args.overwrite:
            print(f"skip  {dest.name} (exists; use --overwrite)")
            continue

        dest.write_text(xml, encoding="utf-8", newline="\n")
        print(f"write {dest}")
        written += 1

    print(f"Done. Generated {written} file(s) in {out_dir}")


if __name__ == "__main__":
    main()
