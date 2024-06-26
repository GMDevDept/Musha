local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"
local Widget = require "widgets/widget"
local Text = require "widgets/text"
local skilltreedefs = require "prefabs/skilltree_defs_musha"
local UIAnim = require "widgets/uianim"

require("util")

local TILESIZE = 32
local TILESIZE_FRAME = 40
local SPACE = 5

local ATLAS = "images/skilltree.xml"
local IMAGE_LOCKED = "locked.tex"
local IMAGE_LOCKED_OVER = "locked_over.tex"
local IMAGE_UNLOCKED = "unlocked.tex"
local IMAGE_UNLOCKED_OVER = "unlocked_over.tex"

local IMAGE_QUESTION = "question.tex"
local IMAGE_QUESTION_OVER = "question_over.tex"

local IMAGE_SELECTED = "selected.tex"
local IMAGE_SELECTED_OVER = "selected_over.tex"
local IMAGE_UNSELECTED = "unselected.tex"
local IMAGE_UNSELECTED_OVER = "unselected_over.tex"
local IMAGE_SELECTABLE = "selectable.tex"
local IMAGE_SELECTABLE_OVER = "selectable_over.tex"
local IMAGE_FRAME = "frame.tex"
local IMAGE_FRAME_LOCK = "frame_octagon.tex"

local function getSizeOfList(list)
    local size = 0
    for i, entry in pairs(list) do
        size = size + 1
    end
    return size
end

local TILEUNIT = 37

-------------------------------------------------------------------------------------------------------
local SkillTreeBuilder = Class(Widget, function(self, infopanel, fromfrontend, skilltreewidget)
    Widget._ctor(self, "SkillTreeBuilder")

    self.owner = skilltreewidget.owner
    self.skilltreewidget = skilltreewidget
    self.fromfrontend = fromfrontend
    self.skilltreedef = nil
    self.skillgraphics = {}
    self.buttongrid = {}
    self.infopanel = infopanel
    self.selectedskill = nil
    self.root = self:AddChild(Widget("root"))
    self.root.panels = {}

    self.root.xp = self.root:AddChild(Widget("xp"))
    self.root.xp:SetPosition(40, 215)

    local COLOR = UICOLOURS.BLACK

    self.root.xpicon = self.root.xp:AddChild(Image("images/skilltree.xml", "skill_icon_textbox_white.tex"))
    self.root.xpicon:SetPosition(0, 0)
    self.root.xpicon:ScaleToSize(50, 50)
    self.root.xpicon:SetTint(COLOR[1], COLOR[2], COLOR[3], 1)

    self.root.xptotal = self.root.xp:AddChild(Text(HEADERFONT, 20, 0, COLOR))
    self.root.xptotal:SetPosition(0, -4)

    self.root.xp_tospend = self.root.xp:AddChild(Text(HEADERFONT, 15, 0, COLOR))
    self.root.xp_tospend:SetHAlign(ANCHOR_LEFT)
    self.root.xp_tospend:SetString(STRINGS.SKILLTREE.SKILLPOINTS_TO_SPEND)
    local w, h = self.root.xp_tospend:GetRegionSize()
    self.root.xp_tospend:SetPosition(30 + (w / 2), -3)

    self.root.leveler = self.root:AddChild(Widget("leveler"))
    self.root.leveler:SetPosition(-30, 215)

    self.root.levelicon = self.root.leveler:AddChild(Image("images/skilltree.xml", "skill_icon_textbox_white.tex"))
    self.root.levelicon:SetPosition(0, 0)
    self.root.levelicon:ScaleToSize(50, 50)
    self.root.levelicon:SetTint(COLOR[1], COLOR[2], COLOR[3], 1)

    self.root.level = self.root.leveler:AddChild(Text(HEADERFONT, 20, 0, COLOR))
    self.root.level:SetPosition(0, -4)
    self.root.level:SetString(self.owner.replica.leveler:GetLevel())

    self.root.leveltext = self.root.leveler:AddChild(Text(HEADERFONT, 15, 0, COLOR))
    self.root.leveltext:SetHAlign(ANCHOR_RIGHT)
    self.root.leveltext:SetString(STRINGS.musha.currentlevel)
    self.root.leveltext:SetPosition(-30 - (w / 2), -3)
end)


