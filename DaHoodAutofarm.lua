--[[
PLEASE DON'T STEAL THIS SCRIPT AND CREDIT IT AS YOURS!
Include credits when including script.

Contact for help at: Nicuse#6163
--]]


local StarterGui = game:GetService("StarterGui")

StarterGui:SetCore("SendNotification", {
	Title = "Da Hood AutoFarm";
	Text = "Loading...";
	Duration = 69420;
	Button1 = "Okay";
})

if not game:IsLoaded() then
	StarterGui:SetCore("SendNotification", {
		Title = "Da Hood AutoFarm";
		Text = "Waiting for game to load.";
		Duration = 69420;
		Button1 = "Okay";
	})
end

if game:IsLoaded() then
	StarterGui:SetCore("SendNotification", {
		Title = "Da Hood AutoFarm";
		Text = "By Amnesia";
		Duration = 69420;
		Button1 = "Okay";
	})

	StarterGui:SetCore("SendNotification", {
		Title = "Da Hood AutoFarm";
		Text = "Toggle by Nicuse#6163";
		Duration = 69420;
		Button1 = "Okay";
	})

	local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
	local Window = Library.CreateLib("Da Hood AUTOFARM GUI", "GrapeTheme")

	local Autofarm = Window:NewTab("AutoFarm")
	local credits = Window:NewTab("Credits")

	local autofarmS = Autofarm:NewSection("AutoFarm")

	autofarmS:NewToggle("AutoFarm", "Autofarm by Amnesia", function(state)
		if state then
			loadstring(game:HttpGet("https://raw.githubusercontent.com/rapnz/scripts/master/DaHoodFarm.lua"))()
		else
			shared.MoneyFarm = false
		end
	end)
	local creditsS = credits:NewSection("Credits")
	creditsS:NewLabel("AutoFarm by Amnesia")
	creditsS:NewLabel("Toggle by Nicuse#6163")
	creditsS:NewLabel("UI: xHeptc UI Library")
end
