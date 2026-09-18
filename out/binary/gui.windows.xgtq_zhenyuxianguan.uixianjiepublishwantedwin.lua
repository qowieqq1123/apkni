







def_class("UIXianJiePublishWantedWin",UIWindowBase)









function UIXianJiePublishWantedWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.Content=UIObject.get(self,1)
self.descText=UIText.get(self,2)
self.descText1=UIText.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.maskBlock=UIButton.get(self,5)
self.notZys=UIObject.get(self,6)
self.packScrollerView=UIObject.get(self,7)
self.publishBtn=UIButton.get(self,8)
self.root=UIObject.get(self,9)
self.uiPanel=UIObject.get(self,10)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.maskBlock:setButtonClick(function()self:onMaskBlock()end)

self.publishBtn:setButtonClick(function()self:onPublishBtn()end)



end


function UIXianJiePublishWantedWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.descText1);self.descText1=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.notZys);self.notZys=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
_UIObject_release(self.publishBtn);self.publishBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
end


















local this

local _colorKuang={
[xjServerEnityType.eMonster]={
[0]="image_gwtouxiangpjk_2",
[1]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eBossMonster]={
[0]="image_gwtouxiangpjk_4",
[1]="image_gwtouxiangpjk_3",
},
}



function UIXianJiePublishWantedWin:onLoaded(...)
this=self
self.timers={}
self:bindComponents()
self:addNotify(notifyConfig.onTeQuanInfoChange,self.onTeQuanInfoChange)
self:addNotify(notifyConfig.onXianJieMonsterChange,self.onXianJieMonsterChange)
end


function UIXianJiePublishWantedWin:__delete()
this=nil
self.data={}
self:clearAllTimer()
self.monList={}
self:unbindComponents()
end




function UIXianJiePublishWantedWin:onShow(argtable,afterOnloaded)
self.selectIndex=0
self.tqId=XIANGUAN_PRIVILEGE_ENUM.eZhenYuXunShou
self.isZYXS,self.gzId=xianguanController:checkSelfHasJobByType(XIANGUAN_TYPE_ENUM.eZhenYuXianGuan)
local key=xianguanConfig.getTeQuanFindKey(self.gzId,self.tqId)
self.data,self.monList=xianguanModel:getPublishWantedData(key)
self:refreshWin()
end


function UIXianJiePublishWantedWin:onHide()
self.monList={}
end
function UIXianJiePublishWantedWin.onTeQuanInfoChange()
local key=xianguanConfig.getTeQuanFindKey(this.gzId,this.tqId)
this.data,this.monList=xianguanModel:getPublishWantedData(key)
this:refreshWin()
end

function UIXianJiePublishWantedWin.onXianJieMonsterChange(typo,infoGuid)
if this==nil then return end

if typo==CHANGE_TYPE.eDelete then
if this.monList[tostring(infoGuid)]then
this:onCloseBtn()
end
end
end



















function UIXianJiePublishWantedWin:refreshWin()
self.publishBtn:setActive(self.isZYXS)
self.notZys:setActive(not self.isZYXS)
local showData

local curTime=timeHelper.getServerShortTime()
if self.data and next(self.data)then
for i,v in ipairs(self.data)do
local guid=v.param_1
local zydata=xianjieModel:getMonsterData(guid)
if zydata and zydata.expiresec then
local cdTime=zydata.expiresec-curTime
if cdTime>0 then
showData=true
break
end
end
end
end
self:clearAllTimer()

if showData then
self.uiPanel:setActive(false)
self.packScrollerView:setActive(self.isZYXS)
self:refreshScrollerView()
else
self.packScrollerView:setActive(false)
self.uiPanel:setActive(true)
local str='近日，仙界各处发现异常魔气波动，怀疑有强大魔物渗透进来，需要各位仙人前往缉拿。如有缉拿成功者，将获得丰厚奖赏'
local descText=comHelper.getCheckLayoutStr(self.descText1:getGameObject(),380,str,false)
self.winlua:SetChildText(self.descText:getID(),descText)
end
end

function UIXianJiePublishWantedWin:getConfigByType(type,infoid)
local str
local stage
local iconId
local monsterGroupid
local mowuCfg=xianjieController:xjrzgetCfg_hj(type,infoid)
if mowuCfg then
monsterGroupid=mowuCfg.monster[1]
local monsterGroupCfg=cfgHelper.get(cfg_monstergroup_get,monsterGroupid)













