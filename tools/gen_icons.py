#!/usr/bin/env python3
"""Generate Botanisht Android launcher icons from assets/data/logo.svg.

- Legacy mipmaps (mdpi..xxxhdpi): full logo PNG renders
- Adaptive icon (mipmap-anydpi-v26): green background + sprout foreground
- Monochrome (themed icon): white sprout silhouette
"""
import cairosvg
import os

ROOT = os.path.join(os.path.dirname(__file__), '..')
RES = os.path.join(ROOT, 'android/app/src/main/res')
LOGO = os.path.join(ROOT, 'assets/data/logo.svg')

# --- 1. Legacy mipmaps: full logo renders ---
sizes = {'mdpi': 48, 'hdpi': 72, 'xhdpi': 96, 'xxhdpi': 144, 'xxxhdpi': 192}
for dpi, px in sizes.items():
    out = os.path.join(RES, f'mipmap-{dpi}', 'ic_launcher.png')
    cairosvg.svg2png(url=LOGO, write_to=out, output_width=px, output_height=px)
    print('legacy', dpi, px)

# --- 2. Adaptive icon ---
# Foreground: sprout only, on transparent, sized for the 66dp safe zone.
# Sprout spans x16-48, y16-52 of the 64 tile (32x36). Target ~48dp of 108dp
# canvas -> scale 1.5, center offsets x=30, y=27.
SPROUT_SVG = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 108 108" width="432" height="432">
  <g transform="translate(30,27) scale(1.5)">
    <path d="M32 52V30" stroke="#FFFFFF" stroke-width="3.4" stroke-linecap="round"/>
    <path d="M32 34C24 34 18 28 16 20c9 0 16 5 18 14z" fill="#FFFFFF"/>
    <path d="M32 30C40 30 46 24 48 16c-9 0-16 5-18 14z" fill="#FFFFFF"/>
    <path d="M32 30c0-6 3-11 9-13-1 7-4 11-9 13z" fill="#FFFFFF"/>
    <circle cx="32" cy="20" r="3.2" fill="#FFFFFF"/>
  </g>
</svg>'''

fg_dir = os.path.join(RES, 'mipmap-anydpi-v26')
os.makedirs(fg_dir, exist_ok=True)
cairosvg.svg2png(bytestring=SPROUT_SVG.encode(),
                 write_to=os.path.join(fg_dir, 'ic_launcher_foreground.png'))
print('adaptive foreground 432px')

# Monochrome = same silhouette (already pure white single color)
cairosvg.svg2png(bytestring=SPROUT_SVG.encode(),
                 write_to=os.path.join(fg_dir, 'ic_launcher_monochrome.png'))
print('monochrome 432px')

# Adaptive XML
with open(os.path.join(fg_dir, 'ic_launcher.xml'), 'w') as f:
    f.write('''<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background"/>
    <foreground android:drawable="@mipmap/ic_launcher_foreground"/>
    <monochrome android:drawable="@mipmap/ic_launcher_monochrome"/>
</adaptive-icon>
''')
print('ic_launcher.xml')

# Background color resource
values = os.path.join(RES, 'values', 'colors.xml')
with open(values, 'w') as f:
    f.write('''<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Deep Evergreen tile behind the adaptive launcher sprout. -->
    <color name="ic_launcher_background">#1B5E3F</color>
</resources>
''')
print('colors.xml')

# --- 3. Play Store 512px icon ---
store_dir = os.path.join(ROOT, 'store')
os.makedirs(store_dir, exist_ok=True)
cairosvg.svg2png(url=LOGO, write_to=os.path.join(store_dir, 'icon-512.png'),
                 output_width=512, output_height=512)
print('store icon 512px')
