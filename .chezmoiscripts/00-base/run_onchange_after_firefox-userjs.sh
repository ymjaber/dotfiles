#!/bin/bash
set -e
# Firefox 153 prefers the XDG root and falls back to the legacy one only if it already exists.
root=~/.config/mozilla/firefox
[[ -d ~/.mozilla/firefox ]] && root=~/.mozilla/firefox
[[ -f $root/profiles.ini ]] || { echo "firefox has not run yet; skipping user.js"; exit 0; }

# the [Install<HASH>] section names the profile THIS install actually opens; fall back to the
# [ProfileN] marked Default=1 for a profiles.ini that predates install sections.
prof=$(awk -F= '/^\[Install/{i=1;next} /^\[/{i=0} i&&/^Default=/{print $2;exit}' "$root/profiles.ini")
[[ $prof ]] || prof=$(awk -F= '/^Path=/{p=$2} /^Default=1/{print p;exit}' "$root/profiles.ini")
[[ $prof ]] || { echo "no default profile in profiles.ini"; exit 1; }
[[ $prof = /* ]] || prof=$root/$prof

install -Dm644 /dev/stdin "$prof/user.js" <<'USERJS'
// user.js — privacy/hardening essentials (arkenfox-derived, trimmed)
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
user_pref("network.cookie.cookieBehavior", 5);            // total cookie protection (dFPI)
// ⚠ privacy.firstparty.isolate is deliberately ABSENT — FPI and dFPI are mutually exclusive,
// and setting both silently disables the dFPI above.
user_pref("privacy.resistFingerprinting", true);          // forced light color-scheme + spoofed
                                                          // screen metrics. Does NOT letterbox.
user_pref("dom.security.https_only_mode", true);
user_pref("network.trr.mode", 2);                         // DoH first, system resolver as fallback.
                                                          // NOT 3 — that bypasses the system stub
                                                          // entirely, defeating setup/04's DoT and
                                                          // making captive portals unrecoverable.
user_pref("network.trr.uri", "https://dns.quad9.net/dns-query");
user_pref("browser.contentblocking.category", "strict");
// ⚠ AUTHORITY, not a preference: at every startup Firefox re-derives the strict preset and
// writes ~20 prefs onto the user branch, including the three above. Edit those and they revert.
user_pref("geo.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
// ⚠ extensions.pocket.enabled does not exist in 153. Its descendant is the newtab Stories feed.
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.aboutConfig.showWarning", false);
USERJS
echo "user.js -> $prof/user.js"