function SkillTreeBuilder:countcols(cols, data)
    for i, branch in pairs(data) do
        local size = getSizeOfList(branch)
        if size > 0 then
            cols = cols + (size - 1)
            cols = self:countcols(cols, branch)
        end
    end
    return cols
end

function SkillTreeBuilder:GetDefaultFocus()
    -- find the lowest x and y
    local current = math.huge
    local list = {}
    for i, data in ipairs(self.buttongrid) do
        if data.x < current then
            current = data.x
            list = {}
            table.insert(list, data)
        elseif data.x == current then
            table.insert(list, data)
        end
    end
    local current = -math.huge
    local newlist = {}
    for i, data in ipairs(list) do
        if data.y > current then
            current = data.y
            newlist = {}
            table.insert(newlist, data)
        elseif data.y == current then
            table.insert(newlist, data)
        end
    end

    if #newlist > 0 then
        return newlist[1].button
    end
end

function SkillTreeBuilder:SetFocusChangeDirs()
    local function getButton(current, fn)
        local list = {}
        for i, data in ipairs(self.buttongrid) do
            if fn(current, data) and current ~= data then
                table.insert(list, data)
            end
        end
        local choice = nil
        local currentdist = math.huge
        if #list > 0 then
            for i = #list, 1, -1 do
                local xdiff = math.abs(list[i].x - current.x)
                local ydiff = math.abs(list[i].y - current.y)
                local dist = (xdiff * xdiff) + (ydiff * ydiff)

                if dist < currentdist then
                    choice = list[i]
                    currentdist = dist
                end
            end
        end

        return choice and choice.button or nil
    end

    --find the button absolute positions relative to the skill tree widget
    for i, data in ipairs(self.buttongrid) do
        data.x = data.x + data.button.parent:GetPosition().x
        data.y = data.y + data.button.parent:GetPosition().y
    end

    for i, data in ipairs(self.buttongrid) do
        local up = getButton(data, function(a, b) return b.y > a.y and math.abs(b.x - a.x) <= TILEUNIT / 0.5 end)
        if up then data.button:SetFocusChangeDir(MOVE_UP, up) end

        local down = getButton(data, function(a, b) return b.y < a.y and math.abs(b.x - a.x) <= TILEUNIT / 0.5 end)
        if down then data.button:SetFocusChangeDir(MOVE_DOWN, down) end

        local left = getButton(data, function(a, b) return b.x < a.x and math.abs(b.y - a.y) <= TILEUNIT / 0.5 end)
        if left then data.button:SetFocusChangeDir(MOVE_LEFT, left) end

        local right = getButton(data, function(a, b) return b.x > a.x and math.abs(b.y - a.y) <= TILEUNIT / 0.5 end)
        if right then data.button:SetFocusChangeDir(MOVE_RIGHT, right) end
    end
end

