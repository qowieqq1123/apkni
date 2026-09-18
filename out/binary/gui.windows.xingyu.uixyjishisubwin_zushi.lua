







def_class("UIXYJiShiSubWin_ZuShi",UIWindowBase)









function UIXYJiShiSubWin_ZuShi:bindComponents()

self.noItemTips=UIText.get(self,0)
self.root=UIObject.get(self,1)
self.Scroller=UILoopListView.new(self,2)

self.Scroller:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIXYJiShiSubWin_ZuShi:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.root);self.root=nil;
self.Scroller:deleteSelf();self.Scroller=nil;
end
















local prefabNames={
[LOGTYPE.eGetReward]="scrollerItem_reward",
[LOGTYPE.eGetFaZe]="scrollerItem_faze",
[LOGTYPE.eAllDzHurt]="scrollerItem_event",
[LOGTYPE.eDzHurt]="scrollerItem_event",
[LOGTYPE.eAllDzAddJJExp]="scrollerItem_event",
[LOGTYPE.eDzAddJJExp]="scrollerItem_event",
[LOGTYPE.eAllDzAddLTExp]="scrollerItem_event",
[LOGTYPE.eDzAddLTExp]="scrollerItem_event",
[LOGTYPE.eTeamFail]="scrollerItem_event",
[LOGTYPE.eFewReward]="scrollerItem_reward",
[LOGTYPE.eTanSuoFail]="scrollerItem_event",
[LOGTYPE.eTanSuoGaiLvFail]="scrollerItem_event",
}

local refreshFuncName={
[LOGTYPE.eGetReward]="refreshFunc_GetReward",
[LOGTYPE.eGetFaZe]="refreshFunc_GetFaZe",
[LOGTYPE.eAllDzHurt]="refreshFunc_AllDzHurt",
[LOGTYPE.eDzHurt]="refreshFunc_DzHurt",
[LOGTYPE.eAllDzAddJJExp]="refreshFunc_AllDzAddJJExp",
[LOGTYPE.eDzAddJJExp]="refreshFunc_DzAddJJExp",
[LOGTYPE.eAllDzAddLTExp]="refreshFunc_AllDzAddLTExp",
[LOGTYPE.eDzAddLTExp]="refreshFunc_DzAddLTExp",
[LOGTYPE.eTeamFail]="refreshFunc_TeamFail",
[LOGTYPE.eFewReward]="refreshFunc_FewReward",
[LOGTYPE.eTanSuoFail]="refreshFunc_TanSuoFail",
[LOGTYPE.eTanSuoGaiLvFail]="refreshFunc_TanSuoGaiLvFail",
}

local abName="ui/windows/xianmeng/act_zhengzhanshanhai/zhengzhanshanhaiicons_atlas_pak.ab"
local iconName={
[LOGTYPE.eGetReward]="icon_typaiqianzjui_2",
[LOGTYPE.eGetFaZe]="icon_typaiqianzjui_1",
[LOGTYPE.eAllDzHurt]="icon_typaiqianzjui_1",
[LOGTYPE.eDzHurt]="icon_typaiqianzjui_1",
[LOGTYPE.eAllDzAddJJExp]="icon_typaiqianzjui_1",
[LOGTYPE.eDzAddJJExp]="icon_typaiqianzjui_1",
[LOGTYPE.eAllDzAddLTExp]="icon_typaiqianzjui_1",
[LOGTYPE.eDzAddLTExp]="icon_typaiqianzjui_1",
[LOGTYPE.eTeamFail]="icon_typaiqianzjui_4",
[LOGTYPE.eFewReward]="icon_typaiqianzjui_2",
[LOGTYPE.eTanSuoFail]="icon_typaiqianzjui_4",
[LOGTYPE.eTanSuoGaiLvFail]="icon_typaiqianzjui_4",
}



function UIXYJiShiSubWin_ZuShi:onLoaded(...)
self:bindComponents()
end


function UIXYJiShiSubWin_ZuShi:__delete()
self:unbindComponents()
end




function UIXYJiShiSubWin_ZuShi:onShow(argtable,afterOnloaded)
local xyId=argtable.xyId
if self.xyId==xyId then
return
end
self.xyId=xyId
self.lastOpenTime=XingYuController.getOpenZSLogTime(xyId)
XingYuController.setOpenZSLogTime(self.xyId)