stage=mowuCfg.stage
local name=monsterGroupCfg.name
str=string.format('%s阶  %s',stage,name)
end

return str,monsterGroupid
end

function UIXianJiePublishWantedWin:refreshScrollerView()
if self.data and next(self.data)then
local datas=self.data
local len=#datas

if len>0 then
self.packScrollerView:setChildScrollViewCreateGrids(len,1)
local grids=self.packScrollerView:getChildScrollViewItemWidgets()

for i=1,len do
local str=''
local cdTime=0
local data=datas[i]
local item=grids[i-1]
local guid=data.param_1
local type=data.param_2
local infoid=data.param_3
local name,monsterGroupid=self:getConfigByType(type,infoid)
local iconName=_colorKuang[type][1]
local zydata=xianjieModel:getMonsterData(guid)
if zydata and zydata.expiresec then
local curTime=timeHelper.getServerShortTime()
cdTime=zydata.expiresec-curTime
end

if name and cdTime>0 then
if cdTime>0 then
self:startTimer(i,item,zydata.expiresec)
cdTime=timeHelper.format_time_stamp3(cdTime)
str=string.format('<color=#c82c2c>%s</color>后离开',cdTime)
end

item:SetChildActive(-1,true)
item:SetChildActive(0,self.selectIndex==i)
item:SetChildText(1,name)
item:SetChildText(2,str)
item:SetChildButtonClick(4,function()self:onHandleJump(guid,i)end)
comHelper.setChildModelRawImage_monsterGroup(item,monsterGroupid,3,0,eHeadCenterType.eHead)
item:SetChildCSImageSprite(5,globalABLookup.global,iconName)
else
item:SetChildActive(-1,false)
end
end

end
end

end

function UIXianJiePublishWantedWin:startTimer(id,item,endtime)
self:clearTimer(id)

local curTime=timeHelper.getServerShortTime()
local endtime=endtime
local cdTime=endtime-curTime
local str=string.format('<color=#c82c2c>%s</color>后离开',timeHelper.format_time_stamp3(cdTime))
item:SetChildActive(2,true)
item:SetChildText(2,str)
local tickCnt=(cdTime+3)*2

self.timers[id]=self:setTimer(1,tickCnt,function(id)
local dt=endtime-timeHelper.getServerShortTime()
if dt<0 then
self:clearTimer(id)
self:refreshWin()
return
end

local str=string.format('<color=#c82c2c>%s</color>后离开',timeHelper.format_time_stamp3(dt))
item:SetChildText(2,str)
end)
end

function UIXianJiePublishWantedWin:clearTimer(id)
if self.timers[id]then
self:stopTimerByID(self.timers[id])
self.timers[id]=nil
end
end

function UIXianJiePublishWantedWin:clearAllTimer()
for id,v in ipairs(self.timers or{})do
self:stopTimerByID(v)
end
self.timers={}
end




function UIXianJiePublishWantedWin:onCloseBtn()
self:closeSelf()
end


function UIXianJiePublishWantedWin:onHelpBtn()
local d={}
d.title='规则说明'
d.mode=3
d.name='xgTeQuan_ZYXS_%d'
self:showWindow('UIRuleWin',d)
end


function UIXianJiePublishWantedWin:onMaskBlock()
self:closeSelf()
end


function UIXianJiePublishWantedWin:onPublishBtn()
local key=xianguanConfig.getTeQuanFindKey(self.gzId,self.tqId)
local tqData=xianguanModel:getTeQuanDataByKey(key)

if not tqData then UIManager.error('找不到对应的仙官数据')return end
if self.gzId and xianguanHelper.checkTeQuanUseCondition(tqData.xgid,tqData.tqid,true)then
xianguanController.sendUsePrivilege(self.gzId,11,"")
end
end

function UIXianJiePublishWantedWin:onHandleJump(infoGuid,index)
local item
local grids=self.packScrollerView:getChildScrollViewItemWidgets()
if self.selectIndex>0 then item=grids[self.selectIndex-1]item:SetChildActive(0,false)end

item=grids[index-1]
item:SetChildActive(0,true)
self.selectIndex=index

local zydata=xianjieModel:getMonsterData(infoGuid)
xianjieModel:setMonsterCDLookup(zydata)
if zydata then
local func=function()
zydata:selectEntity(true)
xianjieController:openMonsterInfoWin(infoGuid)
end
xianjieController:jumpGrid(zydata.sceneidx,zydata.gridX,zydata.gridZ,func)
end
end