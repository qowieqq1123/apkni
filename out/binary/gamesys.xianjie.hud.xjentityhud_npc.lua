









local xjEntityHud_npc={}
local abname="ui/windows/xianjie/xianjietask_atlas_pak.ab"

function xjEntityHud_npc:onInit()
self.needFollow=true

self.uiOffset={Vector2(0,0),}
local data=self.data
self.npcid=data[1]

end


function xjEntityHud_npc:onCreateWidget(widget)

widget:SetChildButtonClick(2,function()
self:onClick()
end)
widget:SetChildButtonClick(4,function()
self:onClick()
end)

local npcData=xianjieModel:getNPCData(self.npcid)
self:refreshInfo()



end


function xjEntityHud_npc:onRemoveWidget(widget)

end

function xjEntityHud_npc:refreshInfo()
local widget=self:getWidget()
if widget then



local npcData=xianjieModel:getNPCData(self.npcid)
local npccfg=npcData:getCfg()
local stageimage,type,needgray=taskModel:GetNPCStage(self.npcid)
if npccfg.duidie_index then
widget:SetChildWeakGuideComponentId(-1,FMT.fmt('xjEntityHud_npc.duidie_index{0}',npccfg.duidie_index))
local npclist=taskModel:GetHighLvByduidieIndex(npccfg.duidie_index)
if#npclist>1 then
local abName="ui/windows/xiangong/xiangong_atlas_pak.ab"
widget:SetChildCSImageSprite(6,abName,'icon_xiangongdizi_1')
widget:SetChildText(1,"一众仙家")

local npclist=taskModel:GetHighLvByduidieIndex(npccfg.duidie_index)
local npcdata=npclist[1][2]
local npcid=npcdata.id
stageimage,type,needgray=taskModel:GetNPCStage(npcid)
else
widget:SetChildIcon(6,npccfg.headimage,false)
widget:SetChildScale(6,Vector3(1.1,1.1,1.1))
widget:SetChildText(1,npccfg.name)
end
else
widget:SetChildWeakGuideComponentId(-1,FMT.fmt('xjEntityHud_npc.item{0}',self.npcid))
widget:SetChildIcon(6,npccfg.headimage,false)
widget:SetChildScale(6,Vector3(1.1,1.1,1.1))
widget:SetChildText(1,npccfg.name)
end

if type==4 then

local cfg=taskModel:getTaskNPCConfig(self.npcid)
local talkday_treeid=cfg.talkday_treeid
if not talkday_treeid then
stageimage=nil
end
end
if stageimage then
widget:SetChildActive(4,true)
widget:SetChildActive(5,true)

if api_Available_SetChildCSImage()then
widget:SetChildCSImage(4,abname,NPCstageimage[type].qipao,true)
widget:SetChildCSImage(5,abname,stageimage,true)
widget:SetChildGray(4,needgray)
widget:SetChildGray(5,needgray)
else
widget:SetChildCSImageSprite(4,abname,NPCstageimage[type].qipao)
widget:SetChildCSImageSprite(5,abname,stageimage)
widget:SetChildGray(4,needgray)
widget:SetChildGray(5,needgray)
end
else
widget:SetChildActive(4,false)
widget:SetChildActive(5,false)
end
end
end

function xjEntityHud_npc:onClick()
if not self:checkWidget()then return end


local npcdata=taskModel:getTaskNPCConfig(self.npcid)
if npcdata.duidie_index then
local npclist=taskModel:GetHighLvByduidieIndex(npcdata.duidie_index)
if#npclist>1 then
UIManager:showWindow("UIXianJieNPClistWin",{npclist=npclist})
else
taskModel:SetSelectlist(npcdata)
end
else
taskModel:SetSelectlist(npcdata)
end

end


function xjEntityHud_npc:onDelete()

end

return xjEntityHud_npc