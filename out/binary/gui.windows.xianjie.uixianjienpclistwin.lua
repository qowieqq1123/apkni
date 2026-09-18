







def_class("UIXianJieNPClistWin",UIWindowBase)









function UIXianJieNPClistWin:bindComponents()

self.chooseGrid=UIObject.get(self,0)
self.chooseView=UIObject.get(self,1)
self.listbg=UIButton.get(self,2)
self.listroot=UIObject.get(self,3)

self.listbg:setButtonClick(function()self:onListbg()end)



end


function UIXianJieNPClistWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.chooseGrid);self.chooseGrid=nil;
_UIObject_release(self.chooseView);self.chooseView=nil;
_UIObject_release(self.listbg);self.listbg=nil;
_UIObject_release(self.listroot);self.listroot=nil;
end



















local listcmp=
{
item=0,
headicon=1,
name=2,
stageicon=3,
button=4,
buttontext=5,
sign=6,
qipao=7,
qipaosign=8,
}

function UIXianJieNPClistWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieNPClistWin:__delete()
self:unbindComponents()
end
local abname="ui/windows/xianjie/xianjietask_atlas_pak.ab"



function UIXianJieNPClistWin:onShow(argtable,afterOnloaded)
local npclist=argtable.npclist
self.chooseView:setChildScrollViewCreateGrids(#npclist,1)
local grid=self.chooseView:getChildScrollViewItemWidgets()
for i=1,#npclist do
local npcdata=npclist[i][2]
local npcid=npcdata.id
local item=grid[i-1]
local hightask=npclist[i][1]
local npccfg=taskModel:getTaskNPCConfig(npcid)

item:SetChildText(listcmp.buttontext,npccfg.listbtn_text)
item:SetChildIcon(listcmp.headicon,npcdata.headimage,false)

item:SetChildButtonClick(listcmp.button,function()
self:onTalkBtn(npcdata)
end)

item:SetChildText(listcmp.name,npcdata.name)

local stageimage,type,needgray=taskModel:GetNPCStage(npcid)
if type==4 then

local cfg=taskModel:getTaskNPCConfig(npcid)
local talkday_treeid=cfg.talkday_treeid
if not talkday_treeid then
stageimage=nil
end
end
item:SetChildActive(listcmp.qipaosign,false)
item:SetChildActive(listcmp.qipao,false)
if stageimage then
item:SetChildActive(listcmp.qipaosign,true)
item:SetChildActive(listcmp.qipao,true)

if api_Available_SetChildCSImage()then
item:SetChildCSImage(listcmp.qipao,abname,NPCstageimage[type].qipao,true)
item:SetChildCSImage(listcmp.qipaosign,abname,stageimage,true)
item:SetChildGray(listcmp.qipao,needgray)
item:SetChildGray(listcmp.qipaosign,needgray)
else
item:SetChildCSImageSprite(listcmp.qipao,abname,NPCstageimage[type].qipao)
item:SetChildCSImageSprite(listcmp.qipaosign,abname,stageimage)
item:SetChildGray(listcmp.qipao,needgray)
item:SetChildGray(listcmp.qipaosign,needgray)
end
end


local cfg=hightask.cfg
item:SetChildActive(listcmp.sign,false)
if cfg then
local tasklineid=cfg.tasklineid
local iszhuizong=taskModel:isZhuiZongTask(tasklineid)
local type=0

if iszhuizong then
type=5
elseif tasklineid==1 then
type=1
elseif cfg.xianjietype and cfg.xianjietype==1 then
type=2
end

local signimage,abname_type=taskModel:GettaskTypeSign(type)
if signimage then
item:SetChildActive(listcmp.sign,true)
item:SetChildCSImageSprite(listcmp.sign,abname_type,signimage)
end
end
end
end


function UIXianJieNPClistWin:onHide()

end
function UIXianJieNPClistWin:onTalkBtn(npcdata)

taskModel:SetSelectlist(npcdata)
end





function UIXianJieNPClistWin:onListbg()
self:closeSelf()
end

