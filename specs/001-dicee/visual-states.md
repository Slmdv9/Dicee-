# T1: visual state reference

This reference establishes the visual decisions for the first implementation
task. It is intentionally limited to observable states and does not introduce
production state models, dependencies, or animation code.

## Test-first acceptance checklist

- [ ] Each state below can be identified by a reviewer without inspecting
  implementation details.
- [ ] Each state has a visible decision that can be checked against `spec.md`.
- [ ] The reference covers one-die and two-dice modes, both themes, and reduced
  motion before any later animation or layout task begins.

## State decisions

| State | Visual decision | Verification | RF |
| --- | --- | --- | --- |
| Available — light | Expressive light Material 3 surfaces, a prominent result area, and a clearly enabled primary roll action. | The action is visually available and the selected mode is distinguishable. | RF-1, RF-7 |
| Available — dark | The same hierarchy as light mode with dark surfaces, equivalent contrast, and a clearly enabled primary action. | Text, navigation, dice, and action remain legible. | RF-1, RF-7 |
| Rolling — light/dark | The die area communicates an active 800 ms roll; the primary action appears occupied and cannot trigger another roll. | A reviewer can see the transition state and cannot start a second roll. | RF-2, RF-3 |
| Stable result — light/dark | The generated face remains the visual focus after the transition; in two-dice mode, each face remains distinct. | The final value remains unchanged and both dice are independently readable. | RF-2, RF-4, RF-5 |
| Reduced motion — light/dark | Replace the full spin with an attenuated transition while preserving result, labels, and control state. | The result and action state remain understandable without relying on motion. | RF-2, RF-6 |
| Compact or changed layout | Preserve the result, navigation, and primary action without clipping or overlap. | All essential controls and dice remain usable in the available space. | RF-1, RF-4, RF-7 |

## Boundary decisions

- The one-die and two-dice modes retain independent visual state and results.
  **Covers:** RF-3, RF-4.
- The six existing die values and light/dark assets remain the source of truth.
  **Covers:** RF-5.
- No sound, haptics, new permissions, new dice modes, persistence, or backend
  behavior is represented here. **Covers:** RF-2, RF-7.

## T1 completion evidence

T1 is complete when the checklist and state table above are reviewed against
`spec.md`, with every state decision accepted before T2 begins.