local list=XingYuModel:getXingYuData_zsLogList(xyId)
if list and#list>0 then
self.noItemTips:setActive(false)
local tempList={}
local prefabnameList={}
for i,temp in ipairs(list)do
local name=prefabNames[temp.logType]
if not name then
logErr("prefabNames 为 nil",temp.logType)
return
end
table.insert(prefabnameList,name)
end
self.Scroller:initDataEx(prefabnameList,list)
else
self.Scroller:initData(nil,nil,0)
self.noItemTips:setActive(true)
end
end


function UIXYJiShiSubWin_ZuShi:onHide()

end

function UIXYJiShiSubWin_ZuShi:refreshFunc_GetReward(item,data)




local args=data.args
local evnid=args[1]
local evncfg=cfg_xingyueventconfig_get(evnid)
local result=evncfg.result
local desc=evncfg.desc




local descStr=FMT.fmt("<size=22>{0}</size>",desc)

if evncfg.triCondition then
local _cndStr=XingYuController.getTriConditionStr(evncfg.triCondition)
descStr=FMT.fmt("{0}\n \n<size=22><color=#7D3B17>（{1}）</color></size>",descStr,_cndStr)

end

item:SetChildText(2,descStr)

local itemList={}
for i,v in ipairs(result[2])do
local color=itemsConfig.getItemColor(v[1])
table.insert(itemList,{v[1],v[2],showStage=true,color=color})
end
table.sort(itemList,function(a,b)
return a.color>b.color
end)

item:SetChildLayoutGroupCreateItems(8,#itemList,function(index)
local rewardItem=item:GetChildLayoutGroupGridItem(8,index-1)
local rewardData=itemList[index]
widgetHelper.setNormalRewardItem(rewardItem,-1,rewardData,true)
end)











local logTime=data.logTime
local lastTime=self.lastOpenTime
if lastTime and logTime and logTime>lastTime then
item:SetChildActive(6,true)
else
item:SetChildActive(6,false)
end
return 0,1,2,9
end

function UIXYJiShiSubWin_ZuShi:refreshFunc_GetFaZe(item,data)

local args=data.args
local evnid=args[1]

local evncfg=cfg_xingyueventconfig_get(evnid)
local desc=evncfg.desc

local descStr=FMT.fmt("<size=22>{0}</size>",desc)
if evncfg.triCondition then
local _cndStr=XingYuController.getTriConditionStr(evncfg.triCondition)
descStr=FMT.fmt("{0}\n \n<size=22><color=#7D3B17>（{1}）</color></size>",descStr,_cndStr)
end

item:SetChildText(2,descStr)

local fazeItem=item:GetChildWidgetBase(3)
local rid=args[2]
local rlevel=args[3]
local ruleCfg=cfgHelper.getSSlawRule(rid)
local image=ruleCfg.image
fazeItem:SetChildCSImageIcon(0,image,false)
fazeItem:SetChildButtonClick(1,function()

local _args={}
local desc=ruleCfg.desc
local descparm=ruleCfg.descparm
if descparm and descparm[rlevel]and next(descparm[rlevel])then
desc=string.format(desc,unpack(descparm[rlevel]))
end
_args.desc=desc
local Position=fazeItem:GetChildPosition(1)
local ScreenPoint=CS.CSGUIManager.Instance:WorldToScreenPoint(Position)
_args.screenPoint=ScreenPoint
UIManager:showWindow("UISimpleHJEffectTipsWin",_args)
end)









local logTime=data.logTime
local lastTime=self.lastOpenTime
if lastTime and logTime and logTime>lastTime then
item:SetChildActive(5,true)
else
item:SetChildActive(5,false)
end

return 0,1,2,6
end

function UIXYJiShiSubWin_ZuShi:refreshFunc_AllDzHurt(item,data)

local args=data.args
local evnid=args[1]
local evncfg=cfg_xingyueventconfig_get(evnid)
local desc=evncfg.desc

local descStr=FMT.fmt("<size=22>{0}</size>",desc)
if evncfg.triCondition then
local _cndStr=XingYuController.getTriConditionStr(evncfg.triCondition)
descStr=FMT.fmt("{0}\n \n<size=22><color=#7D3B17>（{1}）</color></size>",descStr,_cndStr)
end

