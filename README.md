# melaniebossert.com — holding page

A single static page: name, a line of context, and a password field.
Deployed with GitHub Pages.

## Change the password

```bash
./set-password.sh "new password"
git add index.html && git commit -m "Change password" && git push
```

Matching is case-insensitive and trims spaces, so people can type it on a phone
without fighting autocapitalise.

## What this gate is and isn't

This is a static page. There is no server, so the password check runs in the
visitor's browser. It compares a SHA-256 hash, which keeps the password itself
out of the page source, but anyone who opens devtools can bypass the check.

**It is a doorbell, not a lock.** That is fine while nothing is behind it.

When real case studies go behind a password, use the server-side gate in the
Astro portfolio (`melboo/portfolio`, `src/lib/auth.ts`), where locked content is
never sent to the browser at all.

## Files

| File | Purpose |
|---|---|
| `index.html` | The whole page: markup, styles, gate script |
| `fonts/` | Apfel Grotezk (Collletttivo, SIL OFL 1.1), self-hosted, one weight |
| `CNAME` | Tells GitHub Pages to serve the custom domain |
| `set-password.sh` | Rewrites the hash in `index.html` |

## Custom domain

Live at https://melaniebossert.com. DNS lives at Hostpoint: four A records on the
bare domain pointing at GitHub's Pages addresses, no AAAA record at all, and a
`www` CNAME to `melboo.github.io`. The mail records there are untouched and
unrelated.

The `CNAME` file in this repo is what tells Pages to answer on that name, so
don't delete it.
