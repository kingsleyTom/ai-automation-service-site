#!/usr/bin/env node
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const args = new Set(process.argv.slice(2));
const writeChanges = args.has("--write");
const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(scriptDir, "..");
const indexPath = path.join(repoRoot, "index.html");

const fields = [
  {
    envs: ["DIAGNOSTIC_PAYMENT_URL", "PAYPAL_DIAGNOSTIC_URL"],
    label: "paymentLinks.diagnostic",
    pattern: /(diagnostic:\s*)"[^"]*"/,
  },
  {
    envs: ["STARTER_PAYMENT_URL", "PAYPAL_STARTER_URL"],
    label: "paymentLinks.starter",
    pattern: /(starter:\s*)"[^"]*"/,
  },
  {
    envs: ["COMPLETE_PAYMENT_URL", "PAYPAL_COMPLETE_URL"],
    label: "paymentLinks.complete",
    pattern: /(complete:\s*)"[^"]*"/,
  },
  {
    envs: ["FORMSPREE_ENDPOINT_URL"],
    label: "formspreeEndpoint",
    pattern: /(formspreeEndpoint:\s*)"[^"]*"/,
  },
  {
    envs: ["BOOKING_URL"],
    label: "bookingUrl",
    pattern: /(bookingUrl:\s*)"[^"]*"/,
  },
  {
    envs: ["CONTACT_FALLBACK_URL"],
    label: "contactFallbackUrl",
    pattern: /(contactFallbackUrl:\s*)"[^"]*"/,
  },
];

function usage() {
  console.log(`Configure public site commerce/contact links.

Default mode is a dry run. Add --write to update index.html.

Example:
  DIAGNOSTIC_PAYMENT_URL="https://buy.stripe.com/..." \\
  FORMSPREE_ENDPOINT_URL="https://formspree.io/f/xxxxxxx" \\
  BOOKING_URL="https://calendly.com/..." \\
  node scripts/configure_site.mjs --write

Supported environment variables:
${fields.map((field) => `  ${field.envs.join(" or ")}`).join("\n")}

Legacy PAYPAL_* variables are still accepted for payment links.
`);
}

function validateUrl(env, value) {
  if (!value) {
    return;
  }

  let url;
  try {
    url = new URL(value);
  } catch {
    throw new Error(`${env} is not a valid URL.`);
  }

  if (url.protocol !== "https:" && url.protocol !== "http:") {
    throw new Error(`${env} must start with http:// or https://.`);
  }
}

function getProvidedValue(field) {
  for (const env of field.envs) {
    if (Object.prototype.hasOwnProperty.call(process.env, env)) {
      return { env, value: process.env[env] ?? "" };
    }
  }
  return null;
}

const provided = fields
  .map((field) => ({ field, providedValue: getProvidedValue(field) }))
  .filter((entry) => entry.providedValue);

if (args.has("--help") || provided.length === 0) {
  usage();
  process.exit(args.has("--help") ? 0 : 1);
}

let html = fs.readFileSync(indexPath, "utf8");
const changed = [];

for (const { field, providedValue } of provided) {
  const { env, value } = providedValue;
  validateUrl(env, value);

  if (!field.pattern.test(html)) {
    throw new Error(`Could not find ${field.label} in index.html.`);
  }

  html = html.replace(field.pattern, `$1${JSON.stringify(value)}`);
  changed.push(`${field.label} from ${env}`);
}

if (writeChanges) {
  fs.writeFileSync(indexPath, html);
  console.log(`Updated index.html: ${changed.join(", ")}`);
} else {
  console.log(`Dry run passed. Would update: ${changed.join(", ")}`);
  console.log("Run again with --write to modify index.html.");
}
