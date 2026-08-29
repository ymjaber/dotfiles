// service/weather.ts
import { createPoll } from "ags/time"
import { execAsync } from "ags/process"
export const WMO: Record<number, string> = { 0:"☀",1:"🌤",2:"⛅",3:"☁",45:"🌫",48:"🌫",51:"🌦",
  61:"🌧",63:"🌧",65:"🌧",71:"🌨",73:"🌨",75:"❄",80:"🌦",95:"⛈",96:"⛈" }
// ⚠ createPoll never catches a rejected fn (lib/time.ts: `value.then(set)`) — offline, no coords yet,
// a non-JSON body: all would log an unhandled rejection every hour. Return `prev` to keep the last reading.
export const weather = createPoll<any>(null, 3_600_000, async (prev) => {
  try {
    const ll = await execAsync(["sun", "coords"]); if (!ll) return prev
    const [lat, lon] = ll.split(",")
    const j = JSON.parse(await execAsync(["curl", "-sf", "--max-time", "5",
      `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current=temperature_2m,weather_code&daily=temperature_2m_max,temperature_2m_min,weather_code&timezone=auto&forecast_days=5`]))
    return { t: Math.round(j.current.temperature_2m), icon: WMO[j.current.weather_code] ?? "?", daily: j.daily }
  } catch { return prev }
})
