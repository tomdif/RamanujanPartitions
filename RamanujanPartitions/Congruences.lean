import RamanujanPartitions.Basic

/-! # Ramanujan's partition congruences

Ramanujan (1919) discovered the three astonishing congruences
```
p(5n + 4) ≡ 0 (mod 5),   p(7n + 5) ≡ 0 (mod 7),   p(11n + 6) ≡ 0 (mod 11).
```
They are the first and most famous facts of the arithmetic theory of partitions.

The general statements are exposed as hypothesis **classes** (never `axiom`s),
and we certify each on an initial range by direct
computation (`native_decide`), which trusts compiled evaluation. The general proofs use the
generating-function / `q`-series identities (e.g. `Σ p(5n+4) qⁿ = 5 · ∏(1-q^{5n})⁵ / (1-qⁿ)⁶`), which
are formalized in the companion RamanujanLean repository. Transferring them here still requires
identifying this recurrence-defined sequence with actual partition cardinalities.
-/

namespace RamanujanPartitions

/-! ## Finite computational certificates (each by `native_decide` over an initial range) -/

/-- `p(5n + 4) ≡ 0 (mod 5)` for all `n < 100`. -/
theorem mod5_below_100 : ∀ n, n < 100 → partition (5 * n + 4) % 5 = 0 := by native_decide

/-- `p(7n + 5) ≡ 0 (mod 7)` for all `n < 80`. -/
theorem mod7_below_80 : ∀ n, n < 80 → partition (7 * n + 5) % 7 = 0 := by native_decide

/-- `p(11n + 6) ≡ 0 (mod 11)` for all `n < 60`. -/
theorem mod11_below_60 : ∀ n, n < 60 → partition (11 * n + 6) % 11 = 0 := by native_decide

/-- The famous first instances, named: `p(4)=5`, `p(9)=30`, `p(14)=135` are all `≡ 0 (mod 5)`. -/
theorem mod5_first_three :
    partition 4 % 5 = 0 ∧ partition 9 % 5 = 0 ∧ partition 14 % 5 = 0 := by native_decide

/-! ## The general statements, as hypothesis classes (discharge: `q`-series / η-quotient identities) -/

/-- **Ramanujan's mod-5 congruence** (general): `p(5n + 4) ≡ 0 (mod 5)` for all `n`.
Discharge route: `Σ p(5n+4) qⁿ = 5 · ∏(1-q^{5n})⁵ / (1-qⁿ)⁶`. -/
class PartitionMod5 : Prop where
  congr : ∀ n, partition (5 * n + 4) % 5 = 0

/-- **Ramanujan's mod-7 congruence** (general): `p(7n + 5) ≡ 0 (mod 7)` for all `n`. -/
class PartitionMod7 : Prop where
  congr : ∀ n, partition (7 * n + 5) % 7 = 0

/-- **Ramanujan's mod-11 congruence** (general): `p(11n + 6) ≡ 0 (mod 11)` for all `n`. -/
class PartitionMod11 : Prop where
  congr : ∀ n, partition (11 * n + 6) % 11 = 0

end RamanujanPartitions
