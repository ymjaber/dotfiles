// widget/Dashboard.tsx  (verified: <stackswitcher> is NOT an intrinsic — use the Gtk class; its `stack`
// must exist first, so wire it in the PARENT's `$` setup, which Gnim runs after all children are appended.
// <stack> IS an intrinsic, but Gnim defers `visibleChildName` until the children exist only for the
// <Gtk.Stack> CLASS component — the intrinsic name is resolved after that check, so GTK would get the
// name in the constructor, warn "Child name 'overview' not found", and fall back to the first child.)
import app from "ags/gtk4/app"
import { Astal, Gtk } from "ags/gtk4"
import Weather from "./Weather"; import SysMon from "./SysMon"
import Media from "./Media"; import Calendar from "./Calendar"; import Mixer from "./Mixer"
const { TOP } = Astal.WindowAnchor
export default function Dashboard() {
  let stack: Gtk.Stack, switcher: Gtk.StackSwitcher
  return <window name="dashboard" namespace="dashboard" application={app} anchor={TOP} layer={Astal.Layer.OVERLAY}
    keymode={Astal.Keymode.ON_DEMAND} class="dashboard">
    <box orientation={1} spacing={12} $={() => switcher.set_stack(stack)}>
      <Gtk.StackSwitcher $={(w) => (switcher = w)} />
      <Gtk.Stack visibleChildName="overview" $={(w) => (stack = w)}>
        <box $type="named" name="overview" spacing={12}><Weather /><SysMon /></box>
        <box $type="named" name="media"><Media /></box>
        <box $type="named" name="mixer"><Mixer /></box>
        <box $type="named" name="calendar"><Calendar /></box>
      </Gtk.Stack>
    </box>
  </window>
}
