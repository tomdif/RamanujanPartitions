import Mathlib

/-! # The Hardy–Ramanujan number 1729 (the taxicab number `Ta(2)`)

> "I remember once going to see him when he was ill at Putney. I had ridden in taxi cab number 1729 and
> remarked that the number seemed to me rather a dull one… 'No,' he replied, 'it is a very interesting
> number; it is the smallest number expressible as the sum of two cubes in two different ways.'"  — G. H. Hardy

We prove exactly that statement: `1729 = 1³ + 12³ = 9³ + 10³`, and it is the **smallest** positive
integer with two distinct representations as a sum of two positive cubes (`Ta(2) = 1729`). Both facts are
finite checks, owned by the kernel via `native_decide`.

(Kept in this Ramanujan repo as a companion to the partition congruences. Since `13³ = 2197 > 1729`, every
representation of any `n ≤ 1729` uses cubes of integers `≤ 12`, so the bounded search below is complete.)
-/

namespace RamanujanPartitions.Taxicab

/-- All pairs `(a, b)` with `1 ≤ a ≤ b ≤ 12` (complete for representing any `n ≤ 1729`). -/
def cubePairs : List (ℕ × ℕ) :=
  (List.range 13).flatMap fun a =>
    (List.range 13).filterMap fun b => if 1 ≤ a ∧ a ≤ b ∧ b ≤ 12 then some (a, b) else none

/-- The number of representations of `n` as `a³ + b³` with `1 ≤ a ≤ b` (complete for `n ≤ 1729`). -/
def repCount (n : ℕ) : ℕ := (cubePairs.filter fun p => p.1 ^ 3 + p.2 ^ 3 = n).length

/-- The two representations of 1729. -/
theorem taxicab_two_ways : 1 ^ 3 + 12 ^ 3 = 1729 ∧ 9 ^ 3 + 10 ^ 3 = 1729 := by decide

/-- 1729 has exactly two representations as a sum of two positive cubes. -/
theorem taxicab_repCount : repCount 1729 = 2 := by native_decide

/-- **1729 is the smallest** number with two such representations: every `n < 1729` has at most one. -/
theorem taxicab_minimal : ∀ n, n < 1729 → repCount n ≤ 1 := by native_decide

/-- **The Hardy–Ramanujan number, `Ta(2) = 1729`:** it is the least `n` with `repCount n = 2`. -/
theorem hardy_ramanujan_1729 :
    repCount 1729 = 2 ∧ ∀ n, n < 1729 → repCount n < 2 := by
  refine ⟨taxicab_repCount, fun n hn => ?_⟩
  have := taxicab_minimal n hn; omega

end RamanujanPartitions.Taxicab
