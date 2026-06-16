# RamanujanPartitions

A Lean 4 + Mathlib formalization of the **partition function `p(n)`** and **Ramanujan's partition
congruences**. Companion to [RamanujanTau](https://github.com/tomdif/RamanujanTau); same discipline —
computable arithmetic functions, deep theorems exposed as hypothesis classes (never `axiom`s), and
statements certified on an initial range by `native_decide`.

| | |
|---|---|
| Modules | 2 (`Basic`, `Congruences`) |
| Build | `lake build` → **0 errors** |
| `sorry` count | **0** |
| New `axiom` declarations | **0** |
| Lean toolchain | `leanprover/lean4:v4.30.0-rc2` + Mathlib |

## The partition function

Mathlib has the *type* `Nat.Partition n` but no computable counting function. We define one via
**Euler's pentagonal-number recurrence**
```
p(n) = Σ_{k≥1} (-1)^{k-1} [ p(n - k(3k-1)/2) + p(n - k(3k+1)/2) ],
```
a consequence of Euler's pentagonal number theorem. Taking the recurrence as the definition gives a
`native_decide`-reducible `partition : ℕ → ℕ` (exactly as `RamanujanTau.tau` is defined from the
truncated Euler product). Verified values include the classic `p(100) = 190569292`.

## Ramanujan's congruences

Ramanujan (1919):
```
p(5n + 4) ≡ 0 (mod 5),    p(7n + 5) ≡ 0 (mod 7),    p(11n + 6) ≡ 0 (mod 11).
```

| Module | Content |
|---|---|
| `Basic.lean` | computable `partition`; values `p(0..10)`, `p(100)` by `native_decide` |
| `Congruences.lean` | `mod5_below_100`, `mod7_below_80`, `mod11_below_60` (kernel-verified ranges); classes `PartitionMod5/7/11` for the general statements |

## Assumptions surface

| Class | Statement | Discharge route |
|---|---|---|
| `PartitionMod5` | `p(5n+4) ≡ 0 (mod 5)` ∀ n | `Σ p(5n+4) qⁿ = 5 ∏(1-q^{5n})⁵/(1-qⁿ)⁶` |
| `PartitionMod7` | `p(7n+5) ≡ 0 (mod 7)` ∀ n | analogous `q`-series identity |
| `PartitionMod11` | `p(11n+6) ≡ 0 (mod 11)` ∀ n | Atkin / `q`-series (the hardest) |

The general proofs need `η`-quotient / `q`-series machinery not yet in Mathlib — the same horizon as
discharging `RamanujanTau.TauHeckeMaster`. The ranges above are certified outright by computation.

## Build

```sh
lake exe cache get
lake build
```

## References

- Ramanujan, S. (1919). "Some properties of p(n), the number of partitions of n."
  *Proc. Cambridge Philos. Soc.* **19**.
- Euler, L. Pentagonal number theorem.
- OEIS [A000041](https://oeis.org/A000041) — the partition numbers.

## License

MIT.
