import Mathlib

/-! # The partition function `p(n)`, computably

`p(n)` is the number of partitions of `n`. Mathlib has the *type* `Nat.Partition n` but not a computable
counting function. We define one via **Euler's pentagonal-number recurrence**

`p(n) = Σ_{k≥1} (-1)^{k-1} [ p(n - k(3k-1)/2) + p(n - k(3k+1)/2) ]`,

a consequence of Euler's pentagonal number theorem `∏(1-q^n) = Σ_k (-1)^k q^{k(3k-1)/2}`. Taking the
recurrence as the definition gives a `native_decide`-reducible `partition : ℕ → ℕ` (exactly as
`RamanujanTau.tau` is defined from the truncated Euler product). The generalized pentagonal numbers
`g_k = k(3k±1)/2` grow quadratically, so only `O(√n)` terms contribute to each `p(n)`.
-/

namespace RamanujanPartitions

/-- The generalized pentagonal numbers `≤ N`, each paired with its sign `(-1)^{k-1}`:
`(1,+), (2,+), (5,-), (7,-), (12,+), (15,+), …`. -/
def pents (N : ℕ) : List (ℕ × Int) :=
  (List.range (N + 1)).foldl (init := []) fun acc i =>
    let k := i + 1
    let g1 := k * (3 * k - 1) / 2
    let g2 := k * (3 * k + 1) / 2
    let sign : Int := if k % 2 = 1 then 1 else -1
    let acc := if 1 ≤ g1 ∧ g1 ≤ N then acc ++ [(g1, sign)] else acc
    if g2 ≤ N then acc ++ [(g2, sign)] else acc

/-- The array `#[p(0), p(1), …, p(N)]`, built by Euler's recurrence. -/
def partAux (N : ℕ) : Array ℕ := Id.run do
  let ps := pents N
  let mut a : Array ℕ := #[1]                 -- p(0) = 1
  for m in [1:N+1] do
    let mut s : Int := 0
    for (g, sgn) in ps do
      if g ≤ m then s := s + sgn * (a[m - g]! : Int)
    a := a.push s.toNat
  return a

/-- **The partition function** `p(n)` (number of partitions of `n`), via Euler's pentagonal recurrence.
`native_decide`-reducible: every value reduces by computation. -/
def partition (n : ℕ) : ℕ := (partAux n)[n]!

/-! ## Sanity: the first values match OEIS A000041 `1,1,2,3,5,7,11,15,22,30,42,…` -/

theorem p_zero  : partition 0 = 1  := by native_decide
theorem p_one   : partition 1 = 1  := by native_decide
theorem p_two   : partition 2 = 2  := by native_decide
theorem p_three : partition 3 = 3  := by native_decide
theorem p_four  : partition 4 = 5  := by native_decide
theorem p_five  : partition 5 = 7  := by native_decide
theorem p_six   : partition 6 = 11 := by native_decide
theorem p_ten   : partition 10 = 42 := by native_decide

/-- `p(100) = 190569292` — a classic large value (Hardy–Ramanujan / MacMahon). -/
theorem p_hundred : partition 100 = 190569292 := by native_decide

end RamanujanPartitions