function SkillTreeBuilder:buildbuttons(panel, pos, data, offset)
    for skill, subdata in pairs(data) do
        local skillbutton = nil
        local skillicon = nil
        local skillimage = nil

        skillbutton = self:AddChild(ImageButton(ATLAS, IMAGE_SELECTED, IMAGE_SELECTED, IMAGE_SELECTED, IMAGE_SELECTED,
            IMAGE_SELECTED))
        skillbutton:ForceImageSize(TILESIZE, TILESIZE)
        skillbutton:Hide()
        skillbutton:SetOnGainFocus(function()
            if TheInput:ControllerAttached() then
                self.selectedskill = skill
                self:RefreshTree()
            end
        end)

        skillbutton:SetOnClick(function()
            if TheInput:ControllerAttached() then
                if not self.selectedskill or not self.skillgraphics[self.selectedskill].status.activatable or not self.infopanel.activatebutton:IsVisible() then
                    return
                end

                if self.skilltreedef[self.selectedskill].unlocklevel and self.skilltreedef[self.selectedskill].unlocklevel > self.owner.replica.leveler:GetLevel() then
                    return
                end

                local skilltreeupdater = ThePlayer and ThePlayer.replica.mushaskilltree or nil

                self:LearnSkill(skilltreeupdater, self.target)
            else
                self.selectedskill = skill
                self:RefreshTree()
            end
        end)

        if subdata.icon then
            local tex = subdata.icon .. ".tex"
            skillicon = skillbutton:AddChild(Image(GetSkilltreeIconAtlas(tex), tex))
            skillicon:ScaleToSize(TILESIZE - 4, TILESIZE - 4)
            skillicon:MoveToFront()
        end

        local frame = IMAGE_FRAME
        if subdata.lock_open then
            frame = IMAGE_FRAME_LOCK
        end
        skillimage = self:AddChild(Image(ATLAS, frame))
        skillimage:ScaleToSize(TILESIZE_FRAME, TILESIZE_FRAME)
        skillimage:Hide()

        local newpos = Vector3(subdata.pos[1], subdata.pos[2] + offset, 0)
        skillbutton:SetPosition(newpos.x, newpos.y)
        skillimage:SetPosition(newpos.x, newpos.y)

        self.skillgraphics[skill] = {}
        self.skillgraphics[skill].button = skillbutton
        self.skillgraphics[skill].frame = skillimage
        table.insert(self.buttongrid, { button = skillbutton, x = newpos.x, y = newpos.y })
    end
end

local function getMax(data, index)
    local max = 0
    for skillname, skilldata in pairs(data) do
        if math.abs(skilldata.pos[index]) > max then
            max = math.abs(skilldata.pos[index])
        end
    end
    return max + 1
end

function SkillTreeBuilder:CreatePanel(data, offset)
    local panel = self:AddChild(Widget(data.name))
    self.root.panels[data.name] = panel
    panel.title  = self:AddChild(Text(HEADERFONT, 18, STRINGS.SKILLTREE.PANELS[string.upper(panel.name)],
        UICOLOURS.GOLD))

    local maxcols = getMax(data.data, 1)
    local maxrows = getMax(data.data, 2)

    self:buildbuttons(panel, { x = 0, y = 0 }, data.data, offset)

    panel.c_width = maxcols * TILESIZE + ((maxcols - 1) * SPACE)

    local function getPOS()
        for i, namedata in ipairs(skilltreedefs.SKILLTREE_ORDERS[self.target]) do
            if namedata[1] == data.name then
                return namedata[2]
            end
        end
    end
    panel.title:SetPosition(getPOS()[1], getPOS()[2] + offset)

    panel.c_height = maxrows * TILESIZE + ((maxrows - 1) * SPACE)

    return panel
end

local function createtreetable(skilltreedef)
    local tree = {}

    for skillname, skilldata in pairs(skilltreedef) do
        if not tree[skilldata.group] then
            tree[skilldata.group] = {}
        end

        tree[skilldata.group][skillname] = skilldata
    end

    return tree
end

---------------------------------------------------------------

local function gettitle(skill, category, skillgraphics)
    local skilldata = skilltreedefs.SKILLTREE_DEFS[category][skill]
    if skilldata.lock_open then
        local lockstatus = skillgraphics[skill].status.lock_open
        if lockstatus then
            if lockstatus == "question" then
                return STRINGS.SKILLTREE.UNKNOWN
            else
                return STRINGS.SKILLTREE.UNLOCKED
            end
        else
            return STRINGS.SKILLTREE.LOCKED
        end
    else
        return skilldata.title
    end
