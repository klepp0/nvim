install:
	@echo "Installing nvim config ..."
	@git submodule update --merge --remote
	@chmod +x ./install.sh
	@./install.sh
	@echo "Done."

uninstall:
	@echo "Uninstalling dotfiles ..."
	@chmod +x ./uninstall.sh
	@./uninstall.sh
	@echo "Done."

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install   Install nvim"
	@echo "  uninstall Uninstall nvim"
	@echo "  help      Show this help message"
	@echo ""
	@echo "For more information, see the README.md file."
	@echo ""

.PHONY: install uninstall help