item:SetChildText(2,descStr)

local logType=data.logType
local logcfg=cfg_xingyulogconfig_get(logType)
local logDesc=logcfg.logDesc
local HurtValue=evncfg.result[2]
local tipStr=FMT.fmt(logDesc,args[2],HurtValue)
item:SetChildText(3,tipStr)









local logTime=data.logTime
local lastTime=self.lastOpenTime
if lastTime and logTime and logTime>lastTime then
item:SetChildActive(5,true)
else
item:SetChildActive(5,false)
end

return 0,1,2,6
end

function UIXYJiShiSubWin_ZuShi:refreshFunc_DzHurt(item,data)

local args=data.args
local evnid=args[1]
local evncfg=cfg_xingyueventconfig_get(evnid)
local desc=evncfg.desc
local descStr=FMT.fmt("<size=22>{0}</size>",desc)
if evncfg.triCondition then
local _cndStr=XingYuController.getTriConditionStr(evncfg.triCondition)
descStr=FMT.fmt("{0}\n \n<size=22><color=#7D3B17>（{1}）</color></size>",descStr,_cndStr)
end

item:SetChildText(2,descStr)

local logType=data.logType
local logcfg=cfg_xingyulogconfig_get(logType)
local logDesc=logcfg.logDesc
local HurtValue=evncfg.result[2]
local dzName=UIDiscipleModel:getDiscipleName(args[3])

local tipStr=FMT.fmt(logDesc,args[2],dzName,HurtValue)
item:SetChildText(3,tipStr)









local logTime=data.logTime
local lastTime=self.lastOpenTime
if lastTime and logTime and logTime>lastTime then
item:SetChildActive(5,true)
else
item:SetChildActive(5,false)
end

return 0,1,2,6
end

function UIXYJiShiSubWin_ZuShi:refreshFunc_AllDzAddJJExp(item,data)

local args=data.args
local evnid=args[1]
local evncfg=cfg_xingyueventconfig_get(evnid)
local desc=evncfg.desc
local descStr=FMT.fmt("<size=22>{0}</size>",desc)
if evncfg.triCondition then
local _cndStr=XingYuController.getTriConditionStr(evncfg.triCondition)
descStr=FMT.fmt("{0}\n \n<size=22><color=#7D3B17>（{1}）</color></size>",descStr,_cndStr)
end

item:SetChildText(2,descStr)

local logType=data.logType
local logcfg=cfg_xingyulogconfig_get(logType)
local logDesc=logcfg.logDesc
local exp=mathHelper.formatNumber10(args[3])
local tipStr=FMT.fmt(logDesc,args[2],exp)
item:SetChildText(3,tipStr)








local logTime=data.logTime
local lastTime=self.lastOpenTime
if lastTime and logTime and logTime>lastTime then
item:SetChildActive(5,true)
else
item:SetChildActive(5,false)
end

return 0,1,2,6
end

function UIXYJiShiSubWin_ZuShi:refreshFunc_DzAddJJExp(item,data)

local args=data.args
local evnid=args[1]
local evncfg=cfg_xingyueventconfig_get(evnid)
local desc=evncfg.desc
local descStr=FMT.fmt("<size=22>{0}</size>",desc)
if evncfg.triCondition then
local _cndStr=XingYuController.getTriConditionStr(evncfg.triCondition)
descStr=FMT.fmt("{0}\n \n<size=22><color=#7D3B17>（{1}）</color></size>",descStr,_cndStr)
end

item:SetChildText(2,descStr)

local logType=data.logType
local logcfg=cfg_xingyulogconfig_get(logType)
local logDesc=logcfg.logDesc
local dzName=UIDiscipleModel:getDiscipleName(args[3])
local exp=mathHelper.formatNumber10(args[4])
local tipStr=FMT.fmt(logDesc,args[2],dzName,exp)
item:SetChildText(3,tipStr)









local logTime=data.logTime
local lastTime=self.lastOpenTime
if lastTime and logTime and logTime>lastTime then
item:SetChildActive(5,true)
else
item:SetChildActive(5,false)
end

