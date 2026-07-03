# Household Sharing — implementation notes & test checklist

**Branch:** `household-sharing` (not merged — needs device testing first)
**Status:** code complete + builds; **CloudKit sync NOT yet verified** (needs 2 iCloud accounts on 2 devices + schema deployed to Production).

## What changed
Reworked sharing to Apple's "share the object graph via a root object" pattern:
- New `HouseholdEntity` root; grocery items, meal-plan entries, and custom recipes relate to it. Sharing the household shares the whole graph, and new items auto-join.
- Two-store CloudKit container (private + shared). A member's `viewContext` fetches across both, so shared data shows up with no changes to the existing list code.
- `SharingManager` shares the household root (works with an empty grocery list), accepts invites into the shared store, and knows owner vs participant.
- The Share button now presents reliably via a SwiftUI `UIViewControllerRepresentable` (the old key-window lookup silently failed).
- One-time backfill assigns pre-existing (build-4) items to a local household on first launch.

## Privacy model
CKShare is private to invited members only — there is **no global database**. Built-in (seed) recipes stay local and identical for everyone; only your grocery list, meal plan, and custom recipes are shared, and only within your household.

**v1 decision:** when someone joins a household, their *pre-existing* local items stay private (not auto-merged). Can add a "merge my items" action later.

## Prerequisites before it will sync (manual — must do)
1. **Deploy the CloudKit schema Dev → Production.** Run a Development build once (creates record types `CD_HouseholdEntity`, etc. + `cloudkit.share`), then in CloudKit Console (developer.apple.com → CloudKit → `iCloud.com.kalyan.CookingApp`) → **Deploy Schema Changes** to Production. TestFlight uses Production; sync silently fails until this is done.
2. Both users **signed into iCloud** (Settings → iCloud), app iCloud on.
3. Confirm the archived build's `aps-environment` is `production`.
4. Bump the build number before archiving (build 4 already uploaded).

## End-to-end test plan (2 devices, 2 iCloud accounts)
1. Device A (owner): fresh install / build-4 upgrade → confirm existing items still show, no duplicates.
2. Clear the grocery list → Settings → **Share Household** → confirm the invite sheet opens **even with an empty list**. Send the invite to Account B.
3. Device B: tap the invite → confirm A's grocery items, meal plan, and custom recipes appear within seconds; seed recipes look identical (not duplicated).
4. Bidirectional: add/check/delete on each device → reflects on the other.
5. Items added **after** joining also sync.
6. Roster/roles: A sees B as participant + "Stop Sharing"; B sees "Leave Household".
7. B leaves → B's shared items vanish on B; A keeps everything.
8. A third, uninvited account (Device C) sees none of it (privacy).
9. Offline edits reconcile when back online.
10. Simulator / signed-out: app runs on plain container, no crash, sharing disabled.

## Known limitation
This wasn't verifiable in the build environment (no second iCloud account). Please run the test plan above on two devices before merging `household-sharing` to `main`.
