INPUT=src
OUTPUT=site

ASSETS=$(OUTPUT)/assets
TEMPLATES=_tt

INDEX=$(INPUT)/index.md

CSS=-c assets/css/bootstrap.css -c assets/css/bootstrap-responsive.css
PANDOC_OPTS=-T Vellum -H $(TEMPLATES)/viewport.tt -B $(TEMPLATES)/body-head.tt -A $(TEMPLATES)/body-foot.tt
PANDOC=pandoc -s $(PANDOC_OPTS) $(CSS) -f markdown -t html -o

SUPPORT=$(ASSETS) $(ASSETS)/js/jquery.js $(TEMPLATES)/*
SETUP=$(INPUT) $(OUTPUT) $(SUPPORT)

markdown=$(filter-out $(INDEX), $(wildcard $(INPUT)/*.md))
html:=$(patsubst %.md,%.html,${markdown})
html:=$(patsubst $(INPUT)/%,$(OUTPUT)/%,${html})

$(OUTPUT)/index.html: $(INDEX) $(html) $(SUPPORT)
	@echo Making $@
	@${PANDOC} $@ $<

$(INDEX): $(SETUP) $(markdown)
	@echo Making $@
	@echo "% Index" > $@
	@for file in $(markdown); do \
		head -1 $$file | sed 's/^[#%] /* [/' | tr -d '\n' >> $@ ;\
		basename $$file '.md' | awk '{print "]("$$1")"}' >> $@ ;\
	done

$(INPUT):
	@echo Making $@
	@mkdir $(INPUT)

$(OUTPUT):
	@echo Making $@
	@mkdir $(OUTPUT)

$(OUTPUT)/%.html: $(INPUT)/%.md $(SUPPORT)
	@echo Making $@
	@${PANDOC} $@ $<

$(ASSETS):
	@echo Making $@
	@curl -s -LOC - http://twitter.github.io/bootstrap/assets/bootstrap.zip
	@unzip -q bootstrap.zip
	@$(RM) bootstrap.zip
	@mv bootstrap $@

$(ASSETS)/js/jquery.js: $(ASSETS)
	@echo Making $@
	@curl -s -LC - -o $@ http://code.jquery.com/jquery.js

setup: $(SETUP)

clean:
	@echo Making $@
	$(RM) *html $(OUTPUT)/*.html $(INDEX)

dist-clean:
	@echo Making $@
	$(RM) -r $(INPUT) $(OUTPUT) $(ASSETS)
