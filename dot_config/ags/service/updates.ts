// service/updates.ts
import { createPoll } from "ags/time"
import { execAsync } from "ags/process"
export const updates = createPoll(0, 3_600_000, async () =>
  parseInt(await execAsync(["sh", "-lc", "(checkupdates 2>/dev/null; paru -Qua 2>/dev/null) | wc -l"]).catch(() => "0")))
