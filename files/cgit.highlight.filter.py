#!/usr/bin/env python

import sys
import os.path
from pygments import highlight
from pygments.util import ClassNotFound
from pygments.lexers import TextLexer
from pygments.lexers import guess_lexer
from pygments.lexers import guess_lexer_for_filename
from pygments.formatters import HtmlFormatter

IGNORE = ['.md']

data = sys.stdin.read().decode(encoding='utf-8', errors='ignore')
filename = sys.argv[1]

PLAIN = os.path.splitext(filename)[1] in IGNORE

if not PLAIN:
    try:
        lexer = guess_lexer_for_filename(filename, data, encoding='utf-8')
    except ClassNotFound:
        if data[0:2] == '#!':
            lexer = guess_lexer(data, encoding='utf-8')
        else:
            PLAIN = True
    except TypeError:
        PLAIN = True

if PLAIN:
    sys.stdout.write(data)
else:
    formatter = HtmlFormatter(encoding='utf-8', style='pastie')

    sys.stdout.write('<style>')
    sys.stdout.write(formatter.get_style_defs('.highlight'))
    sys.stdout.write('</style>')
    highlight(data, lexer, formatter, outfile=sys.stdout)
