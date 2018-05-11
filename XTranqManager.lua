if ( GetLocale() == "frFR" ) then
	
	Xckbucl_TRANQCASTYOU = "Vous lancez Tir tranquillisant";
	Xckbucl_TRANQMISSYOU = "Votre Tir tranquillisant rate";
	Xckbucl_TRANQRESISTYOU = "Votre Tir tranquillisant à été resist";
	Xckbucl_TRANQFAILYOU = "Vous n'avez pas réussi à dissiper";
	
	else
	
	Xckbucl_TRANQCASTYOU = "You cast Tranquilizing Shot";
	Xckbucl_TRANQMISSYOU = "Your Tranquilizing Shot miss";
	Xckbucl_TRANQRESISTYOU = "Your Tranquilizing Shot was resisted";
	Xckbucl_TRANQFAILYOU = "You fail to dispel";
	--Xckbucl_TRANQCASTYOU = "Your Auto Shot";	
end

--Variables jeu
XTranqManager = CreateFrame("Frame", nil)
XTranqManager:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
--XTranqManager:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
--XTranqManager:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");

--Get Player Raid ID
function GetRaidID()
	local targetID;
	for i = 1, GetNumRaidMembers() do
		if UnitName("raid"..i) == XckbuclTanqRotationPlayer then
			targetID = i;
			break;
		end
	end
	return targetID
end
--Function TranqManager
XTranqManager:SetScript("OnEvent", function ()
	--Player Tranq Hit
	if string.find(arg1, Xckbucl_TRANQCASTYOU) then
		if XckbuclTranqEnable == "enabled" then
			SendChatMessage(XckbuclTranqCustomMsgHit .. " <" .. string.upper(XckbuclTanqRotationPlayer) .. ">", XckbuclTranqSettings)
			SetRaidTargetIcon("raid"..GetRaidID(), 8);
			if XckbuclTranqWhispers == "enabled" then
				SendChatMessage(XckbuclTranqCustomMsgWHit, "WHISPER", nil, XckbuclTanqRotationPlayer)
			end
		end
	end
	
	--Player Tranq Miss
	if string.find(arg1, Xckbucl_TRANQMISSYOU) or  string.find(arg1, Xckbucl_TRANQRESISTYOU) or  string.find(arg1, Xckbucl_TRANQFAILYOU) then
		if XckbuclTranqEnable == "enabled" then
			SendChatMessage(XckbuclTranqCustomMsgMiss .. " <" .. string.upper(XckbuclTanqRotationPlayer) .. ">", XckbuclTranqSettings)
			SetRaidTargetIcon("raid"..GetRaidID(), 8);
            if XckbuclTranqWhispers == "enabled" then
				SendChatMessage(XckbuclTranqCustomMsgWMiss, "WHISPER", nil, XckbuclTanqRotationPlayer)
			end				  
		end
	end
end)