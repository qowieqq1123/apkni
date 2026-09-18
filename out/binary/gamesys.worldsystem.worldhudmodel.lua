






local _MODULENAME="worldHUDModel"




def_table(_MODULENAME)
worldHUDModel.name=_MODULENAME
worldHUDModel.data={}

local _monster_hud_name_bg={
[monType.LittleMonster]="frame_tysjmk_7",
[monType.EliteMonster]="frame_tysjmk_7",
[monType.Boss]="frame_tysjmk_6",
[monType.GodAnimal]="frame_tysjmk_6",
}

local _monster_hud_name_color={
[monType.Boss]=FONT_COLOR.eNomalBlackColor,
[monType.GodAnimal]=FONT_COLOR.eNomalBlackColor,
}

local _this=worldHUDModel
local _interruptMode=false
local _interruptList={}


function worldHUDModel:onAppStart()

end


function worldHUDModel:onEnterState()

end


function worldHUDModel:onLeaveState()


_interruptMode=false
_interruptList={}
end


function worldHUDModel:onServerDataInitFinish()

end




function worldHUDModel:containHUD(key)
return self:getHUD(key)~=nil
end




function worldHUDModel:getHUD(key)
return self.data[key]
end




function worldHUDModel:setHUD(key,hudHandle)
self.data[key]=hudHandle
end



function worldHUDModel:deleteHUD(key)
self.data[key]=nil
end


function worldHUDModel:clearAllHUD()
self.data={}
end






function worldHUDModel.onHUDCreate(key,cmp,script,data)
local info={key=key,cmp=cmp,data=data,script=script}

if worldHUDModel:containHUD(info.key)then

end

if not worldController:isInWorld()then



return
end

local handleName=info.script or"worldHUDBase"
local handle=_G[handleName]
local hudData=handle.New(info)

worldHUDModel:setHUD(info.key,hudData)
hudData:onCreate()
worldHUDModel:addInterruptHUD(key,cmp,data)
end



function worldHUDModel.onHUDDestory(key)
local hudData=worldHUDModel:getHUD(key)

if hudData then
hudData:onDestory()
worldHUDModel:deleteHUD(key)
worldHUDModel:removeInterruptHUD(key)

else

end
end





function worldHUDModel.onHUDFlipX(key,cmp,flip)

local hudData=worldHUDModel:getHUD(key)
if hudData then
hudData:onFlipX(flip)
else

end
end



function worldHUDModel:UpdateHUDByKey(key)

local hud=self:getHUD(key)
if hud then
hud:onUpdate()
end
end



function worldHUDModel:onUpdateHUD(key)
local hud=self:getHUD(key)
if hud then
hud:onUpdate()
else

end
end

function worldHUDModel:dropItem(key,num,rewards,callback)
local hud=self:getHUD(key)
if hud and hud.dropItem then
local info=cfgHelper.get2(cfg_worldglobalconfig_get,"resPointDropEffect","value")
hud:dropItem(num,rewards,info[2],info[1],callback)
else

end
end

function worldHUDModel:getMonsterHUDNameBg(monType)
return _monster_hud_name_bg[monType]
end

function worldHUDModel:getMonsterHUDNameColor(monType)
return _monster_hud_name_color[monType]
end

function worldHUDModel:callHUDFunc(unitKey,funcName,...)
local hud=self:getHUD(unitKey)

if hud and hud[funcName]then
hud[funcName](hud,...)
else

end
end

function worldHUDModel:setHUDVisible(visible)
for i,v in pairs(self.data)do
v:onVisible(visible)
end
end

function worldHUDModel:beginInterruptModel()
_interruptMode=true
for i,v in pairs(self.data)do
self:addInterruptHUD(v.key,v.cmp,v.data)
end
end

function worldHUDModel:endInterruptModel()
for i,v in pairs(_interruptList)do
self:removeInterruptHUD(i)
end
_interruptMode=false
end

function worldHUDModel:addInterruptHUD(key,cmp,data)
if not _interruptMode then return end
if _interruptList[key]then
UIManager.error(FMT.fmt("重复阻断HUD显示 {0}",key))
return
end
if data[1]~=nil and table.containsValue(eWorldUnitTpye,data[1])then
cmp:SetChildActive(-1,false)
_interruptList[key]=cmp
end
end

function worldHUDModel:removeInterruptHUD(key)
if not _interruptMode then return end
local cmp=_interruptList[key]
if cmp then
cmp:SetChildActive(-1,true)
_interruptList[key]=nil
end
end
