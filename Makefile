all:
	zip -r HideNavigationBar.zip common META-INF customize.sh module.prop service.sh uninstall.sh update.json

.PHONY: clean
clean:
	rm -f HideNavigationBar.zip
