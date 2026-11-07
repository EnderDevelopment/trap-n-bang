# Roblox Trap Script

A server-side Roblox trap script that captures a player who touches a designated part, then creates a visual bang and damages players within range. This Roblox script uses server-authoritative logic and does not need client-side code or a RemoteEvent.

## Install

1. In Roblox Studio, add a `BasePart` named `Trap` to `Workspace` and set `CanTouch` to `true`.
2. Create a `Script` in `ServerScriptService`.
3. Copy the contents of `TrapServer.server.lua` into the script.
4. Start a Studio test and touch the trap to verify its behavior.

## Use

When a living character touches `Workspace.Trap`, the script prevents movement and rotation for two seconds. It then restores the character's previous movement settings, creates a visual explosion with no physical force or crater, and applies 25 damage to living players within 12 studs. The trap becomes available again after a four-second cooldown. Adjust `CAPTURE_SECONDS`, `COOLDOWN_SECONDS`, `BANG_RADIUS`, and `BANG_DAMAGE` near the top of the script to change these values.

---

More Roblox script projects by EnderDevelopment: https://github.com/EnderDevelopment

Project page: https://dash.enderdevelopment.com/community/9199c432-359f-4773-9f22-a986a67a6969?utm_source=github&utm_medium=readme&utm_campaign=auto_publish&utm_content=9199c432-359f-4773-9f22-a986a67a6969
