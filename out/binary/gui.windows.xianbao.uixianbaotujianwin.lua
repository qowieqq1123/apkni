







def_class("UIXianBaoTuJianWin",UIWindowBase)









function UIXianBaoTuJianWin:bindComponents()

self.root=UIObject.get(self,0)
self.creater=UIObject.get(self,1)
self.empty=UIObject.get(self,2)



end


function UIXianBaoTuJianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.creater);self.creater=nil;
_UIObject_release(self.empty);self.empty=nil;
end


















local _this=nil
local dfabname='ui/windows/dianfengzhibao/dianfengzhibao_atlas_pak.ab'

function UIXianBaoTuJianWin:onLoaded(...)
self:bindComponents()
self:addReddotNotify(REDDIT_TYPE.eXianBao,function(...)self:freshReddot()end)
self:addNotify(notifyConfig.on_item_list_changed,function(...)self:onItemsChanged(...)end)
_this=self
end


function UIXianBaoTuJianWin:__delete()
self:unbindComponents()
_this=nil
end

function UIXianBaoTuJianWin:doFadeIn(delay,duration)
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,duration,nil)
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
end




function UIXianBaoTuJianWin:onShow(argtable,afterOnloaded)
self.isShow=true
self:doFadeIn(0,1)
self.targertXbId=argtable and argtable.xbid
local func=function()
self:initXBListPanel()
end
if afterOnloaded then
self:delayDo(0.01,func)
else
func()
end

end

function UIXianBaoTuJianWin:onShowArgRecv(argtable)
self.isShow=true
self:initXBListPanel()
end

function UIXianBaoTuJianWin:getXBList(compare)
local xianbaolist={}
local xbId,xbCfg,type
local tempList={}

local canActiveList=xianbaoModel:getCanActiveList()
for i,v in ipairs(canActiveList)do
xbId=v
xbCfg=xianbaoConfig.getXBCfg(xbId)
type=0
if not tempList[type]then
local temp={}
temp.typo=type
temp.title=xianbaoConfig.getTypeName(type)
temp.childlist={}
tempList[type]=temp
table.insert(xianbaolist,temp)
end
local subTemp={}
subTemp.id=xbId
subTemp.icon=xbCfg.icon
subTemp.color=xbCfg.color
subTemp.name=xbCfg.name
subTemp.isCanActive=true
table.insert(tempList[type].childlist,subTemp)
end

local notActiveList=xianbaoModel:getNotActiveList()
for i,v in ipairs(notActiveList)do
xbId=v
xbCfg=xianbaoConfig.getXBCfg(xbId)
type=xbCfg.type
if not tempList[type]then
local temp={}
temp.typo=type
temp.title=xianbaoConfig.getTypeName(type)
temp.childlist={}
tempList[type]=temp
table.insert(xianbaolist,temp)
end
local subTemp={}
subTemp.id=xbId
subTemp.icon=xbCfg.icon
subTemp.color=xbCfg.color
subTemp.name=xbCfg.name
subTemp.isActive=false
table.insert(tempList[type].childlist,subTemp)
end


local activeList=xianbaoModel:getActiveList()
for i,v in ipairs(activeList)do
xbId=v
xbCfg=xianbaoConfig.getXBCfg(xbId)
type=xbCfg.type
if not tempList[type]then
local temp={}
temp.typo=type
temp.title=xianbaoConfig.getTypeName(type)
temp.childlist={}
tempList[type]=temp
table.insert(xianbaolist,temp)
end
local subTemp={}
subTemp.id=xbId
subTemp.icon=xbCfg.icon
subTemp.color=xbCfg.color
subTemp.name=xbCfg.name
subTemp.isActive=true
table.insert(tempList[type].childlist,subTemp)
end


local gbList=cfgHelper.get2(cfg_xianbaobaseconfig_get,1,'gbToXbList')
for gbid,tInfo in pairs(gbList or{})do
local isActiveGb=gubaoModel:checkActive(gbid)
if isActiveGb then
type=tInfo.type
if not tempList[type]then
local temp={}
temp.typo=type
temp.title=xianbaoConfig.getTypeName(type)
temp.childlist={}
tempList[type]=temp
table.insert(xianbaolist,temp)
end

local gbCfg=cfgHelper.get1(cfg_gubaoconfig_get,gbid)
local subTemp={}
subTemp.id=gbid
subTemp.icon=gbCfg.icon
subTemp.color=gbCfg.color
subTemp.name=gbCfg.name
subTemp.cfgType=ITEM_CONFIG_TYPE.eGuBao
subTemp.isActive=true
subTemp.insertBtnList=tInfo.insertBtnList
table.insert(tempList[type].childlist,subTemp)
end
end



