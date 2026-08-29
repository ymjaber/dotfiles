// service/recorder.ts
import { createPoll } from "ags/time"
import { execAsync } from "ags/process"
// ⚠ pidof, not `pgrep -x`: pgrep matches the kernel's 15-char comm ("gpu-screen-reco"), so the 19-char name never matches
// (procps-ng 4.0.6 warns and exits 1). pidof compares the full argv[0]; its exit 1 (not running) becomes execAsync's rejection.
export const recording = createPoll(false, 1000, () =>
  execAsync(["pidof", "gpu-screen-recorder"]).then(() => true, () => false))
