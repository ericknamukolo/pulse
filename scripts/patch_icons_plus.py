#!/usr/bin/env python3
"""Patch icons_plus 5.0.0 for Flutter >= 3.33.

Flutter made IconData a final class, so `class XIconData extends IconData`
no longer compiles. This script rewrites every icon constant to plain
`IconData(...)` with explicit fontFamily/fontPackage and drops the wrapper
classes. Run once after `flutter pub get`:

    python3 scripts/patch_icons_plus.py
"""
import re
import shutil
from pathlib import Path

SRC = Path.home() / '.pub-cache/hosted/pub.dev/icons_plus-5.0.0/lib/src'

CLASS_RE = re.compile(
    r'class (\w+IconData) extends IconData \{\s*'
    r'const \1\(int code\)\s*\)\s*;?\s*\}',
)
r"class (\w+) extends IconData \{\s*const \1\(int code\)\s*: super\(\s*code,\s*fontFamily: '([^']+)',\s*fontPackage: 'icons_plus',\s*\);\s*\}"


def main():
    if not SRC.exists():
        raise SystemExit(f'icons_plus source not found at {SRC}')

    for dart in sorted(SRC.glob('*.dart')):
        text = dart.read_text()
        m = re.search(
            r'class (\w+) extends IconData \{\s*'
            r'const \1\(int code\)\s*: super\(\s*code,\s*'
            r"fontFamily: '([^']+)',\s*fontPackage: '([^']+)',\s*\);?\s*\}",
            text,
        )
        if not m:
            print(f'skip {dart.name}: no wrapper class')
            continue
        wrapper, family, package = m.group(1), m.group(2), m.group(3)
        patched = text[m.end():]
        patched = re.sub(
            rf'{wrapper}\((0x[0-9a-fA-F]+)\)',
            rf"IconData(\1, fontFamily: '{family}', fontPackage: '{package}')",
            patched,
        )
        shutil.copy(dart, dart.with_suffix('.dart.bak'))
        dart.write_text(
            '// ignore_for_file: constant_identifier_names\n\n'
            "import 'package:flutter/widgets.dart';\n\n" + patched
        )
        n = len(re.findall(r'IconData\(0x', patched))
        print(f'patched {dart.name}: removed {wrapper}, rewrote {n} icons')


if __name__ == '__main__':
    main()
