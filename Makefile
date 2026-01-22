.PHONY: all pdf lia plan copy-dist clean check

SHELL := /usr/bin/env bash

LESSON_MD   := $(wildcard vorlesung_*.md)
PLAN_MD     := $(wildcard planning_*.md)

LESSON_IDS  := $(sort $(patsubst vorlesung_%_architektur.md,%,$(LESSON_MD)))

LIA_PDFS    := $(addprefix distributed_software_,$(addsuffix .pdf,$(LESSON_IDS)))
PLAN_PDFS   := $(addprefix planning_,$(addsuffix .pdf,$(LESSON_IDS)))

WEBDAV_DIR  := Freigaben/DISTSW-VL


all: pdf

pdf: lia plan copy-dist

lia: $(LIA_PDFS)

plan: $(PLAN_PDFS)

# lesson_01.md -> n8n_01.pdf
distributed_software_%.pdf: vorlesung_%_architektur.md
	@echo "Baue Lesson $*"
	liascript-exporter \
		--input "$<" \
		--output "vorlesung_$*_architektur" \
		--format pdf

planning_%.pdf: planning_lesson_%.md
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
