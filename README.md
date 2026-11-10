# RamanujanPartitions

A small Lean 4 computational companion for partition numbers and the
Hardy–Ramanujan number 1729. The broader formalization is now
[RamanujanLean](https://github.com/tomdif/RamanujanLean).

**This repository does not prove the general partition congruences.** It
computes a recurrence-defined sequence, verifies finite ranges, and exposes
the all-index statements as hypothesis classes. RamanujanLean contains the
general mod-5, mod-7, and mod-11 proofs for actual `Nat.Partition` cardinalities.

## Contents

| Module | Result |
|---|---|
| [Basic](RamanujanPartitions/Basic.lean) | Computable Euler pentagonal recurrence, small values, and `partition 100 = 190569292` |
| [Congruences](RamanujanPartitions/Congruences.lean) | `p(5n+4) % 5 = 0` for `n < 100`, `p(7n+5) % 7 = 0` for `n < 80`, and `p(11n+6) % 11 = 0` for `n < 60` |
| [Taxicab](RamanujanPartitions/Taxicab.lean) | The two representations of 1729 and minimality for the bounded representation counter `repCount` |

`partition` is defined algorithmically through Euler’s recurrence. Identifying
it for every input with `Fintype.card (Nat.Partition n)` remains an obligation.
`PartitionMod5`, `PartitionMod7`, and `PartitionMod11` are assumptions, with no
instances discharging them in this package.

`repCount` enumerates `1 ≤ a ≤ b ≤ 12`. The theorem statements refer to that
bounded counter. The observation `13³ > 1729` explains the intended complete
search below 1729; a general representation-count bridge is not formalized here.

## Verification and trust

The finite certificates use `native_decide`, which relies on compiled evaluation
and generated native-evaluation axioms (reported as `…_native.native_decide.ax_1_1`
by this toolchain). They do not meet RamanujanLean’s
stricter policy of kernel-only finite computation. There are no `sorry` or
user-declared axioms. Inspect exact dependencies with [the audit](scripts/audit.lean).

```sh
git clone https://github.com/tomdif/RamanujanPartitions.git
cd RamanujanPartitions
lake exe cache get
lake build
lake env lean scripts/audit.lean
```

[lean-toolchain](lean-toolchain) selects `v4.30.0-rc2` and
[lake-manifest.json](lake-manifest.json) pins Mathlib. Preserve the manifest to
reproduce a build. GitHub runs the build and the audit. The [local verification record](docs/verification/publication_2026_11_10.json)
includes the exact audit output.

## Further work

For new general partition theorems, use RamanujanLean’s established counting
and generating-function bridges. To extend this standalone package, first
identify its recurrence implementation with those actual counts, then transfer
the three all-index congruences. The historical implementation is retained here
for reproducibility.

MIT, as stated by the original project. See [LICENSE](LICENSE).
