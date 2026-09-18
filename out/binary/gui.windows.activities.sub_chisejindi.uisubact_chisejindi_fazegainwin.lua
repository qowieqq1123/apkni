







def_class("UISubAct_ChiSeJinDi_FaZeGainWin",UIWindowBase)









function UISubAct_ChiSeJinDi_FaZeGainWin:bindComponents()

self.bagButton=UIButton.get(self,0)
self.chooseButton=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.desc=UIText.get(self,3)
self.descBg=UIObject.get(self,4)
self.discipleBtn=UIButton.get(self,5)
self.listPanel=UIObject.get(self,6)
self.weaponBtn=UIButton.get(self,7)

self.bagButton:setButtonClick(function()self:onBagButton()end)

self.chooseButton:setButtonClick(function()self:onChooseButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.discipleBtn:setButtonClick(function()self:onDiscipleBtn()end)

self.weaponBtn:setButtonClick(function()self:onWeaponBtn()end)



end


function UISubAct_ChiSeJinDi_FaZeGainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bagButton);self.bagButton=nil;
_UIObject_release(self.chooseButton);self.chooseButton=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.descBg);self.descBg=nil;
_UIObject_release(self.discipleBtn);self.discipleBtn=nil;
_UIObject_release(self.listPanel);self.listPanel=nil;
_UIObject_release(self.weaponBtn);self.weaponBtn=nil;
end















local _this=nil


local _itemCmpIndex=
{
name=0,
desc=1,
select=2,
icon=3,
quality=4,
bg=5,
root=6,
zhuanshu=7,
}



local _movePos=
{
{Vector3(0,0,0)},
{Vector3(0,0,0),Vector3(0,0,0)},
{Vector3(10,-30,0),Vector3(0,0,0),Vector3(-10,-30,0)},
}
local _moveStartPos=
{
{Vector3(0,0,0)},
{Vector3(0,0,0),Vector3(0,0,0)},
{Vector3(370,-30,0),Vector3(0,-30,0),Vector3(-370,-30,0)},
}

local _rotateZ=
{
{0},
{0,0},
{5,0,-5},
}



function UISubAct_ChiSeJinDi_FaZeGainWin:onLoaded(...)
self:bindComponents()
_this=self

socketManager:addNotify(249,238,self.on_249_238)

self.tweeners={}
end


function UISubAct_ChiSeJinDi_FaZeGainWin:__delete()
self:unbindComponents()
_this=nil

socketManager:removeNotify(249,238,self.on_249_238)

self.selectIndex=nil

for i,v in pairs(self.tweeners)do
if v:IsActive()then
v:Kill()
end
end
end




function UISubAct_ChiSeJinDi_FaZeGainWin:onShow(argtable,afterOnloaded)

self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.parentWin=argtable.parentWin


self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.copyData=self.info:getCopy()
self.teamData=self.info:getTeam()

self:initView()
end


function UISubAct_ChiSeJinDi_FaZeGainWin:onHide()

end




function UISubAct_ChiSeJinDi_FaZeGainWin:onChooseButton()
if self.selectIndex then
if not self.sended then
call_activitiesHandle_func("activitiesHandle_chisejindi","reqSelectCopyItem",self.actId,self.subId,self.selectIndex)
self.sended=self.selectIndex
end
else
UIManager.error("请先选择其中一个选项")
end
end


function UISubAct_ChiSeJinDi_FaZeGainWin:onBagButton()
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
side=0,
parentWin=self,
}
self:showWindow("UISubAct_ChiSeJinDi_FaZeBagWin",args)
end

function UISubAct_ChiSeJinDi_FaZeGainWin:onDiscipleBtn()
local discipleList=self.copyData.discipleList
self.copyData:sortDiscipleList()
local lookup=self.info:getTeamLookup_Disciple()
local roleList={}
for index,disciple in ipairs(discipleList)do
local pos=lookup[disciple]
local posData=pos and self.teamData[pos]or nil
local weapon=posData and posData.weapon or nil
local data={
disciple=disciple,
weapon=weapon,
}
table.insert(roleList,data)
end
if#roleList>0 then
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
roleList=roleList,
parentWin=self,
showList=true,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyDiscipleDetailWin",args)
else
UIManager.error("无弟子信息可查看")
end
end

function UISubAct_ChiSeJinDi_FaZeGainWin:onWeaponBtn()
local weaponList=self.copyData.weaponList
self.copyData:sortWeaponList()
local lookup=self.info:getTeamLookup_Weapon()
local dataList={}
for index,weapon in ipairs(weaponList)do
local pos=lookup[weapon]
local posData=pos and self.teamData[pos]or nil
local disciple=posData and posData.disciple or nil
local data={
disciple=disciple,
weapon=weapon,
}
table.insert(dataList,data)
end
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
dataList=dataList,
parentWin=self,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyWeaponDetailWin",args)
end

function UISubAct_ChiSeJinDi_FaZeGainWin:onCloseBtn()
local callback=function()
self:doCloseWin(true)
end

if#self.selected<=0 then
UIDialogManager.getCommonDialog(nil,"尚未选择选项，确认本回合不需要法则？",callback)
else
callback()
end
end

function UISubAct_ChiSeJinDi_FaZeGainWin:doCloseWin(next)
if next then
call_activitiesHandle_func("activitiesHandle_chisejindi","reqNextCopyRound",self.actId,self.subId)
end

