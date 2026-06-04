# Example Custom Domain

This folder is an example content pack for folder-based custom domains.

## Editable Files

- `background/`: background images for generated cards
- `card_graphics/`: card art and card graphics
- `templates/card_data_example_domain.csv`: card text and metadata
- `templates/domain_metadata.txt`: domain and generator metadata
- `templates/template_example_domain.sla`: Scribus template, if you intentionally maintain templates

## Do Not Edit During Normal App Work

- `placeholders/`: generator placeholder assets
- `icons/`: generator icon assets unless deliberately changing this domain
- `output/`: generated `.sla` and `.pdf` files
- generator scripts in `templates/` and the repository generator folder

## Workflow

1. Copy this folder and rename the copy.
2. Edit `templates/domain_metadata.txt`.
3. Edit `templates/card_data_*.csv`.
4. Add art to `card_graphics/` and backgrounds to `background/`.
5. Run the external generator to create PDFs in `output/`.
6. Run `pnpm sync:assets` from the app repository.
7. Open the app and enable the domain from the left card browser: `Custom > Custom Domains > Manage custom domains`.

If PDFs are missing, the app still loads the cards and displays them with the text-card fallback. The app does not compile custom domains in the browser.
