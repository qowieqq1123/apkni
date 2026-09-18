







def_class("UISystemZongMenFightPrepareInfoWin",UIWindowBase)









function UISystemZongMenFightPrepareInfoWin:bindComponents()

self.levelTx=UIText.get(self,0)
self.skillList=UIObject.get(self,1)
self.sheildProgres=UIProgress.get(self,2)
self.panelBg=UIObject.get(self,3)
self.infoBtn=UIButton.get(self,4)
self.progressPanel=UIObject.get(self,5)
self.detailPanel=UIButton.get(self,6)
self.buffIcon=UIImage.get(self,7)
self.buffText=UIText.get(self,8)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.detailPanel:setButtonClick(function()self:onDetailPanel()end)



end


function UISystemZongMenFightPrepareInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.levelTx);self.levelTx=nil;
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.sheildProgres);self.sheildProgres=nil;
_UIObject_release(self.panelBg);self.panelBg=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.progressPanel);self.progressPanel=nil;
_UIObject_release(self.detailPanel);self.detailPanel=nil;
_UIObject_release(self.buffIcon);self.buffIcon=nil;
_UIObject_release(self.buffText);self.buffText=nil;
end















local _this=nil
local _skillCmp={
icon=0,
lvTx=1,
lock=2,
lvBg=3,
}



function UISystemZongMenFightPrepareInfoWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onSystemZMDefenseInfo,self.onSystemZMDefenseInfo)
self:addNotify(notifyConfig.onSystemZMDefenseInfoServerChange,self.onSystemZMDefenseInfoServerChange)
end


function UISystemZongMenFightPrepareInfoWin:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenFightPrepareInfoWin:onShow(argtable,afterOnloaded)
self.infoData=argtable.infoData
self.defenseInfo=argtable.defenseInfo or systemZongMenModel:getDefenseInfo(self.infoData.serial)
self:refreshView()
end


function UISystemZongMenFightPrepareInfoWin:onHide()

end




function UISystemZongMenFightPrepareInfoWin:onInfoBtn()
self.detailPanel:setScale(Vector3.one)
self.winlua:ForceLayoutRect(self.detailPanel:getID())
end


function UISystemZongMenFightPrepareInfoWin:onDetailPanel()
self.detailPanel:setScale(Vector3.zero)
end

function UISystemZongMenFightPrepareInfoWin.onSystemZMDefenseInfo(serial)
if mathHelper.compareInt64(_this.infoData.serial,serial)then
_this.defenseInfo=systemZongMenModel:getDefenseInfo(_this.infoData.serial)
_this:refreshView()
end
end

function UISystemZongMenFightPrepareInfoWin.onSystemZMDefenseInfoServerChange(serial)
if mathHelper.compareInt64(_this.infoData.serial,serial)then
systemZongMenController:req_look_dazhen(serial)
end
end

function UISystemZongMenFightPrepareInfoWin:refreshView()
local baseCfg=cfgHelper.get1(cfg_syssectbaseconfig_get,1)
local config=cfgHelper.get1(cfg_syssectconfig_get,self.infoData.id)
local allSmCfg=cfg_shanmendazhenconfig()
local maxLv=#allSmCfg


local params=config.dazhenLv or baseCfg.dzParams
local paramA=params[1]
local paramB=params[2]
self.level=Mathf.Clamp(math.floor(self.infoData.level*paramA+paramB),0,maxLv)
local maxSmCfg=allSmCfg[maxLv]
local curSmCfg=allSmCfg[self.level]

self.levelTx:setText(FMT.fmt("{0}级",self.level))

local haveShield=curSmCfg.shield>0
self.progressPanel:setActive(haveShield)
if haveShield then
local curValue=Mathf.Clamp(self.defenseInfo.value,0,curSmCfg.shield)/curSmCfg.shield*10000
local valueTx=mathHelper.formatNumber(self.defenseInfo.value)
local maxTx=mathHelper.formatNumber(curSmCfg.shield)
self.sheildProgres:setProgressValue(curValue,10000)
self.sheildProgres:setChildProgressText(FMT.fmt("{0}/{1}",valueTx,maxTx))
end

local cFazeCnt=#curSmCfg.faze
local openLookup={}
for i,v in ipairs(curSmCfg.faze)do
openLookup[v[1]]=true
end
local mFazeCnt=#maxSmCfg.faze
local openList={}
local closeList={}
for i,v in ipairs(maxSmCfg.faze)do
if openLookup[v[1]]then
table.insert(openList,i)
else
table.insert(closeList,i)
end
end
local openCnt=#openList
self.skillList:setChildLayoutGroupCreateItems(mFazeCnt,function(index)
local item=self.skillList:getChildLayoutGroupGridItem(index-1)
if index<=openCnt then
local openIndex=openList[index]
local data=curSmCfg.faze[openIndex]
local fazeCfg=cfgHelper.getSSlawRule(data[1])
local iconName=fazeCfg.image
local level=maxSmCfg.faze[index][2]
item:SetChildCSImageIcon(_skillCmp.icon,iconName,false)
item:SetChildImageExGray(_skillCmp.icon,false)
item:SetChildText(_skillCmp.lvTx,FMT.fmt("{0}级",level))
item:SetChildActive(_skillCmp.lock,false)
item:SetChildActive(_skillCmp.lvBg,true)
item:SetChildButtonClick(_skillCmp.icon,function()
self:onClickSkill(index,data)
end)
else
local closeIndex=closeList[index-openCnt]
local data=maxSmCfg.faze[closeIndex]
local fazeCfg=cfgHelper.getSSlawRule(data[1])
local iconName=fazeCfg.image
item:SetChildCSImageIcon(_skillCmp.icon,iconName,false)
item:SetChildImageExGray(_skillCmp.icon,true)
item:SetChildActive(_skillCmp.lvBg,false)
item:SetChildActive(_skillCmp.lock,true)
item:SetChildButtonClick(_skillCmp.icon,function()
self:onClickSkill(index,data)
end)
end
end)

local buffCfg=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"pbfzEx")
self.buffIcon:setImageIcon(buffCfg[1],true)
self.buffText:setText(buffCfg[2])
end

function UISystemZongMenFightPrepareInfoWin:onClickSkill(index,fazeCfg)
local fazeID=fazeCfg[1]
local fazeLv=fazeCfg[2]
local fazeCfg=cfgHelper.getSSlawRule(fazeID)
local descparm=fazeCfg.descparm
local name=fazeCfg.name
local icon=fazeCfg.image
local desc=descparm and string.format(fazeCfg.desc,unpack(descparm[fazeLv]))or fazeCfg.desc
local halfVector=Vector2.right*0.5
local skillItems=self.skillList:getChildLayoutGroupGridList()
local skillCnt=skillItems.Count
local args={
name=name,
icon=icon,
desc=desc,
rootPoint={
anchorsMin=Vector2.New(0.5,0),
anchorsMax=Vector2.New(0.5,0),
pivot=Vector2.New(1,0),
anchoredPosition=Vector2.New(169.5-(30+skillCnt*70+(skillCnt-1)*11)/2+15+(index-0.5)*70+(index-1)*11,379),
},
}
self:showWindow('UISimpleTeXingTipsWin',args)
end