if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_ChiSeJinDi_FaZeGainWin:initView()
AudioManager.playAudio(669)
local roundData=self.copyData.roundData
local count=roundData.len
self.listPanel:setChildLayoutGroupCreateItems(count)
local itemList=self.listPanel:getChildLayoutGroupGridList()
self.selected={}
for index=1,itemList.Count do
local item=itemList[index-1]
local data=roundData.list[index]
local fazeId=data.param_1
local selected=data.param_2==1
self:initFaZeItem(item,index,fazeId,selected,count)
if selected then
table.insert(self.selected,index)
end
end
self.chooseButton:setActive(#self.selected<=0)
end

function UISubAct_ChiSeJinDi_FaZeGainWin:initFaZeItem(item,index,fazeId,selected,count)
local fazeCfg=self.config.faze[fazeId]
local fzId=fazeCfg[1]
local fzLv=fazeCfg[2]

local fzCfg=cfgHelper.getSSlawRule(fzId)
local qualityDesc=cfg_secretscenebaseconfig_get(1).rule_quality
local color_cfg=qualityDesc[fzLv]
local image=fzCfg.image
local name=fzCfg.name
local desc=fzCfg.desc
local descparm=fzCfg.descparm
if descparm and descparm[fzLv]and next(descparm[fzLv])then
desc=string.format(desc,unpack(descparm[fzLv]))
end
item:SetChildText(_itemCmpIndex.name,FMT.fmt("<color=#{0}>{1}</color>",color_cfg[2],name))
item:SetChildText(_itemCmpIndex.desc,desc)
item:SetChildCSImageIcon(_itemCmpIndex.icon,image,true)

local frameImg=iconHelper.getRuleQualityIcon(fzLv)
item:SetChildCSImageIcon(_itemCmpIndex.bg,frameImg,false)

item:SetChildButtonClick(_itemCmpIndex.bg,function()
self:onClickItem(index)
end)
item:SetChildLocalPosition(_itemCmpIndex.root,_moveStartPos[count][index])
item:SetChildRotation(_itemCmpIndex.root,0,0,0)
item:SetChildActive(_itemCmpIndex.root,true)

local tweener=Lua.SequenceProxy.New()
local tweener1=item:SetChildDOLocalMoveY(_itemCmpIndex.root,0,0.25)
local tweener2=item:SetChildDOLocalMove(_itemCmpIndex.root,_movePos[count][index],0.25)
local tweener3=item:SetChildDORotation(_itemCmpIndex.root,Vector3(0,0,_rotateZ[count][index]),0.25)
tweener:Append(tweener1)
tweener:Append(tweener2)
tweener:Join(tweener3)
self.tweeners[index]=tweener

item:SetChildActive(_itemCmpIndex.select,selected)

if fzCfg.zhuanshuImg then
item:SetChildActive(_itemCmpIndex.zhuanshu,true)
item:SetChildIcon(_itemCmpIndex.zhuanshu,FMT.fmt('image_zhuan_shu_faze_{0}',fzCfg.zhuanshuImg),true)
else
item:SetChildActive(_itemCmpIndex.zhuanshu,false)
end
end

function UISubAct_ChiSeJinDi_FaZeGainWin:onClickItem(index,force)
if self.selectIndex==index then
if self.selectIndex then
local item=self.listPanel:getChildLayoutGroupGridItem(self.selectIndex-1)
item:SetChildScale(_itemCmpIndex.root,Vector3.one)
end

self.selectIndex=nil
else
if self.selectIndex then
local item=self.listPanel:getChildLayoutGroupGridItem(self.selectIndex-1)
item:SetChildScale(_itemCmpIndex.root,Vector3.one)
end

self.selectIndex=index

local item=self.listPanel:getChildLayoutGroupGridItem(self.selectIndex-1)
item:SetChildScale(_itemCmpIndex.root,Vector3.one*1.1)
end

self:refreshDesc()
end

function UISubAct_ChiSeJinDi_FaZeGainWin:refreshDesc()
if self.selectIndex then
local roundData=self.copyData.roundData
local faZeData=roundData.list[self.selectIndex]
local fazeId=faZeData.param_1
local fazeCfg=self.config.faze[fazeId]
local fzId=fazeCfg[1]
local fzLv=fazeCfg[2]
local fzCfg=cfgHelper.getSSlawRule(fzId)
if fzCfg.attrdesc then
local desc=fzCfg.attrdesc
local descparm=fzCfg.descparm
if descparm and descparm[fzLv]and next(descparm[fzLv])then
desc=string.format(desc,unpack(descparm[fzLv]))
end
self.descBg:setActive(true)
self.desc:setText(desc)
else
self.descBg:setActive(false)
self.desc:setText("")
end
else
self.descBg:setActive(false)
self.desc:setText("")
end
end

function UISubAct_ChiSeJinDi_FaZeGainWin.on_249_238(actId,subId,idx,len,roundList)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
local contains=table.containsValue(_this.selected,idx)
if not contains then
table.insert(_this.selected,idx)
_this.chooseButton:setActive(false)
local item=_this.listPanel:getChildLayoutGroupGridItem(idx-1)
item:SetChildActive(_itemCmpIndex.select,true)
_this:doCloseWin()
end
end
end