// widget/Toggle.tsx — a reusable shell-backed pill (its own module: the overlay contract lets any
// use-case guide import it; typechecked standalone by the Verify gate)
import { createState } from "ags"
import { execAsync } from "ags/process"
export default function Toggle({ icon, probe, action }: { icon: string; probe: string; action: (on: boolean) => string }) {
  const [on, setOn] = createState(false)
  // ⚠ execAsync REJECTS on a non-zero exit, and every probe's off-branch exits 1 (`[ -e … ] && …`, `grep -q … && …`):
  // the rejection IS the "off" answer — route it to setOn(false), or the pill can only ever turn on
  const read = () => execAsync(["sh", "-lc", probe]).then((o: string) => setOn(!!o), () => setOn(false))
  read()
  return (
    <button class={on(o => o ? "on" : "")}
      onClicked={() => {
        const n = !on.peek(); setOn(n)                                    // optimistic; read() restores the truth
        execAsync(["sh", "-lc", action(n)]).catch(() => {}).finally(read) // catch: a failed action (exit ≠ 0) must not become an unhandled rejection
      }}>
      <label label={icon} />
    </button>
  )
}