self.maxPageIndex=0
self.maxPageNum=0
self.jumpPageIndex=0
self.jumpPageNum=0
for pageidx,pageData in ipairs(xianbaolist)do
local n=#pageData.childlist
if n>self.maxPageNum then
self.maxPageIndex=pageidx
self.maxPageNum=n
end
if self.jumpPageIndex==0 then
for childidx,xbCfg in ipairs(pageData.childlist)do
local xbid=xbCfg.id
if self.targertXbId==xbid then
self.jumpPageIndex=pageidx
self.jumpPageNum=childidx
break
end
end
end
end

if compare and self.xianbaolist then
for k,v in pairs(xianbaolist)do
if self.xianbaolist[k]then
if#self.xianbaolist[k].childlist~=#v.childlist then
self.xianbaolist=xianbaolist
return true
end
else
self.xianbaolist=xianbaolist
return true
end
end
return false
end
self.xianbaolist=xianbaolist
return true
end

function UIXianBaoTuJianWin:initXBListPanel(jump,compare)
local compareRes=self:getXBList(compare)
if not compareRes then
return
end
local pagenum=#self.xianbaolist
self.allitemList={}
if pagenum<=0 then
self.empty:setActive(true)
self.creater:setChildLayoutGroupClearAllItems()
return
end
self.empty:setActive(false)
local func=function(idx)
local item=self.creater:getChildLayoutGroupGridItem(idx-1)
self:refreshPageItem(item,idx,jump)
end
self.creater:setChildLayoutGroupCreateItems(pagenum,func)
end

function UIXianBaoTuJianWin:refreshPageItem(item,pageidx,check)
local pageData=self.xianbaolist[pageidx]
local pageType=pageData.typo
local name_str=pageData.title
item:SetChildText(0,name_str)
local childnum=#pageData.childlist
local func=function(idx)
local childItem=item:GetChildLayoutGroupGridItem(1,idx-1)
childItem:SetChildButtonClick(5,function()
self:onChildItemClick(pageidx,idx)
end)
self:refreshChildItem(childItem,pageidx,idx)
if check then
self:checkRefreshFinish(pageidx,idx)
end



end
item:SetChildLayoutGroupCreateItems(1,childnum,func)
end

function UIXianBaoTuJianWin:onChildItemClick(pageidx,childidx)
local pageData=self.xianbaolist[pageidx]
local cfg=pageData.childlist[childidx]
local id=cfg.id
local cfgType=cfg.cfgType and cfg.cfgType or ITEM_CONFIG_TYPE.eXianBao
local itemid=xianbaoConfig.getTypeFuncResult(cfgType,'getXBActiveItemId',id)
if cfgType==ITEM_CONFIG_TYPE.eXianBao then
tipsManager.showTipsXB({attach={xbItemId=itemid},formType=TIPS_FORM_TYPE.eXianBaoTujian,tipsType=TIPS_TYPE.eCommonXianBao,itemid=id,bg=false,funType=TIPS_FUNC_TYPE.eXianBao,cfgType=cfg.cfgType,xbtype=cfg.cfgType})
elseif cfgType==ITEM_CONFIG_TYPE.eGuBao then
tipsManager.showTipsXB({attach={xbItemId=itemid,insertBtnList=cfg.insertBtnList},formType=TIPS_FORM_TYPE.eXianBaoTujian,tipsType=TIPS_TYPE.eCommonXianBao2,itemid=id,bg=false,funType=TIPS_FUNC_TYPE.eXianBao,cfgType=cfg.cfgType,xbtype=cfg.cfgType})
end
end

function UIXianBaoTuJianWin:refreshChildItem(item,pageidx,childidx)
local pageData=self.xianbaolist[pageidx]
local pageType=pageData.typo
local cfg=pageData.childlist[childidx]
local id=cfg.id

local cfgType=cfg.cfgType and cfg.cfgType or ITEM_CONFIG_TYPE.eXianBao

local isLD=liandonModel:getLianDonLinkageIdByItemId(id,cfgType)>0
local canActive=cfg.isCanActive
local isSpe=false
local active=cfg.isActive


local icon=xianbaoConfig.getTypeFuncResult(cfgType,"getIcon",id)
item:SetChildCSImageIcon(0,icon,true)



item:SetChildActive(8,false)



local name_str=cfg.name
item:SetChildText(1,name_str)

