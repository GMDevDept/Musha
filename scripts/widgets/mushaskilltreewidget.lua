local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"
local Widget = require "widgets/widget"
local Text = require "widgets/text"
local TEMPLATES = require "widgets/redux/templates"
local skilltreedefs = require "prefabs/skilltree_defs_musha"
local mushaskilltreebuilder = require "widgets/mushaskilltreebuilder"
local UIAnim = require "widgets/uianim"

require("util")

-------------------------------------------------------------------------------------------------------
local MushaSkillTreeWidget = Class(Widget, function(self, category, targetdata, fromfrontend, data)
    Widget._ctor(self, "MushaSkillTreeWidget")

    self.owner = data.owner
    self.fromfrontend = fromfrontend -- always nil
    self.targetdata = targetdata

    self.target = category

    self.root = self:AddChild(Widget("root"))

    self.midlay = self.root:AddChild(Widget())

    -- self.bg_tree = self.root:AddChild(Image(GetSkilltreeBG(self.target.."_background.tex"), self.target.."_background.tex"))
    -- self.bg_tree:SetPosition(2,-20)
    -- self.bg_tree:ScaleToSize(600, 460)

    -- if self.fromfrontend then
    --     local color = UICOLOURS.GOLD
    --     self.bg_tree:SetTint(color[1],color[2],color[3],0.6)
    -- else
    --     local color = UICOLOURS.BLACK
    --     self.bg_tree:SetTint(color[1],color[2],color[3],1)
    -- end

    self.root.infopanel = self.root:AddChild(Widget("infopanel"))
    self.root.infopanel:SetPosition(0, -148)

    self.root.infopanel.bg = self.root.infopanel:AddChild(Image("images/skilltree.xml", "wilson_background_text.tex"))
    self.root.infopanel.bg:ScaleToSize(470, 130)
    self.root.infopanel.bg:SetPosition(0, -10)

    self.root.infopanel.activatedbg = self.root.infopanel:AddChild(Image("images/skilltree.xml",
        "skilltree_backgroundart.tex"))
    self.root.infopanel.activatedbg:ScaleToSize(470 / 2.4, 156 / 3) -- 196 , 52
    self.root.infopanel.activatedbg:SetPosition(0, -58)

    self.root.infopanel.activatedtext = self.root.infopanel:AddChild(Text(HEADERFONT, 18, STRINGS.SKILLTREE.ACTIVATED,
        UICOLOURS.BLACK))
    self.root.infopanel.activatedtext:SetPosition(0, -62)
    self.root.infopanel.activatedtext:SetSize(20)

    self.root.infopanel.activatebutton = self.root.infopanel:AddChild(ImageButton("images/global_redux.xml",
        "button_carny_long_normal.tex", "button_carny_long_hover.tex", "button_carny_long_disabled.tex",
        "button_carny_long_down.tex"))
    self.root.infopanel.activatebutton.image:SetScale(1)
    self.root.infopanel.activatebutton:SetFont(CHATFONT)
    self.root.infopanel.activatebutton:SetPosition(0, -61)
    self.root.infopanel.activatebutton.text:SetColour(0, 0, 0, 1)
    self.root.infopanel.activatebutton:SetScale(0.5)
    self.root.infopanel.activatebutton:SetText(STRINGS.SKILLTREE.ACTIVATE)

    self.root.infopanel.title = self.root.infopanel:AddChild(Text(HEADERFONT, 18, "title", UICOLOURS.BROWN_DARK))
    self.root.infopanel.title:SetPosition(0, 28)
    self.root.infopanel.title:SetVAlign(ANCHOR_TOP)

    self.root.infopanel.desc = self.root.infopanel:AddChild(Text(CHATFONT, 16, "desc", UICOLOURS.BROWN_DARK))
    self.root.infopanel.desc:SetPosition(0, -8)
    self.root.infopanel.desc:SetHAlign(ANCHOR_LEFT)
    self.root.infopanel.desc:SetVAlign(ANCHOR_TOP)
    self.root.infopanel.desc:SetMultilineTruncatedString(STRINGS.SKILLTREE.INFOPANEL_DESC, 3, 400, nil, nil, true, 6)
    self.root.infopanel.desc:Hide()

    self.root.infopanel.intro = self.root.infopanel:AddChild(Text(CHATFONT, 18, "desc", UICOLOURS.BROWN_DARK))
    self.root.infopanel.intro:SetPosition(0, -10)
    self.root.infopanel.intro:SetHAlign(ANCHOR_LEFT)
    self.root.infopanel.intro:SetString(STRINGS.SKILLTREE.INFOPANEL_DESC)

    self.root.tree = self.root:AddChild(mushaskilltreebuilder(self.root.infopanel, self.fromfrontend, self))
    self.root.tree:SetPosition(0, -50)

    if not self.fromfrontend then
        self.root.scroll_left = self.root:AddChild(Image("images/skilltree2.xml", "overlay_left.tex"))
        self.root.scroll_left:ScaleToSize(44, 460)
        self.root.scroll_left:SetPosition(-278, -20)
        self.root.scroll_right = self.root:AddChild(Image("images/skilltree2.xml", "overlay_right.tex"))
        self.root.scroll_right:ScaleToSize(44, 460)
        self.root.scroll_right:SetPosition(278, -20)
    end

    self.readonly = ThePlayer and self.targetdata.userid ~= ThePlayer.userid -- Always false
    if not self.readonly then
        if ThePlayer then
            ThePlayer.new_skill_available_popup = nil
            ThePlayer:PushEvent("newskillpointupdated")
        end
    end

    self.root.tree:CreateTree(self.target, self.targetdata, self.readonly)

    if self.root.tree then
        self.root.tree:SetFocusChangeDirs()
        self.default_focus = self.root.tree:GetDefaultFocus()
    end
    self:SpawnFavorOverlay()
end)

