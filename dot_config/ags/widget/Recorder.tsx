// widget/Recorder.tsx — blinking indicator; click stops (a `rec` bin starts region/full+audio)
import { execAsync } from "ags/process"
import { recording } from "../service/recorder"
export default function Recorder() {
  return <button visible={recording} class="recording" onClicked={() => execAsync(["rec", "stop"])}>
    <label label="●REC" /></button>
}
