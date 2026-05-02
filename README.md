# LYP

Generate PDF planner for e-ink (and other) devices.

LYP (latex yearly planner) uses Ruby to generate typst, which then gets compiled into PDF.

The change of latex to typst was as the latter is simpler and easier to work with.

## Installation

```shell
bundle install
```

You also need typst installed and `typst` command to be available.

## Usage

```shell
bundle exec bin/lyp generate <path-to-config-file>
```