return 0,1,2,6
end

function UIXYJiShiSubWin_ZuShi:refreshFunc_AllDzAddLTExp(item,data)

local args=data.args
local evnid=args[1]
local evncfg=cfg_xingyueventconfig_get(evnid)
local desc=evncfg.desc
local descStr=FMT.fmt("<size=22>{0}</size>",desc)
if evncfg.triCondition then
local _cndStr=XingYuController.getTriConditionStr(evncfg.triCondition)
descStr=FMT.fmt("{0}\n \n<size=22><color=#7D3B17>（{1}）</color></size>",descStr,_cndStr)
end

item:SetChildText(2,descStr)

local logType=data.logType
local logcfg=cfg_xingyulogconfig_get(logType)
local logDesc=logcfg.logDesc
local exp=mathHelper.formatNumber10(args[3])
local tipStr=FMT.fmt(logDesc,args[2],exp)
item:SetChildText(3,tipStr)









local logTime=data.logTime
local lastTime=self.lastOpenTime
if lastTime and logTime and logTime>lastTime then
item:SetChildActive(5,true)
else
item:SetChildActive(5,false)
end

return 0,1,2,6
end

function UIXYJiShiSubWin_ZuShi:refreshFunc_DzAddLTExp(item,data)

local args=data.args
local evnid=args[1]
local evncfg=cfg_xingyueventconfig_get(evnid)
local desc=evncfg.desc
local descStr=FMT.fmt("<size=22>{0}</size>",desc)
if evncfg.triCondition then
local _cndStr=XingYuController.getTriConditionStr(evncfg.triCondition)
descStr=FMT.fmt("{0}\n \n<size=22><color=#7D3B17>（{1}）</color></size>",descStr,_cndStr)
end

item:SetChildText(2,descStr)

local logType=data.logType
local logcfg=cfg_xingyulogconfig_get(logType)
local logDesc=logcfg.logDesc
local dzName=UIDiscipleModel:getDiscipleName(args[3])
local exp=mathHelper.formatNumber10(args[4])
local tipStr=FMT.fmt(logDesc,args[2],dzName,exp)
item:SetChildText(3,tipStr)









local logTime=data.logTime
local lastTime=self.lastOpenTime
if lastTime and logTime and logTime>lastTime then
item:SetChildActive(5,true)
else
item:SetChildActive(5,false)
end

return 0,1,2,6
end

function UIXYJiShiSubWin_ZuShi:refreshFunc_TeamFail(item,data)

local args=data.args
local evnid=args[1]
local evncfg=cfg_xingyueventconfig_get(evnid)
local desc=evncfg.desc
local descStr=FMT.fmt("<size=22>{0}</size>",desc)
if evncfg.triCondition then
local _cndStr=XingYuController.getTriConditionStr(evncfg.triCondition)
descStr=FMT.fmt("{0}\n \n<size=22><color=#7D3B17>（{1}）</color></size>",descStr,_cndStr)
end

item:SetChildText(2,descStr)

local logType=data.logType
local logcfg=cfg_xingyulogconfig_get(logType)
local logDesc=logcfg.logDesc
local tipStr=FMT.fmt(logDesc,args[2])
item:SetChildText(3,tipStr)









local logTime=data.logTime
local lastTime=self.lastOpenTime
if lastTime and logTime and logTime>lastTime then
item:SetChildActive(5,true)
else
item:SetChildActive(5,false)
end

return 0,1,2,6
end

function UIXYJiShiSubWin_ZuShi:refreshFunc_FewReward(item,data)
local args=data.args
local evnid=args[1]
local evncfg=cfg_xingyueventconfig_get(evnid)
local result=evncfg.result
local desc=evncfg.desc

local descStr=string.replace(string.replace(desc,"[{0}]",""),"{1}","")
descStr=string.replace(descStr,"{2}","{0}")
local fewItemId=evncfg.fewShowItem
local item_config=itemsConfig.getConfig(fewItemId)

local itemName=FMT.cfmt(item_config.color,"[{0}]",item_config.name)
descStr=FMT.fmt(descStr,itemName)