end

local function getdesc(skill, category)
    local skilldata = skilltreedefs.SKILLTREE_DEFS[category][skill]
    return skilldata.desc
end

function SkillTreeBuilder:RefreshTree()
    local category = self.target
    local readonly = self.readonly
    local skilltreeupdater = ThePlayer and ThePlayer.replica.mushaskilltree or nil

    if skilltreeupdater == nil then
        print("Weird state for skilltreebuilder missing skilltreeupdater component?")
        return -- FIXME(JBK): See if this panel should disappear at this time?
    end

    local availableskillpoints = skilltreeupdater:GetAvailableSkillXP()
    local activatedskills = skilltreeupdater:GetActivatedSkills()

    local function make_connected_clickable(skill)
        if self.skilltreedef[skill].connects then
            for i, connected_skill in ipairs(self.skilltreedef[skill].connects) do
                self.skillgraphics[connected_skill].status.activatable = true
            end
        end
    end

    for skill, graphics in pairs(self.skillgraphics) do
        if graphics.status then
            graphics.oldstatus = graphics.status
        end
        graphics.status = {}
    end

    for skill, graphics in pairs(self.skillgraphics) do
        -- ROOT ITEMS ARE ACTIVATABLE
        if self.skilltreedef[skill].root then
            graphics.status.activatable = true
        end
    end

    for skill, graphics in pairs(self.skillgraphics) do
        if readonly then
            if activatedskills[skill] then
                graphics.status.activated = true
                --make_connected_clickable(skill)
            end
            if self.skilltreedef[skill].lock_open then
                graphics.status.lock = true
                local lockstatus = self.skilltreedef[skill].lock_open(category, activatedskills, readonly)
                graphics.status.lock_open = lockstatus
            end
        else
            if self.skilltreedef[skill].lock_open then
                -- MARK LOCKS and ACTIVATE CONNECTED ITEMS WHEN NOT LOCKED
                graphics.status.lock = true
                if self.skilltreedef[skill].lock_open(category, activatedskills, readonly) then
                    graphics.status.lock_open = true
                    make_connected_clickable(skill)
                end
            elseif skilltreeupdater:IsActivated(skill) then
                graphics.status.activated = true
                make_connected_clickable(skill)
            end
        end
    end

    for skill, graphics in pairs(self.skillgraphics) do
        if self.skilltreedef[skill].locks then
            local activatable = true
            for i, lock in ipairs(self.skilltreedef[skill].locks) do
                if not self.skillgraphics[lock].status.lock_open then
                    activatable = false
                    break
                end
            end
            graphics.status.activatable = false
            if activatable then
                graphics.status.activatable = true
            end
        end
    end

    for skill, graphics in pairs(self.skillgraphics) do
        graphics.button:Hide()
        graphics.frame:Hide()

        if self.selectedskill and self.selectedskill == skill and not TheInput:ControllerAttached() then
            graphics.frame:Show()
        end

        if graphics.status.lock then
            graphics.button:SetScale(0.8, 0.8, 1)
            graphics.button:Show()
            if graphics.status.lock_open then
                if graphics.status.lock_open == "question" then
                    graphics.button:SetTextures(ATLAS, IMAGE_QUESTION, IMAGE_QUESTION_OVER, IMAGE_QUESTION,
                        IMAGE_QUESTION, IMAGE_QUESTION)
                else
                    graphics.button:SetTextures(ATLAS, IMAGE_UNLOCKED, IMAGE_UNLOCKED_OVER, IMAGE_UNLOCKED,
                        IMAGE_UNLOCKED, IMAGE_UNLOCKED)
                end


                if graphics.oldstatus and graphics.oldstatus.lock_open == nil then
                    graphics.button:SetTextures(ATLAS, IMAGE_LOCKED, IMAGE_LOCKED_OVER, IMAGE_LOCKED, IMAGE_LOCKED,
                        IMAGE_LOCKED)
                    self.inst:DoTaskInTime(0.5, function()
                        TheFrontEnd:GetSound():PlaySound("wilson_rework/ui/unlock_gatedskill")
                        local pos = graphics.button:GetPosition()
                        local unlockfx = self:AddChild(UIAnim())
                        unlockfx:GetAnimState():SetBuild("skill_unlock")
                        unlockfx:GetAnimState():SetBank("skill_unlock")
                        unlockfx:GetAnimState():PushAnimation("idle")
                        unlockfx:SetPosition(pos.x, pos.y)
                        unlockfx.inst:ListenForEvent("animover", function()
                            unlockfx:Kill()
                        end)
                    end)
                    self.inst:DoTaskInTime(13 / 30, function()
                        graphics.button:SetTextures(ATLAS, IMAGE_UNLOCKED, IMAGE_UNLOCKED_OVER, IMAGE_UNLOCKED,
                            IMAGE_UNLOCKED, IMAGE_UNLOCKED)
                    end)
                end
            else
                graphics.button:SetTextures(ATLAS, IMAGE_LOCKED, IMAGE_LOCKED_OVER, IMAGE_LOCKED, IMAGE_LOCKED,
                    IMAGE_LOCKED)
            end
        elseif graphics.status.activated then
            graphics.button:Show()
            graphics.button:SetTextures(ATLAS, IMAGE_SELECTED, IMAGE_SELECTED_OVER, IMAGE_SELECTED, IMAGE_SELECTED,
                IMAGE_SELECTED)
        elseif graphics.status.activatable and availableskillpoints > 0 then
            graphics.button:Show()
            graphics.button:SetTextures(ATLAS, IMAGE_SELECTABLE, IMAGE_SELECTABLE_OVER, IMAGE_SELECTABLE,
                IMAGE_SELECTABLE, IMAGE_SELECTABLE)
        else
            graphics.button:Show()
            graphics.button:SetTextures(ATLAS, IMAGE_UNSELECTED, IMAGE_UNSELECTED_OVER, IMAGE_UNSELECTED,
                IMAGE_UNSELECTED, IMAGE_UNSELECTED)
        end
    end

    self.root.xp:Show()
    self.root.xptotal:SetString(availableskillpoints)
    if availableskillpoints <= 0 and skilltreeupdater:GetSkillXP() >= skilltreeupdater:GetMaxSkillXP() then
        self.root.xp_tospend:SetString(STRINGS.SKILLTREE.KILLPOINTS_MAXED)
        local w, h = self.root.xp_tospend:GetRegionSize()
        self.root.xp_tospend:SetPosition(30 + (w / 2), -3)
    else
        self.root.xp_tospend:SetString(STRINGS.SKILLTREE.SKILLPOINTS_TO_SPEND)
        local w, h = self.root.xp_tospend:GetRegionSize()
        self.root.xp_tospend:SetPosition(30 + (w / 2), -3)
    end


    if self.selectedskill then
        if TheInput:ControllerAttached() then
            self.skillgraphics[self.selectedskill].button:SetHelpTextMessage("")
        end
    end

    if self.infopanel then
        self.infopanel.title:Hide()
        self.infopanel.unlocklevel:Hide()
        self.infopanel.lack_of_exp:Hide()
        self.infopanel.activatebutton:Hide()
        self.infopanel.activatedtext:Hide()
        self.infopanel.activatedbg:Hide()

        if self.selectedskill then
            self.infopanel.title:Show()
            self.infopanel.title:SetString(gettitle(self.selectedskill, self.target, self.skillgraphics))
            self.infopanel.desc:Show()
            self.infopanel.desc:SetMultilineTruncatedString(getdesc(self.selectedskill, self.target), 3, 400, nil, nil,
                true, 6)
            self.infopanel.unlocklevel:Show()
            self.infopanel.unlocklevel:SetString(STRINGS.musha.unlocklevel .. ": " .. tostring(self.skilltreedef[self.selectedskill].unlocklevel or 0))
            self.infopanel.intro:Hide()

            if self.skilltreedef[self.selectedskill].unlocklevel and self.skilltreedef[self.selectedskill].unlocklevel > self.owner.replica.leveler:GetLevel() then
                self.infopanel.lack_of_exp:Show()
            elseif not readonly then
                if availableskillpoints > 0 and self.skillgraphics[self.selectedskill].status.activatable and not skilltreeupdater:IsActivated(self.selectedskill) and not self.skilltreedef[self.selectedskill].lock_open then
                    self.infopanel.activatedbg:Hide()
                    self.infopanel.activatebutton:Show()
                    self.infopanel.activatebutton:SetOnClick(function()
                        self:LearnSkill(skilltreeupdater, category)
                    end)
                    if TheInput:ControllerAttached() then
                        self.skillgraphics[self.selectedskill].button:SetHelpTextMessage(STRINGS.SKILLTREE.ACTIVATE)
                        self.infopanel.activatebutton:SetText(TheInput:GetLocalizedControl(TheInput:GetControllerID(),
                            self.infopanel.activatebutton.control, false, false) .. " " .. STRINGS.SKILLTREE.ACTIVATE)
                    end
                end
            end

            if self.skillgraphics[self.selectedskill].status.activated then
                self.infopanel.activatedtext:Show()
                self.infopanel.activatedbg:Show()
            end
        else
            self.infopanel.desc:SetMultilineTruncatedString(STRINGS.SKILLTREE.INFOPANEL_DESC, 3, 240, nil, nil, true, 6)
        end
    end
