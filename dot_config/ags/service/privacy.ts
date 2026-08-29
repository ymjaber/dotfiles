// service/privacy.ts
import { createPoll } from "ags/time"
import { execAsync } from "ags/process"
const yes = (s: string) => execAsync(["sh", "-lc", s]).then(o => !!o.trim()).catch(() => false)
// cam/screen stay shell probes — no Astal library covers them; the mic is a binding in Privacy.tsx
export const privacy = createPoll({ cam: false, screen: false }, 2000, async () => ({
  cam:    await yes("fuser /dev/video* 2>/dev/null && echo 1"),        // pkg: psmisc
  // ⚠ NOT `pactl list | grep xdg-desktop-portal`: the portal is a PipeWire client whenever it runs, so
  // that matched with no share active (permanently lit, 2026-08-28). A live screencast is a video
  // stream node; pw-cli lists it in 20 ms.
  screen: await yes("pw-cli ls Node 2>/dev/null | grep -qE 'Stream/(Output|Input)/Video' && echo 1"),
}))
