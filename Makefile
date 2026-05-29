.PHONY: all watch clean plots copy-figures bib-format arxiv

SRC_DIR = src
MAIN = main
BUILD_DIR = build
LATEXMK = latexmk -pdf -outdir=../$(BUILD_DIR) -cd # -cd changes to source dir, so outdir is relative to that

# Root PDF is a copy of the build output so editors that open sosp26/scepsy.pdf stay in sync.
all: $(SRC_DIR)/$(MAIN).pdf

$(SRC_DIR)/$(MAIN).pdf: $(BUILD_DIR)/$(MAIN).pdf
	cp $(BUILD_DIR)/$(MAIN).pdf $(SRC_DIR)/$(MAIN).pdf

$(BUILD_DIR)/$(MAIN).pdf: $(SRC_DIR)/$(MAIN).tex $(wildcard $(SRC_DIR)/sections/*.tex) $(wildcard $(SRC_DIR)/tables/*.tex) $(wildcard $(SRC_DIR)/*.sty) $(SRC_DIR)/$(MAIN).bib $(wildcard $(SRC_DIR)/figures/*.pdf) $(wildcard $(SRC_DIR)/figures/**/*.pdf)
	$(LATEXMK) $(SRC_DIR)/$(MAIN).tex

watch:
	$(LATEXMK) -pvc $(SRC_DIR)/$(MAIN).tex

clean:
	$(LATEXMK) -C $(SRC_DIR)/$(MAIN).tex
	rm -rf $(BUILD_DIR)
	rm -f $(SRC_DIR)/$(MAIN).pdf

arxiv:
	$(LATEXMK) arxiv/$(MAIN).tex

bib-format:
	bibtool -s -i $(SRC_DIR)/$(MAIN).bib -o $(SRC_DIR)/$(MAIN).bib