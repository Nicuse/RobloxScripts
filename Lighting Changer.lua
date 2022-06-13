--//VARIABLES
local lighting = game:GetService('Lighting');
local defaultSettings = {
	appearance = {
		ambient = lighting.Ambient;
		brightness = lighting.Brightness;
		colorshift_bottom = lighting.ColorShift_Bottom;
		colorshift_top = lighting.ColorShift_Top;
		environmentdiffusescale = lighting.EnvironmentDiffuseScale;
		environmentspecularscale = lighting.EnvironmentSpecularScale;
		globalshadows = lighting.GlobalShadows;
		outdoorambient = lighting.OutdoorAmbient;
		shadowsoftness = lighting.ShadowSoftness;
	};

	data = {
		archivable = lighting.Archivable;
		classname = lighting.ClassName;
		clocktime = lighting.ClockTime;
		geographiclatitude = lighting.GeographicLatitude;
		name = lighting.Name;
		parent = lighting.Parent;
		timeofday = lighting.TimeOfDay;
	};

	exposure = {
		exposurecompensation = lighting.ExposureCompensation
	};

	fog = {
		FogColor = game:GetService('Lighting').FogColor;
		FogEnd = game:GetService('Lighting').FogEnd;
		FogStart = game:GetService('Lighting').FogStart;
	};
};

--//Main

function applydefaultsettings()
	--//Appearance
	lighting.Ambient = defaultSettings.appearance.ambient;
	lighting.Brightness = defaultSettings.appearance.brightness;
	lighting.ColorShift_Bottom = defaultSettings.appearance.colorshift_bottom;
	lighting.ColorShift_Top = defaultSettings.appearance.colorshift_top;
	lighting.EnvironmentDiffuseScale = defaultSettings.appearance.environmentdiffusescale;
	lighting.EnvironmentSpecularScale = lighting.EnvironmentSpecularScale;
	lighting.GlobalShadows = defaultSettings.appearance.globalshadows;
	lighting.OutdoorAmbient = defaultSettings.appearance.outdoorambient
	lighting.ShadowSoftness = defaultSettings.appearance.shadowsoftness
	--//Data
	lighting.Archivable = defaultSettings.data.archivable;
	lighting.ClassName = defaultSettings.data.classname;
	lighting.ClockTime = defaultSettings.data.clocktime;
	lighting.GeographicLatitude = defaultSettings.data.geographiclatitude;
	lighting.Name = defaultSettings.data.name;
	lighting.Parent = defaultSettings.data.parent;
	lighting.TimeOfDay = defaultSettings.data.timeofday;
	--//Fog
	lighting.FogColor = defaultSettings.fog.FogColor;
	lighting.FogEnd = defaultSettings.fog.FogEnd;
	lighting.FogStart = defaultSettings.fog.FogStart;
end

function newdefaultsettings()
	defaultSettings = {
		appearance = {
			ambient = lighting.Ambient;
			brightness = lighting.Brightness;
			colorshift_bottom = lighting.ColorShift_Bottom;
			colorshift_top = lighting.ColorShift_Top;
			environmentdiffusescale = lighting.EnvironmentDiffuseScale;
			environmentspecularscale = lighting.EnvironmentSpecularScale;
			globalshadows = lighting.GlobalShadows;
			outdoorambient = lighting.OutdoorAmbient;
			shadowsoftness = lighting.ShadowSoftness;
		};

		data = {
			archivable = lighting.Archivable;
			classname = lighting.ClassName;
			clocktime = lighting.ClockTime;
			geographiclatitude = lighting.GeographicLatitude;
			name = lighting.Name;
			parent = lighting.Parent;
			timeofday = lighting.TimeOfDay;
		};

		exposure = {
			exposurecompensation = lighting.ExposureCompensation
		};

		fog = {
			FogColor = game:GetService('Lighting').FogColor;
			FogEnd = game:GetService('Lighting').FogEnd;
			FogStart = game:GetService('Lighting').FogStart;
		};
	};
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Lighting Changer", "Synapse")

local appearanceTab = Window:NewTab("Appearance")
local dataTab = Window:NewTab("Data")
local exposureTab = Window:NewTab("Exposure")
local fogTab = Window:NewTab("Fog")

local miscTab = Window:NewTab("Misc")

--//Appearance
local appearanceSection = appearanceTab:NewSection("Appearance")

appearanceSection:NewTextBox("Ambient", "Self-explain", function(txt)
	lighting.Ambient = txt
end)

appearanceSection:NewSlider("Brightness", "Self-explain", 10, 0, function(v)
	lighting.Brightness = v
end)

appearanceSection:NewToggle("Global Shadows", "Enable/disable shadows for the game.", function(state)
	if state then
		lighting.GlobalShadows = true
	else
		lighting.GlobalShadows = false
	end
end)

--//Data
local dataSection = dataTab:NewSection("Data")

dataSection:NewSlider("Clock Time", "Self-explain", 23.9, 0, function(v)
	lighting.ClockTime = v
end)

dataSection:NewSlider("Geographic Latitude", "Geographic Latitude", 360, 0, function(v)
	lighting.GeographicLatitude = v
end)

appearanceSection:NewTextBox("Time Of Day", "Self-explain", function(txt)
	lighting.TimeOfDay = txt
end)
--//Exposure
local exposureSection = exposureTab:NewSection("Exposure")

exposureSection:NewSlider("Exposure Compensation", "Exposure Compensation", 3, -3, function(v)
	lighting.ExposureCompensation = v
end)
--//Fog
local fogSection = fogTab:NewSection("Fog")

fogSection:NewTextBox("Fog Color", "Self-explain", function(txt)
	lighting.FogColor = txt
end)

fogSection:NewTextBox("Fog End", "Self-explain", function(txt)
	lighting.FogEnd = txt
end)

fogSection:NewTextBox("Fog Start", "Self-explain", function(txt)
	lighting.FogStart = txt
end)

--//Misc
local miscSection = miscTab:NewSection("Misc")
local creditsSection = miscTab:NewSection("Credits")

miscSection:NewKeybind("Toggle UI", "Toggles UI.", Enum.KeyCode.RightControl, function()
	Library:ToggleUI()
end)

miscSection:NewButton("Fullbright", "Self-explain", function()
	lighting.Brightness = 2
	lighting.ClockTime = 14
	lighting.FogEnd = 100000
	lighting.GlobalShadows = false
	lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end)

miscSection:NewButton("Loop Fullbright", "Self-explain", function()
	while true do
		lighting.Brightness = 2
		lighting.ClockTime = 14
		lighting.FogEnd = 100000
		lighting.GlobalShadows = false
		lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
		wait(0.0001)
	end
end)

miscSection:NewButton("Apply Default Settings", "Applys default settings for the game.", function()
	applydefaultsettings()
end)

miscSection:NewButton("New Default Settings", "Makes the default settings for the game the current settings.", function()
	newdefaultsettings()
end)

creditsSection:NewButton("Nicuse#6163", "Nicuse#6163", function()
	setclipboard("setclipboard")
end)
