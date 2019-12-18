--Configuration du Menu en jeu
SLASH_XTA1, SLASH_XTA2 = "/xcktranq", "/xtranq"
SlashCmdList["XTA"] = function(message)
	local cmd = { }
	for c in string.gmatch(message, "[^ ]+") do
		table.insert(cmd, string.lower(c))
	end
	if cmd[1] == "config" then
		XTranqManagerUI:Show();
		DEFAULT_CHAT_FRAME:AddMessage("|cfffbb034<|r|cffead454Xckbucl Tranquilizing Shot Manager|r Made by Xckbucl on K2/LH/Sulfuron Classic|cffead454 Settings")
		elseif cmd[1] == "switch" then
		SwitchRanged();
		else
		if not XckbuclTranqEnable then
			XckbuclTranqEnable = "enabled"
		end
		if not XckbuclTranqSettings then
			XckbuclTranqSettings = "YELL"
		end
		if not XckbuclTranqWhispers then
			XckbuclTranqWhispers = "enabled"
		end
		if not XckbuclTanqRotationPlayer then
			XckbuclTanqRotationPlayer = UnitName("player")
		end
		DefautMsg()
	end
end



------AFFICHAGE MESSAGE ADDON
function DefautMsg()
	DEFAULT_CHAT_FRAME:AddMessage("|cfffbb034<|r|cffead454Xckbucl Tranquilizing Shot Manager|r Made by Xckbucl on K2/LH/Sulfuron Classic")
	DEFAULT_CHAT_FRAME:AddMessage("|cfffbb034<|rAvailable Commands|r|cfffbb034>")
	DEFAULT_CHAT_FRAME:AddMessage("UI Config Menu |cff49C0C0/xtranq config|r || |cff49C0C0/xcktranq config|r || |cff49C0C0/xtranq")
	DEFAULT_CHAT_FRAME:AddMessage("|cfffbb034<|rActual Settings|r|cfffbb034>")
	DEFAULT_CHAT_FRAME:AddMessage("|cff20b2aa-->|r |cffffd700Channel : |cffead454<|r|cff069206" .. string.lower(XckbuclTranqSettings) .. "|r|cffead454>")
	DEFAULT_CHAT_FRAME:AddMessage("|cff20b2aa--->|r |cffffd700Send Whispers :  |cffead454<|r|cff069206" .. XckbuclTranqWhispers .. "|r|cffead454>")
	DEFAULT_CHAT_FRAME:AddMessage("|cff20b2aa---->|r |cffffd700Next Player for Tranquilizing Shot :  |cffead454<|r|cff069206" .. XckbuclTanqRotationPlayer .. "|r|cffead454>")
	
end



------SAUVEGARDER PARAMETRES
function SaveSettings()
	local SelectedChannelID = UIDropDownMenu_GetSelectedID(MainSettingsComboBox1);
	if SelectedChannelID == nil then
		DEFAULT_CHAT_FRAME:AddMessage("|cFF7F0000Please Select Channel")
		elseif SelectedChannelID == 1 then
		XckbuclTranqSettings = "EMOTE"
		elseif SelectedChannelID == 2 then
		XckbuclTranqSettings = "SAY"
		elseif SelectedChannelID == 3 then
		XckbuclTranqSettings = "YELL"
		elseif SelectedChannelID == 4 then
		XckbuclTranqSettings = "PARTY"
		elseif SelectedChannelID == 5 then
		XckbuclTranqSettings = "RAID"
	end
	
	if not XckbuclTranqEnable then
		XckbuclTranqEnable = "enabled"
	end
	
	if UnitName("target") == nil then
		DEFAULT_CHAT_FRAME:AddMessage("|cFF7F0000Please Target the Next Hunter on Tranq")
		else
		local playerNameTarget = UnitName("target");
		XckbuclTanqRotationPlayer = playerNameTarget
		
		if MainSettingsCheckButton2:GetChecked() then
			XckbuclTranqWhispers = "enabled"
			else 
			XckbuclTranqWhispers = "disabled"
		end
		
		DEFAULT_CHAT_FRAME:AddMessage("|cfffbb034<|rNew Settings|r|cfffbb034>")
		DEFAULT_CHAT_FRAME:AddMessage("|cff20b2aa-->|r |cffffd700Channel set to :|r |cffead454<|r|cff069206" .. string.lower(XckbuclTranqSettings) .. "|r|cffead454>")
		DEFAULT_CHAT_FRAME:AddMessage("|cff20b2aa--->|r |cffffd700Send Whispers is :|r  |cffead454<|r|cff069206" .. XckbuclTranqWhispers .. "|r|cffead454>")
		DEFAULT_CHAT_FRAME:AddMessage("|cff20b2aa---->|r |cffffd700Next Player for Tranquilizing Shot is :|r  |cffead454<|r|cff069206" .. XckbuclTanqRotationPlayer .. "|r|cffead454>")
	end
end

