# Security Policy

## Reporting A Vulnerability

Please report security issues privately when possible. Do not open a public
issue that includes secrets, credentials, private project context, or exploit
details that would put a user at risk.

If private reporting is not available yet, open a minimal public issue that says
there is a security concern and omit sensitive details.

## Sensitive Information

Do not submit:

- API keys, tokens, passwords, private keys, or credentials.
- `.env` files, auth files, browser data, or Keychain output.
- Private project source, private logs, customer data, or personal machine
  paths unless they are already safe to publish.
- Full agent transcripts that include unrelated private context.

## Scope

This repository contains a workflow skill and documentation. Security issues
usually involve unsafe instructions, overbroad permissions, accidental authority
transfer, private-context leakage, or validation gaps.

The skill must not imply that installing or invoking it authorizes secret
access, broad file access, workspace trust, commits, pushes, releases,
deployments, or other external effects.
