# portfolio

My personal site at [karlpedia.org](https://karlpedia.org). Plain HTML and CSS, no build step, no JavaScript, served by Caddy in a container.

## Edit

Everything is in `site/`: `index.html` for content, `styles.css` for looks. Open `site/index.html` in a browser to preview.

Screenshots in `site/img/` come from `expat-finance/docs/screenshots` (made-up sample household).

## Run the container locally

```bash
docker build -t portfolio . && docker run --rm -p 8080:8080 portfolio
```

## Deploy

Merging to `main` publishes `ghcr.io/kielpedia/portfolio:main` (plus a tag per commit SHA). Renovate in `homelab-infra` picks up the new digest and opens a PR there; merging that PR deploys `stacks/portfolio` on port 8103, served by Caddy at karlpedia.org.

## SEO

- `site/index.html` head: canonical URL, Open Graph/Twitter preview tags and Person structured data (JSON-LD). Update `sameAs` if a profile URL changes.
- `site/img/og.png` is the 1200x630 link preview image. `site/sitemap.xml`: bump `<lastmod>` after big content changes.
- After the first deploy: verify `karlpedia.org` in [Google Search Console](https://search.google.com/search-console) with a DNS TXT record in Cloudflare, then submit `https://karlpedia.org/sitemap.xml`. Import it into Bing Webmaster Tools from there.
- Link `https://karlpedia.org` from LinkedIn (contact info → website), the GitHub profile and the expat-finance README.