------SWITCH WEAPON NEFA
local Infos = { BagN, SlotStored, IsEquiped }
function SwitchRanged()
	PickupInventoryItem(18)
	if(CursorHasItem()) then
		for bag = 0,4 do
			local bagsize = GetContainerNumSlots(bag)
			for slot = 1,bagsize do
				link = GetContainerItemLink(bag,slot)
				if link == nil then
					Infos.BagN = bag
					Infos.SlotStored = slot
					PickupContainerItem(Infos.BagN, Infos.SlotStored)
					Infos.IsEquiped = nil;
					DEFAULT_CHAT_FRAME:AddMessage("Weapon UnGeared")
					return
				end
			end
		end
		else
		PickupContainerItem(Infos.BagN, Infos.SlotStored); PickupInventoryItem(18)
		Infos.IsEquiped = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Weapon Geared")
	end
end


------ACTIVER/DESACTIVER ADDON
function XTranqEnabled()
	if MainSettingsCheckButton1:GetChecked() then
		XckbuclTranqEnable = "enabled"
		DEFAULT_CHAT_FRAME:AddMessage("|cffead454Xckbucl Tranquilizing Shot Manager|r : |cff069206Enabled")
		else 
		XckbuclTranqEnable = "disabled"
		DEFAULT_CHAT_FRAME:AddMessage("|cffead454Xckbucl Tranquilizing Shot Manager|r : |cFF7F0000Disabled")
	end
end


------CHARGER LES PARAMETRES
function LoadSettings()
	XTranqManagerUITitleString:SetText("Xckbucl TranqManager v" .. GetAddOnMetadata("XTranqManager", "Version"));
	
	if XckbuclTranqEnable == "enabled" then
		MainSettingsCheckButton1:SetChecked(true)
		else 
		MainSettingsCheckButton1:SetChecked(false)
	end
	if XckbuclTranqWhispers == "enabled" then
		MainSettingsCheckButton2:SetChecked(true)
		else 
		MainSettingsCheckButton2:SetChecked(false)
	end
	
	if not XckbuclTranqCustomMsgHit then
		XckbuclTranqCustomMsgHit = "Tranquilizing Shot Success Hit! Next is : "
		XckbuclTranqCustomMsgWHit = "Your are the next on Tranquilizing Shot, be READY!"
		XckbuclTranqCustomMsgMiss = "Tranquilizing Shot FAILED! Shoot it NOW : "
		XckbuclTranqCustomMsgWMiss = "<<<<FAIL TRANQ SHOT>>>>, Tranq it >>____NOW____<<!"
	end
	MsgSettingsSinglelineEditBox1:SetText(XckbuclTranqCustomMsgHit)
	MsgSettingsSinglelineEditBox2:SetText(XckbuclTranqCustomMsgWHit)
	MsgSettingsSinglelineEditBox3:SetText(XckbuclTranqCustomMsgMiss)
	MsgSettingsSinglelineEditBox4:SetText(XckbuclTranqCustomMsgWMiss)
	
end


-----MESSAGES PERSONNALISER
function TestMsgHit()
	SendChatMessage(MsgSettingsSinglelineEditBox1:GetText() .. " <" .. string.upper(XckbuclTanqRotationPlayer) .. ">", XckbuclTranqSettings)
end
function TestMsgWHit()
	SendChatMessage(MsgSettingsSinglelineEditBox2:GetText(), "WHISPER", nil, XckbuclTanqRotationPlayer)
end
function TestMsgMiss()
	SendChatMessage(MsgSettingsSinglelineEditBox3:GetText() .. " <" .. string.upper(XckbuclTanqRotationPlayer) .. ">", XckbuclTranqSettings)
end
function TestMsgWMiss()
	SendChatMessage(MsgSettingsSinglelineEditBox4:GetText(), "WHISPER", nil, XckbuclTanqRotationPlayer)
end

function SaveMsg()
	
	XckbuclTranqCustomMsgHit = MsgSettingsSinglelineEditBox1:GetText()
	XckbuclTranqCustomMsgWHit = MsgSettingsSinglelineEditBox2:GetText()
	XckbuclTranqCustomMsgMiss = MsgSettingsSinglelineEditBox3:GetText()
	XckbuclTranqCustomMsgWMiss = MsgSettingsSinglelineEditBox4:GetText()
	
	DEFAULT_CHAT_FRAME:AddMessage("|cff20b2aa-->|r |cffffd700Custom Messages :|r |cffead454<|r|cff069206Saved|r|cffead454>")
end

function ResetMsg()
	
	XckbuclTranqCustomMsgHit = "Tranquilizing Shot Success Hit! Next is : "
	XckbuclTranqCustomMsgWHit = "Your are the next on Tranquilizing Shot, be READY!"
	XckbuclTranqCustomMsgMiss = "Tranquilizing Shot FAILED! Shoot it NOW : "
	XckbuclTranqCustomMsgWMiss = "<<<<FAIL TRANQ SHOT>>>>, Tranq BOSS NOW!"
	
	MsgSettingsSinglelineEditBox1:SetText(XckbuclTranqCustomMsgHit)
	MsgSettingsSinglelineEditBox2:SetText(XckbuclTranqCustomMsgWHit)
	MsgSettingsSinglelineEditBox3:SetText(XckbuclTranqCustomMsgMiss)
	MsgSettingsSinglelineEditBox4:SetText(XckbuclTranqCustomMsgWMiss)
	
	DEFAULT_CHAT_FRAME:AddMessage("|cff20b2aa-->|r |cffffd700Custom Messages :|r |cffead454<|r|cff069206Reset|r|cffead454>")
end