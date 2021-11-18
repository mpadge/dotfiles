#!/usr/bin/bash
pdftotext "$1" - | less
