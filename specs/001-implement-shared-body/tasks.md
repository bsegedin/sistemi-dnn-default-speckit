# Tasks: Shared Theme Body Control, DDR Menus, and Build/Packaging Compliance

**Feature Dir**: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\specs\001-implement-shared-body`  
**Source Root**: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website`  
**Skin Root**: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base`  
**Prerequisites**: plan.md (present), research.md (n/a), data-model.md (n/a), contracts/ (n/a), quickstart.md (n/a)

## Execution Flow (main)
```
1) Load plan.md (this feature)
2) Generate tasks per constitution & spec → setup → tests-first → implementation → integration → polish
3) Mark [P] where tasks operate on different files
4) Order by dependencies; include parallel execution examples
```

## Format: [ID] [P?] Description
- [P] = safe to run in parallel (different files, no ordering conflicts)
- Always include exact absolute file paths

---

## Phase 3.1: Setup
- [ ] T001 Confirm Starter Kit base is used (no ad-hoc scaffolding); document theme identifiers and packaging name/version
      Notes: Use this repo as the base; prepare theme name/version for packaging.
- [ ] T002 Add Clarifications to research.md (resolve open items) and update spec if needed
      Create or append to: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\specs\001-implement-shared-body\research.md`
      - Confirm minimum supported DNN CE version and .NET runtime
      - Finalize wrapper attributes and allowed values (e.g., LayoutVariant, PaneLayout, HeaderStyle, ShowBreadcrumb)
- [ ] T003 Configure Figma MCP in VS Code (Desktop/Mobile pages access); record token export/parity workflow in quickstart
      File: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\specs\001-implement-shared-body\quickstart.md`
      Links: Desktop https://www.figma.com/design/MTcg0pGVIzWYaIlIyOS6Cb/SpecKit-Playground?node-id=1-101&t=UPgCcGBXCxq490uM-4 ;
             Mobile https://www.figma.com/design/MTcg0pGVIzWYaIlIyOS6Cb/SpecKit-Playground?node-id=2-155&t=UPgCcGBXCxq490uM-4
- [ ] T004 Ensure DNN Roslyn compiler (2sxc) is installed and active on target portal; record version in research.md
- [ ] T005 [P] Create controls directory if missing:
      `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\controls\`
- [ ] T006 [P] Create menus directories for DDR Razor templates if missing:
      - `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\menus\MainMenu\`
      - `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\menus\ServiceMenu\`
- [ ] T007 [P] Ensure build output folders exist:
      - `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\dist\`
      - `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\dist\lib\`
- [ ] T008 Validate (or create) skin `package.json` scripts in skin root for vendoring & builds; include:
      File: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\package.json`
      Scripts: `update-lib-bootstrap`, `update-lib-glightbox`, `update-libs`, `build-dev`, `build-prod`, `test:tokens`, `test:visual`, `test:a11y`, `test:perf`, `test:all`
- [ ] T009 Run vendoring to populate dist libs:
      In `D\:Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\`: `npm install` ; `npm run update-libs`
- [ ] T010 Confirm webpack builds CSS/JS to `dist` and SCSS sources live in `src\\scss\\`; if absent, create placeholders:
      - `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\src\scss\index.scss`
      - `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\src\scss\_tokens.scss`

## Phase 3.2: Tests First (TDD) — MUST FAIL initially
- [ ] T011 [P] Token parity contract test (CSS custom properties)
      Create Node test script to assert required CSS variables exist in compiled CSS under `dist`.
      File: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\tests\contract\tokens.test.mjs`
      Inputs: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\dist\*.css`
- [ ] T012 [P] Visual baseline scaffold for key templates (Home, Content, Listing, Article, Search)
      Create a minimal Playwright/puppeteer harness and baseline folder; capture initial images (expected to differ initially).
      Files:
      - `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\tests\visual\baseline\[home|content|listing|article|search].png`
      - `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\tests\visual\run.mjs` (script to capture screenshots)
- [ ] T013 [P] Accessibility audit test (axe)
      Create puppeteer + axe-core script to check focus order, landmarks, contrast on Home/Content.
      File: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\tests\a11y\axe-audit.mjs`
- [ ] T014 [P] Performance budget check (Lighthouse CLI or local budget assert)
      Create script to assert uncompressed CSS ≤ 200 KB and JS ≤ 100 KB at FCP for key pages.
      File: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\tests\perf\budgets.mjs`
- [ ] T015 Add npm test runners to skin `package.json` for the above (without implementing fixes yet):
      - `test:tokens`, `test:visual`, `test:a11y`, `test:perf`, `test:all`

## Phase 3.3: Core Implementation (only after tests exist and initially fail)
- [ ] T016 Create shared body control markup
      File: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\controls\_inc-theme-body.ascx`
      Purpose: host panes, apply classes, include header/footer regions.
