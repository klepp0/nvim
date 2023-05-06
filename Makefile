.PHONY: install

install:
	@echo "Backing up existing nvim configuration..."
	@if [ -d $(HOME)/.config/nvim ]; then \
		cp -r $(HOME)/.config/nvim ~/.config/nvim.bak; \
		echo "Existing nvim configuration backed up to ~/.config/nvim.bak"; \
	fi
	@echo "Copying data to ~/.config/nvim..."
	@mkdir -p $(HOME)/.config/nvim/
	@cp -r ./* $(HOME)/.config/nvim/
	@echo "Done."
	@echo "Removing directory..."
	@rm -rf $(CURDIR)