function MushaSkillTreeWidget:SpawnFavorOverlay(pre)
    if not self.fromfrontend and (self.midlay ~= nil and self.midlay.splash == nil) then
        local favor, activatedskills, characterprefab

        characterprefab = self.target
        activatedskills = self.owner.replica.mushaskilltree:GetActivatedSkills()

        if skilltreedefs.FN.CountTags(characterprefab, "shadow_favor", activatedskills) > 0 then
            favor = "skills_shadow"
        elseif skilltreedefs.FN.CountTags(characterprefab, "lunar_favor", activatedskills) > 0 then
            favor = "skills_lunar"
        end

        if favor then
            self.midlay.splash = self.midlay:AddChild(UIAnim())
            self.midlay.splash:GetAnimState():SetBuild(favor)
            self.midlay.splash:GetAnimState():SetBank(favor)
            if favor == "skills_lunar" then
                self.midlay.splash:GetAnimState():SetMultColour(0.7, 0.7, 0.7, 0.7)
                self.midlay.splash:SetPosition(0, -10)
            end
            if pre then
                local sound = "wilson_rework/ui/shadow_skill"

                if favor == "skills_lunar" then
                    sound = "wilson_rework/ui/lunar_skill"
                end

                TheFrontEnd:GetSound():PlaySound(sound)
                self.midlay.splash:GetAnimState():PlayAnimation("pre", false)
                self.midlay.splash:GetAnimState():PushAnimation("idle", false)
            else
                self.midlay.splash:GetAnimState():PlayAnimation("idle", false)
            end

            self.midlay.splash.inst:ListenForEvent("animover", function()
                local chance = 0.3
                if favor == "skills_lunar" then
                    chance = 0.05
                end
                if math.random() < chance then
                    self.midlay.splash:GetAnimState():PlayAnimation("twitch", false)
                    self.midlay.splash:GetAnimState():PushAnimation("idle", false)
                else
                    self.midlay.splash:GetAnimState():PlayAnimation("idle", false)
                end
            end)
        end
    end
end

function MushaSkillTreeWidget:Kill()
    --ThePlantRegistry:Save() -- for saving filter settings
    MushaSkillTreeWidget._base.Kill(self)
end

function MushaSkillTreeWidget:OnControl(control, down)
    if MushaSkillTreeWidget._base.OnControl(self, control, down) then return true end

    if not down and not TheInput:ControllerAttached() and control == CONTROL_ACTION then
        local skilltree = self.root.tree

        if not skilltree.selectedskill or
            not skilltree.skillgraphics[skilltree.selectedskill].status.activatable or
            not skilltree.infopanel.activatebutton:IsVisible()
        then
            return false
        end

        self.root.infopanel.activatebutton.onclick()

        return true
    end

    return false
end

function MushaSkillTreeWidget:GetSelectedSkill()
    return self.root.tree:GetSelectedSkill()
end

return MushaSkillTreeWidget
