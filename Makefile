.PHONY: all pdf lia plan copy-dist clean check

SHELL := /usr/bin/env bash

LESSON_MD   := $(wildcard lesson_*.md)
PLAN_MD     := $(wildcard planning_*.md)

LESSON_IDS  := $(sort $(patsubst lesson_%.md,%,$(LESSON_MD)))

LIA_PDFS    := $(addprefix n8n_,$(addsuffix .pdf,$(LESSON_IDS)))
PLAN_PDFS   := $(addprefix planning_,$(addsuffix .pdf,$(LESSON_IDS)))

WEBDAV_DIR  := Freigaben/DISTSW


all: pdf

pdf: lia plan copy-dist

lia: $(LIA_PDFS)

plan: $(PLAN_PDFS)

# lesson_01.md -> n8n_01.pdf
n8n_%.pdf: lesson_%.md
	@echo "Baue Lesson $*"
	liascript-exporter \
		--input "$<" \
		--output "n8n_$*" \
		--format pdf

# planing_01.md -> planing_01.pdf
planing_%.pdf: planing_%.md
	@echo "Baue Planung $*"
	pandoc -t pdf "$<" -o "$@"

copy-dist: $(LIA_PDFS) $(PLAN_PDFS)
	@if mountpoint -q "$(WEBDAV_DIR)" && ls "$(WEBDAV_DIR)" >/dev/null 2>&1; then \
		echo "WebDAV-Mount aktiv: $(WEBDAV_DIR) -> kopiere PDFs"; \
		cp -f $(LIA_PDFS) $(PLAN_PDFS) "$(WEBDAV_DIR)/"; \
	else \
		echo "Kein WebDAV-Ziel unter '$(WEBDAV_DIR)' (nicht gemountet?) -> überspringe Kopie."; \
	fi

clean:
	rm -f "$(LIA_PDF)" "$(PLAN_PDF)"

check:
	@command -v liascript-exporter >/dev/null || { echo "Fehlt: liascript-exporter"; exit 1; }
	@command -v pandoc >/dev/null || { echo "Fehlt: pandoc"; exit 1; }
