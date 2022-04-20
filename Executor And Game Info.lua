local Executor = identifyexecutor and identifyexecutor() or 'Unknown'

local gameIsLoaded = nil;

if game:IsLoaded() then
    gameIsLoaded = "True";
else
    if not game:IsLoaded() then
        gameIsLoaded = "False";
    end
end

function get(placeid)
    
end    

local Title = "Executor And Game Info"
local Body  = "Executor: "..Executor.."\n\nGame Is Loaded: "..gameIsLoaded.."\nPlace Id: "..game.PlaceId.."\n\nGame Name: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

messagebox(Body, Title, 0)
