local Text = require "widgets/text"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local ImageButton = require "widgets/imagebutton"
local MushaSkillTreeWidget = require "widgets/mushaskilltreewidget"


local function maketabbutton(widget, pos, text, clickfn, imagename, textoffset, flip)
	local button = widget:AddChild(ImageButton("images/skilltree.xml",
		"tab_skills_unselected.tex", -- normal
		"tab_skills_unselected.tex", -- focus
		"tab_skills_over.tex", -- disabled
		"tab_skills_unselected.tex", -- down
		"tab_skills_over.tex"  -- selected
	))

	local size = { 142, 96 }

	if flip then
		size[1] = size[1] * -1
	end

	button:SetPosition(pos[1], pos[2])
	button:ForceImageSize(size[1], size[2])
	button:SetText(text)
	button:SetTextSize(20)
	button:SetFont(HEADERFONT)
	button:SetDisabledFont(HEADERFONT)
	button:SetTextColour(UICOLOURS.GOLD)
	button.scale_on_focus = false

	button.clickoffset = Vector3(0, 5, 0)
	button:SetTextFocusColour(UICOLOURS.GOLD)
	button:SetTextSelectedColour(UICOLOURS.GOLD)
	button:SetTextDisabledColour(UICOLOURS.GOLD)
	button.text:SetPosition(textoffset[1], textoffset[2])
	button:SetOnClick(function()
		clickfn()
	end)

	return button
end

local function MakeMushaSkillTree(self, tree_name, from_sidebar)
	if self.playeravatar then
		self.playeravatar:Kill()
		self.playeravatar = nil
	end

	if self.skilltree then
		self.skilltree:Kill()
		self.skilltree = nil
	end

	self.skilltree = self.root:AddChild(MushaSkillTreeWidget(tree_name, self.data, nil, {owner = self.owner}))

	if self.root.tabs then
		if not from_sidebar then
			self.root.tabs.skillTreePopup:Disable()
		else
			self.root.tabs.skillTreePopup:Enable()
		end
		self.root.tabs.playerAvatarPopup:Enable()
		self.root.tabs.controller = self.MakePlayerAvatarPopup
	end

	if TheInput:ControllerAttached() then
		self.skilltree.default_focus:SetFocus()
	end
end

local function SelectSideButton(self, buttonwidget)
	for _, child in pairs(self.root.sidebuttons.children) do
		child.selectimg:Hide()
	end
	if buttonwidget then
		buttonwidget.selectimg:Show()
	end
end

local function MakeSideBar(self)
	self.root.sidebuttons = self.root:AddChild(Widget("sidebuttons"))

	-- local colors = {
	-- 	{ 114 / 255, 56 / 255, 56 / 255 },
	-- 	{ 111 / 255, 85 / 255, 47 / 255 },
	-- 	{ 137 / 255, 126 / 255, 89 / 255 },
	-- 	{ 95 / 255, 123 / 255, 87 / 255 },
	-- 	{ 113 / 255, 127 / 255, 126 / 255 },
	-- 	{ 74 / 255, 84 / 255, 99 / 255 },
	-- 	{ 79 / 255, 73 / 255, 107 / 255 },
	-- }

	local buttons = {
		{ name = "princess", color = { 95 / 255, 123 / 255, 87 / 255 } },
		{ name = "valkyrie", color = { 105 / 255, 84 / 255, 150 / 255 } },
		{ name = "shadow",   color = { 114 / 255, 56 / 255, 56 / 255 } },
	}

	local buttonwidth = 252 / 2.2
	local buttonheight = 112 / 2.2

	local totalheight = 430

	local MakeButton = function(idx, data)
		local y = totalheight / 2 - ((totalheight / 7) * idx - 1)

		local buttonwidget = self.root.sidebuttons:AddChild(Widget())

		local button = buttonwidget:AddChild(ImageButton("images/scrapbook.xml", "tab.tex"))
		button:ForceImageSize(buttonwidth, buttonheight)
		button.scale_on_focus = false
		button.basecolor = { data.color[1], data.color[2], data.color[3] }
		button:SetImageFocusColour(math.min(1, data.color[1] * 1.2), math.min(1, data.color[2] * 1.2),
			math.min(1, data.color[3] * 1.2), 1)
		button:SetImageNormalColour(data.color[1], data.color[2], data.color[3], 1)
		button:SetImageSelectedColour(data.color[1], data.color[2], data.color[3], 1)
		button:SetImageDisabledColour(data.color[1], data.color[2], data.color[3], 1)
		button:SetOnClick(function()
			MakeMushaSkillTree(self, data.name, true)
			SelectSideButton(self, buttonwidget)
		end)

		buttonwidget.focusimg = button:AddChild(Image("images/scrapbook.xml", "tab_over.tex"))
		buttonwidget.focusimg:ScaleToSize(buttonwidth, buttonheight)
		buttonwidget.focusimg:SetClickable(false)
		buttonwidget.focusimg:Hide()

		buttonwidget.selectimg = button:AddChild(Image("images/scrapbook.xml", "tab_selected.tex"))
		buttonwidget.selectimg:ScaleToSize(buttonwidth, buttonheight)
		buttonwidget.selectimg:SetClickable(false)
		buttonwidget.selectimg:Hide()

		buttonwidget:SetOnGainFocus(function()
			buttonwidget.focusimg:Show()
		end)
		buttonwidget:SetOnLoseFocus(function()
			buttonwidget.focusimg:Hide()
		end)

		local text = button:AddChild(Text(HEADERFONT, 20, STRINGS.musha.skilltrees[data.name].name,
			UICOLOURS.WHITE))
		text:SetPosition(10, -8)

		buttonwidget:SetPosition(275 + buttonwidth / 2, y)
	end

	for i, data in ipairs(buttons) do
		MakeButton(i, data)
	end
end

local function MakeMushaTabs(self)
	self.root.tabs = self.root:AddChild(Widget("tabs"))
	self.root.tabs:SetPosition(0, 0)

	self.root.tabs.playerAvatarPopup = maketabbutton(self.root.tabs, { -165, 220 },
		string.upper(STRINGS.SKILLTREE.INFOPANEL), function()
			self:MakePlayerAvatarPopup()
			SelectSideButton(self)
		end, "skins",
		{ 2, -5 }, true)
	self.root.tabs.skillTreePopup = maketabbutton(self.root.tabs, { 165, 220 },
		string.upper(STRINGS.SKILLTREE.SKILLTREE),
		function()
			MakeMushaSkillTree(self, "general")
			SelectSideButton(self)
		end, "skills",
		{ -2, -5 })
end

local function ClassPostConstructFn(self)
	-- Only show skill tree on self-inspection
	if self.currentcharacter == "musha" and not self.show_net_profile then
		MakeMushaTabs(self)
		MakeSideBar(self)

		-- Reset bg layer
		self.root.playerbg:Kill()
		self.bg_scratches:Kill()
		self:MakeBG()

		MakeMushaSkillTree(self, "general")
	end
end

AddClassPostConstruct("screens/playerinfopopupscreen", ClassPostConstructFn)
