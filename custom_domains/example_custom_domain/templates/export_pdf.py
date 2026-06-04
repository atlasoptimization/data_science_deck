#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Minimal, verified PDF export script.
Source: FSFE ada-zangemann project, 2024
https://git.fsfe.org/FSFE/ada-zangemann
"""

from pathlib import Path
import scribus

if scribus.haveDoc():
    sla_path = scribus.getDocName()
    pdf_path = Path(sla_path).with_suffix(".pdf")
    print(f"Exporting: {sla_path} → {pdf_path}")
    pdf = scribus.PDFfile()
    pdf.file = str(pdf_path)
    pdf.save()
else:
    print("Error: No document open. Did you provide a .sla file?")
