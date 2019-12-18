if ( GetLocale() == "frFR" ) then
	
	Xckbucl_TRANQSPELLNAME = "Tir tranquillisant";
	-- Xckbucl_TRANQSPELLNAME = "Tir des arcanes"
	
	else
	
	Xckbucl_TRANQSPELLNAME = "Tranquilizing Shot";
	-- Xckbucl_TRANQSPELLNAME = "Arcane Shot"
end

tranqShotID = 19801;
ArcaneShotID = 3048;
AimedShotID = 20904;

--Variables jeu
XTranqManager = CreateFrame("Frame", nil)
XTranqManager:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

--Get Player Raid ID
function XTranqManager:GetRaidID()
	local targetID = 0;
	for i = 1, GetNumGroupMembers() do
		if UnitName("raid"..i) == XckbuclTanqRotationPlayer then
			targetID = i;
			break;
		end
	end
	return targetID
end

-- Return Player is in Raid or Party
function XTranqManager:IsInRaidOrParty()
	local RaidorParty = nil
	if(IsInGroup() and UnitInRaid("player") == nil) then
		RaidorParty = "party"
		elseif(IsInGroup() and UnitInRaid("player")) then
		RaidorParty = "raid"
	end
	return RaidorParty
end

function XTranqManager:OnEvent(event, ...)

	if(self:IsInRaidOrParty() == nil) then
	return;
	end

	local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
	local spellId, spellName, spellSchool
	local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand

	if subevent == "SPELL_CAST_SUCCESS" then
	spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = select(12, ...)
		if spellName == Xckbucl_TRANQSPELLNAME and sourceGUID == UnitGUID("player") then
			if XckbuclTranqEnable == "enabled" then
				SendChatMessage(XckbuclTranqCustomMsgHit .. " <" .. string.upper(XckbuclTanqRotationPlayer) .. ">", XckbuclTranqSettings)
				SetRaidTargetIcon("raid"..self:GetRaidID(), 8);
				if XckbuclTranqWhispers == "enabled" then
					SendChatMessage(XckbuclTranqCustomMsgWHit, "WHISPER", nil, XckbuclTanqRotationPlayer)
				end
			end
		end
	elseif subevent == "SPELL_MISSED" then
	spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = select(12, ...)
		if spellName == Xckbucl_TRANQSPELLNAME and sourceGUID == UnitGUID("player") then
			if XckbuclTranqEnable == "enabled" then
				SendChatMessage(XckbuclTranqCustomMsgMiss .. " <" .. string.upper(XckbuclTanqRotationPlayer) .. ">", XckbuclTranqSettings)
				SetRaidTargetIcon("raid"..self:GetRaidID(), 8);
				if XckbuclTranqWhispers == "enabled" then
					SendChatMessage(XckbuclTranqCustomMsgWMiss, "WHISPER", nil, XckbuclTanqRotationPlayer)
				end				  
			end
		end
	end
end


XTranqManager:SetScript("OnEvent", function(self, event)
	self:OnEvent(event, CombatLogGetCurrentEventInfo())
end)