- [ ] T017 Create shared body control code-behind (C# 8.0)
      File: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\controls\_inc-theme-body.ascx.cs`
      Purpose: parse wrapper attributes (`LayoutVariant`, `PaneLayout`, `HeaderStyle`, `ShowBreadcrumb`), toggle panes.
- [ ] T018 Implement/standardize helpers
      File: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\App_Code\BaseTheme\ThemeHelpers.cs`
      Purpose: pane visibility, formatting, composing theme objects, Client Resource Management.
- [ ] T019 Update wrapper skins to delegate to shared body control and pass attributes
      Files: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\*.ascx` (e.g., Default.ascx, SingleNarow.ascx, SplitPanesCenter.ascx, SplitPanesFluid.ascx)
- [ ] T020 Implement DDR Menu Razor templates — Main Menu
      File: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\menus\MainMenu\template.cshtml`
      Requirement: Must match Figma Desktop/Mobile; no hard-coded menu HTML in skins.
- [ ] T021 Implement DDR Menu Razor templates — Service Menu
      File: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\menus\ServiceMenu\template.cshtml`
      Requirement: Must match Figma Desktop/Mobile; no hard-coded menu HTML in skins.
- [ ] T022 Wire DDR Menu skin objects in skins to use Razor templates
      Files: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\*.ascx` — add DDR Menu SkinObject references with `MenuStyle="Razor"` and template path.
- [ ] T023 Implement mobile Bootstrap Offcanvas menu wiring in `_inc-theme-body.ascx`
      Files: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\controls\_inc-theme-body.ascx[.cs]`
      Requirement: Hide desktop menu on mobile; offcanvas content rendered via DDR Razor template; ensure focus trap, Esc to close, ARIA attributes.
- [ ] T024 Author tokens in SCSS as CSS variables
      File: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\src\scss\_tokens.scss` → `:root { --color-*, --space-*, --radius-*, ... }`
- [ ] T025 Integrate tokens and layout styles
      File: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\src\scss\index.scss` → import Bootstrap v5 overrides, tokens, and component/layout partials
- [ ] T026 Build assets
      In `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\`: `npm run build-prod`
- [ ] T027 Vendor JS libs to dist (dist-only policy)
      In `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\`: `npm run update-libs`

## Phase 3.4: Integration
- [ ] T028 Register CSS/JS via DNN Client Resource Management in shared body control or wrapper skins
      Ensure only `dist` assets are referenced (no node_modules paths).
- [ ] T029 Validate menus render correctly (Desktop/Mobile parity) and keyboard navigation works
      Check ARIA, `aria-current`, focus order.
- [ ] T030 Validate mobile Offcanvas behavior
      Ensure desktop menu hidden on mobile; offcanvas opens/closes via toggle, traps focus, Esc closes, and screen reader labels are correct.
- [ ] T031 Re-run tests: tokens, visual, a11y, performance
      Expect tests to pass or produce explainable diffs.
- [ ] T032 Prepare DNN packaging scripts for theme/container ZIPs
      Create packaging script: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\pack.ps1` and document steps in `quickstart.md`.

## Phase 3.5: Polish
- [ ] T033 [P] Update `CHANGELOG.md` with SemVer bump and migration notes
- [ ] T034 [P] Document quickstart and maintenance in `specs\\001-implement-shared-body\\quickstart.md`
- [ ] T035 [P] Confirm `.gitignore` excludes `node_modules` and enforces dist-only policy
- [ ] T036 [P] Remove dead code, comments; ensure consistent naming (BEM), a11y labels

## Dependencies
- T001 → T002 → T003
- T005, T006, T007, T008, T009, T010 can run in parallel once T001 is done
- Tests (T011–T015) must exist before implementation (T016–T027)
- T016 blocks T017–T019
- T020–T022 depend on menus folders (T006) and skin files
- T024–T026 depend on SCSS folder (T010)
- T027 depends on T008
- T028–T031 depend on core implementation completion
- Packaging (T032) after integration
- Polish tasks (T033–T036) after core/integration

## Parallel Execution Examples
```
# Example 1: Run setup folder tasks in parallel
Task: "Create controls directory" (T005)
Task: "Create menus directories" (T006)
Task: "Ensure dist folders exist" (T007)
Task: "Validate/create package.json scripts" (T008)
Task: "Run vendoring" (T009)
Task: "Ensure SCSS structure" (T010)

# Example 2: Run tests-first tasks in parallel
Task: "Token parity contract test" (T011)
Task: "Visual baseline scaffold" (T012)
Task: "Accessibility audit test" (T013)
Task: "Performance budget check" (T014)
```

## Task Agent Commands (reference)
- Create file: "Add <file> with scaffold contents"
- Edit file: "Update <file> section X to ..."
- Run command (PowerShell):
  - `cd "D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base"`
  - `npm install`
  - `npm run build-prod`
  - `npm run update-libs`

## Validation Checklist
- [ ] Figma Desktop/Mobile parity validated (menus, layout)
- [ ] DDR Menu Razor templates used for Main/Service menus; no hard-coded HTML
- [ ] Mobile offcanvas used on mobile, desktop menu hidden; offcanvas DDR menu accessible (focus trap, Esc, ARIA)
- [ ] Token parity tests GREEN (CSS variables present)
- [ ] A11y audits GREEN; exceptions documented
- [ ] Performance budgets respected (CSS ≤ 200 KB, JS ≤ 100 KB uncompressed @ FCP)
- [ ] dist-only JS policy enforced; no node_modules in prod/test
- [ ] Theme packaged for DNN install; SemVer + CHANGELOG updated
