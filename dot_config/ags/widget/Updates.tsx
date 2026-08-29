// widget/Updates.tsx — click opens a titled upgrade terminal
import { execAsync } from "ags/process"
import { updates } from "../service/updates"
export default function Updates() {
  return <button visible={updates(n => n > 0)}
    onClicked={() => execAsync(["kitty", "--title", "update", "sh", "-lc", "paru -Syu; read -n1"])}>
    <label label={updates(n => ` ${n}`)} /></button>
}
