// widget/Calendar.tsx  (verified: <Gtk.Calendar /> — GObject classes are JSX components; the
// shipped template does exactly this)
import { createState, For } from "ags"
import { Gtk } from "ags/gtk4"
import { execAsync } from "ags/process"
import { writeFile } from "ags/file"
import GLib from "gi://GLib"
const F = GLib.get_home_dir() + "/.local/state/todo.json"
export default function Calendar() {
  const [todo, setTodo] = createState<string[]>([])
  const load = () => execAsync(["sh", "-lc", `cat ${F} 2>/dev/null || echo '[]'`]).then(j => setTodo(JSON.parse(j))).catch(() => {})
  load()
  // ⚠ execAsync takes NO stdin argument (utilities docs) — the 2026-08-09 draft passed one. writeFile instead;
  // it creates the parent directory itself, so no mkdir.
  const save = (a: string[]) => { setTodo(a); writeFile(F, JSON.stringify(a)) }
  // ⚠ <For> re-appends its children on every change, so it gets its own box — otherwise the tasks
  // would land BELOW the entry after the first save. Its 2nd argument is an index Accessor: peek() it.
  return <box orientation={1} class="calendar" spacing={8}>
    <Gtk.Calendar />
    <box orientation={1} class="todo">
      <box orientation={1}>
        <For each={todo}>
          {(t, i) => <button onClicked={() => save(todo.peek().filter((_, j) => j !== i.peek()))}><label xalign={0} label={`☐ ${t}`} /></button>}
        </For>
      </box>
      <entry placeholderText="+ task" onActivate={self => { save([...todo.peek(), self.text]); self.text = "" }} />
    </box>
  </box>
}