descStr=FMT.fmt("<size=22>{0}</size>",descStr)
if evncfg.triCondition then
local _cndStr=XingYuController.getTriConditionStr(evncfg.triCondition)
descStr=FMT.fmt("{0}\n \n<size=22><color=#7D3B17>（{1}）</color></size>",descStr,_cndStr)
end
item:SetChildText(2,descStr)

local itemList={}
for i,v in ipairs(result[2])do
local color=itemsConfig.getItemColor(v[1])
table.insert(itemList,{v[1],v[2],showStage=true,color=color})
end
table.sort(itemList,function(a,b)
return a.color>b.color
end)

item:SetChildLayoutGroupCreateItems(8,#itemList,function(index)
local rewardItem=item:GetChildLayoutGroupGridItem(8,index-1)
local rewardData=itemList[index]
widgetHelper.setNormalRewardItem(rewardItem,-1,rewardData,true)
end)











local logTime=data.logTime
local lastTime=self.lastOpenTime
if lastTime and logTime and logTime>lastTime then
item:SetChildActive(6,true)
else
item:SetChildActive(6,false)
end

return 0,1,2,9
end

function UIXYJiShiSubWin_ZuShi:refreshFunc_TanSuoFail(item,data)

local args=data.args
local evnid=args[1]
local evncfg=cfg_xingyueventconfig_get(evnid)
local desc=evncfg.desc
local sNmae=loginModel:getServerName(args[3])
local descStr=FMT.fmt(desc,sNmae,args[4])
descStr=FMT.fmt("<size=22>{0}</size>",descStr)

if evncfg.triCondition then
local _cndStr=XingYuController.getTriConditionStr(evncfg.triCondition)
descStr=FMT.fmt("{0}\n \n<size=22><color=#7D3B17>（{1}）</color></size>",descStr,_cndStr)
end
item:SetChildText(2,descStr)
local logType=data.logType
local logcfg=cfg_xingyulogconfig_get(logType)
local logDesc=logcfg.logDesc
local tipStr=FMT.fmt(logDesc,args[2])
item:SetChildText(3,tipStr)









local logTime=data.logTime
local lastTime=self.lastOpenTime
if lastTime and logTime and logTime>lastTime then
item:SetChildActive(5,true)
else
item:SetChildActive(5,false)
end

return 0,1,2,6
end

function UIXYJiShiSubWin_ZuShi:refreshFunc_TanSuoGaiLvFail(item,data)

local args=data.args
local txtIndex=args[1]
local cfg=cfg_xingyubaseconfig_get(1)
local desc=cfg.glttText and cfg.glttText[txtIndex]or""
local descStr=FMT.fmt("<size=22>{0}</size>",desc or"")


item:SetChildText(2,descStr)

local logType=data.logType
local logcfg=cfg_xingyulogconfig_get(logType)
local logDesc=logcfg.logDesc
local tipStr=FMT.fmt(logDesc,args[2])
item:SetChildText(3,tipStr)









local logTime=data.logTime
local lastTime=self.lastOpenTime
if lastTime and logTime and logTime>lastTime then
item:SetChildActive(5,true)
else
item:SetChildActive(5,false)
end

return 0,1,2,6
end


function UIXYJiShiSubWin_ZuShi:onFreshAction(index,widget,data)
local item=widget

local funcName=refreshFuncName[data.logType]

local itemCmpIndex,bgCmpIndex,contentCmpIndex,iconCmpIndex
if funcName and self[funcName]then
itemCmpIndex,bgCmpIndex,contentCmpIndex,iconCmpIndex=self[funcName](self,item,data)
else
logErr("UIXYJiShiSubWin_ZuShi refreshFuncName 没有刷新方法",data.logType)
end
if iconCmpIndex then
item:SetChildCSImageSprite(iconCmpIndex,abName,iconName[data.logType])
end
if bgCmpIndex and itemCmpIndex then

item:ForceLayoutVertical(contentCmpIndex)
local bgY=item:GetChildRectHeight(bgCmpIndex)
local itemHiget=bgY+4
item:SetChildSizeDelta(itemCmpIndex,1053,itemHiget)
item:FreshChildLayoutRectThree(contentCmpIndex)
else
logErr("UIXYJiShiSubWin_ZuShi bgCmpIndex or itemCmpIndex")
end
end


function UIXYJiShiSubWin_ZuShi:onStartAction()
end