end

function SkillTreeBuilder:LearnSkill(skilltreeupdater, category)
    if self.selectedskill then
        if TheInput:ControllerAttached() and self.skillgraphics[self.selectedskill].status.lock then
            return
        end

        skilltreeupdater:ActivateSkill(self.selectedskill, category)

        TheFrontEnd:GetSound():PlaySound("wilson_rework/ui/skill_mastered") -- wilson_rework/ui/skill_mastered

        local pos = self.skillgraphics[self.selectedskill].button:GetPosition()
        local clickfx = self:AddChild(UIAnim())
        clickfx:GetAnimState():SetBuild("skills_activate")
        clickfx:GetAnimState():SetBank("skills_activate")
        clickfx:GetAnimState():PushAnimation("idle")
        clickfx.inst:ListenForEvent("animover", function() clickfx:Kill() end)
        clickfx:SetPosition(pos.x, pos.y + 15)

        if skilltreedefs.FN.SkillHasTags(self.selectedskill, "shadow", self.target) or skilltreedefs.FN.SkillHasTags(self.selectedskill, "lunar", self.target) then
            self.skilltreewidget:SpawnFavorOverlay(true)
        end
    end
end

function SkillTreeBuilder:CreateTree(category, targetdata, readonly)
    self.skilltreedef = skilltreedefs.SKILLTREE_DEFS[category]
    self.target = category
    self.targetdata = targetdata
    self.readonly = readonly -- Always false

    local treedata = createtreetable(self.skilltreedef)

    for group, skills in pairs(treedata) do
        self:CreatePanel({ name = group, data = skills }, -30)
    end

    local current_x = -260
    local last_width = 0

    for i, paneldata in ipairs(skilltreedefs.SKILLTREE_ORDERS[self.target]) do
        local panel = self.root.panels[paneldata[1]]
        current_x = current_x + last_width + TILESIZE
        last_width = panel.c_width
        panel:SetPosition(current_x, 170)
    end

    self.inst:ListenForEvent("skilltreedirty", function()
        self:RefreshTree()
    end, self.owner.musha_classified)

    self:RefreshTree()
end

function SkillTreeBuilder:GetSelectedSkill()

end

return SkillTreeBuilder
