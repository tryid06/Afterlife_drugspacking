# susidrugpack

`susidrugpack` is a secure drug-packing system for FiveM with a modern NUI workflow and support for `ox_inventory` or `qb-inventory`.

## Features

- Placeable packing scale with interaction targets.
- NUI packing flow for coke, weed, and meth recipes.
- Server-side recipe validation and anti-spoof checks.
- Distance checks to ensure packing only happens near an active placed scale.
- Configurable animation and inventory backend.

## Installation

1. Put this resource in your server resources folder and rename the folder to `susidrugpack`.
2. Ensure dependencies are installed:
   - `ox_lib`
   - `ox_target`
   - `ox_inventory` (or `qb-core` + `qb-inventory`)
3. Add to your server config:

```cfg
ensure susidrugpack
```

4. Build UI assets if needed:

```bash
cd ui
npm install
npm run build
```

## Configuration

Use `config.lua` to set:

- `Config.Scaleitem`
- `Config.animation`
- `Config.Inventory`
- `Config.Items` recipes and outputs

## Event Namespace

All custom events use the `susidrugpack:*` namespace.
