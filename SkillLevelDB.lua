local addonName, addonTable = ...
local DA = LibStub("AceAddon-3.0"):GetAddon("Skillet") -- for DebugAids.lua
--[[
Skillet: A tradeskill window replacement.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]--

local skillLevelDB = {
    -- [0] = "orange/yellow/green/gray",

    -- [急救]: [3273]
    [14530] = "290/290/320/350",    -- 厚符文布绷带
    [14529] = "270/270/290/320",    -- 符文布绷带
    [8545]  = "240/240/270/300",    -- 厚魔纹绷带
    [8544]  = "210/210/240/270",    -- 魔纹绷带
    [6451]  = "180/180/210/240",    -- 厚丝质绷带
    [6450]  = "150/150/180/210",    -- 丝质绷带
    [3531]  = "115/115/150/185",    -- 厚绒线绷带
    [6452]  = "80/80/115/150",      -- 抗毒药剂
    [3530]  = "80/80/115/150",      -- 绒线绷带
    [2581]  = "40/50/75/100",       -- 厚亚麻绷
    [1251]  = "1/30/45/60",         -- 亚麻绷
}

function Skillet:GetItemIdByRecipeName(recipeName)
    if recipeName then
        local recipeData = self:GetRecipe(recipeName)
        if recipeData then
            return recipeData.itemID
        end
    end
    return nil
end

function Skillet:GetItemIdByTradeIndex(tradeID, index)
    --print("GetSpellIdByTradeIndex("..tostring(tradeID)..", "..tostring(index)..")")
    if not tradeID or not index then
        return nil
    end
    local skill = self:GetSkill(self.currentPlayer, tradeID, index)
    if skill then
        local recipeName = skill.id
        if recipeName then
            local recipeData = self:GetRecipe(recipeName)
            if recipeData then
                return recipeData.itemID
            end
        end
    end
    return nil
end

function Skillet:GetTradeSkillLevelByItemID(itemID)
    if itemID then
        if skillLevelDB and skillLevelDB[itemID] then
            --print("SkillLevels = "..tostring(skillLevelDB[itemID]))
            a,b,c,d = string.split("/", skillLevelDB[itemID])
            a = tonumber(a) or 0
            b = tonumber(b) or 0
            c = tonumber(c) or 0
            d = tonumber(d) or 0
            return a, b, c, d
        end
    end
    return 0, 0, 0, 0
end

function Skillet:GetTradeSkillLevelByRecipeName(recipeName)
    local itemID = self:GetItemIdByRecipeName(recipeName)
    return self:GetTradeSkillLevelByItemID(itemID)
end
