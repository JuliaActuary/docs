"""Regenerate local web fonts from upstream font files (fonttools[woff])."""

from pathlib import Path
import sys
from fontTools import subset
from fontTools.varLib.instancer import instantiateVariableFont

# Include Julia identifiers, mathematical notation, and UnicodePlots output.
RANGES = ((0x0000, 0x02FF), (0x0300, 0x03FF), (0x1D00, 0x1DBF),
          (0x2000, 0x22FF), (0x2500, 0x259F), (0x2700, 0x28FF),
          (0x2C60, 0x2C7F))
UNICODES = {code for start, end in RANGES for code in range(start, end + 1)}
source = Path(sys.argv[1])
destination = Path(__file__).resolve().parents[1] / 'docs/assets/webfonts'
for weight in ('Regular', 'Bold'):
    options = subset.Options()
    options.flavor = 'woff2'
    options.hinting = False
    options.drop_tables.append('SVG')
    font = subset.load_font(str(source / f'JuliaMono-{weight}.woff2'), options)
    subsetter = subset.Subsetter(options=options)
    subsetter.populate(unicodes=UNICODES)
    subsetter.subset(font)
    output = destination / f'JuliaMono-{weight}-Web.woff2'
    subset.save_font(font, str(output), options)
    print(f'{output.name}: {output.stat().st_size:,} bytes')

# Keep common Latin, Greek, and Cyrillic prose, punctuation, and math symbols.
# Retain hinting and the slant axis for small text and genuine oblique styles.
options = subset.Options()
options.flavor = 'woff2'
font = subset.load_font(str(source / 'Inter-Variable.ttf'), options)
subsetter = subset.Subsetter(options=options)
subsetter.populate(unicodes={
    code for start, end in ((0x0000, 0x052F), (0x1D00, 0x1FFF),
                            (0x2000, 0x22FF), (0x25CC, 0x25CC))
    for code in range(start, end + 1)
})
subsetter.subset(font)
font = instantiateVariableFont(font, {'wght': (400, 400, 700)}, inplace=True)
output = destination / 'Inter-Variable-Web.woff2'
subset.save_font(font, str(output), options)
print(f'{output.name}: {output.stat().st_size:,} bytes')
