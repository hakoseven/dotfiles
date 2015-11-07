#!/usr/bin/sh
TITLE=$(cmus-remote -Q | grep title | cut -d " " -f 3-)
# artist

echo "$TITLE" 