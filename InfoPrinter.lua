local localplayer = game:GetService("Players").LocalPlayer
local time = tostring(os.date( "!%a %b %d, %H:%M", os.time() + 8 * 60 * 60 ))

print("IP: "..tostring(game:HttpGet("https://api.ipify.org/?")))
print("HWID: "..tostring(game:GetService("RbxAnalyticsService"):GetClientId()))
print("Username: "..tostring(localplayer.Name))
print("ID: "..tostring(localplayer.UserId))
print("Account Age: "..tostring(localplayer.AccountAge).." days")
print("Time: "..tostring(time))
print("They can also get timezone.")