local isgray=not active
item:SetChildImageExGray(0,isgray)
item:SetChildImageExGray(7,isgray)
item:SetChildImageExGray(8,isgray)
item:SetChildImageExGray(11,isgray)
item:SetChildActive(13,false)
item:SetChildActive(14,false)
local isReddot=false
if active then

local showSign=false
item:SetChildActive(2,showSign)

local lianhua_str=nil
local showLianHua=lianhua_str~=nil
item:SetChildActive(3,showLianHua)
if showLianHua then
item:SetChildText(3,lianhua_str)
end

local UpFlag=xianbaoConfig.getTypeFuncResult(cfgType,"checkCanUpStar",id)
item:SetChildActive(4,UpFlag)
item:SetChildActive(12,not UpFlag)
if UpFlag then
local maxStar=xianbaoConfig.getXBMaxStar(id)
local starlv=xianbaoModel:getXbStart(id)
item:SetChildLayoutGroupCreateItems(4,maxStar,function(index)
local starWidget=item:GetChildLayoutGroupGridItem(4,index-1)
starWidget:SetChildActive(0,index<=starlv)
end)
else
local dfxb=xianbaoModel:CheckDianfengXianbao(id)
if dfxb then
local lv=xianbaoConfig.getTypeFuncResult(cfgType,"getLevel",{id})
item:SetChildText(15,lv)
item:SetChildCSImageSprite(13,dfabname,"image_dfdj_dianfeng")
item:SetChildActive(13,true)
item:SetChildCSImageSprite(14,dfabname,"image_dfdj_xianbaoui_1")
item:SetChildActive(14,true)
else
local lv=xianbaoConfig.getTypeFuncResult(cfgType,"getLevel",id)
item:SetChildText(12,FMT.fmt("等级：{0}级",lv))
end
end


isReddot=xianbaoConfig.getTypeFuncResult(cfgType,"checkReddot",id)
else

item:SetChildActive(2,false)

item:SetChildActive(3,false)

local UpFlag=xianbaoConfig.getTypeFuncResult(cfgType,"checkCanUpStar",id)
item:SetChildActive(4,UpFlag)
if UpFlag then
local maxStar=xianbaoConfig.getXBMaxStar(id)
item:SetChildLayoutGroupCreateItems(4,maxStar,function(index)
local starWidget=item:GetChildLayoutGroupGridItem(4,index-1)
starWidget:SetChildActive(0,false)
end)
end
end

item:SetChildActive(6,not active and canActive)

item:SetChildActive(10,isReddot)
self.allitemList[id]={item,isReddot,pageidx,childidx,cfgType}

item:SetChildActive(9,active and isSpe)

item:SetChildActive(11,isLD)
end


function UIXianBaoTuJianWin:checkRefreshFinish(pageidx,childidx)
if self.maxPageIndex==0 then return end

if pageidx==self.maxPageIndex and childidx==self.maxPageNum and self.jumpPageIndex~=0 then

local pos=self.creater:getChildLocalPosition()
if pos.y<1 then
self:jumpRedItem()
end
end
end


function UIXianBaoTuJianWin:jumpRedItem()
local func=function()
local pageItem=self.creater:getChildLayoutGroupGridItem(self.jumpPageIndex-1)
local childItem=pageItem:GetChildLayoutGroupGridItem(1,self.jumpPageNum-1)
local sp=childItem:GetChildUIScreenPos(-1,false)
local sp_=Vector2(sp.x,sp.y)
local lp=self.creater:getChildUIScreenPos2Local(sp_)
local moveY=-lp.y-85

if moveY>=200 then
self.creater:setChildDOLocalMoveY(moveY,0.2,nil)
end
end
self:delayDo(0.1,func)
end

function UIXianBaoTuJianWin:onHide()
self.isShow=false
end


function UIXianBaoTuJianWin:freshReddot()
local xbid,reddot,cfgType
for k,v in pairs(self.allitemList or{})do
xbid=k
cfgType=v[5]
reddot=xianbaoConfig.getTypeFuncResult(cfgType,"checkReddot",xbid)
if reddot~=v[2]then
v[1]:SetChildActive(10,reddot)
end
end
end


function UIXianBaoTuJianWin:freshXbItem(xbid)
if self.allitemList and self.allitemList[xbid]then
local temp=self.allitemList[xbid]
self:refreshChildItem(temp[1],temp[3],temp[4])
end

end

function UIXianBaoTuJianWin:onItemsChanged(itemList)
if not self.isShow then
return
end
for i,v in ipairs(itemList)do
local itmeid=v[3]
if xianbaoConfig.isXianbaoActiveItemEx(itmeid)then
self:initXBListPanel(false,true)
return
end
end
end



