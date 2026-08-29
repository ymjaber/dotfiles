// service/prayers.ts — polls the CLI once a minute; null while no cache exists (machine skipped deen, or first boot offline)
import { createPoll } from "ags/time"
import { execAsync } from "ags/process"
export type Prayers = { timings: Record<string, string>; hijri: { day: string; year: string; month: { ar: string } } }
export const prayer = createPoll<Prayers | null>(null, 60_000, async prev => {
  try { return JSON.parse(await execAsync(["prayer", "--json"])) } catch { return prev }
})
export const qibla = createPoll("", 3_600_000, async prev => execAsync(["prayer", "qibla"]).catch(() => prev))
