# How To Design A Clean iOS Settings Screen

Settings should feel operational, not intimidating.

## Principles

- separate status from action
- explain consequence, not just control names
- group by user mental model, not implementation layer
- slow down destructive or irreversible actions
- avoid vague labels like `Sync Now` when the real action is status refresh

## Good Structure

- account or subscription
- preferences
- behavior or automation
- data and sync
- about and legal

## Make Trust Visible

- show current state clearly
- name storage and sync honestly
- if recovery exists, explain what it restores and when
- if something is unavailable, say what the user can do next

## Avoid

- equal-weight rows for everything
- mixing diagnostics with everyday preferences
- dangerous actions hidden behind neutral button labels
- technical jargon without user meaning

## Review Questions

- does each row answer “what is this” and “what happens if I tap it”
- are risky actions visually separated
- can a new user understand sync and storage without prior context
- does the page still feel calm on a small phone
