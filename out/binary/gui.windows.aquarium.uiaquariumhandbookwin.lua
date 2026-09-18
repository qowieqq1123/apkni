







def_class("UIAquariumHandbookWin",UIWindowBase)









function UIAquariumHandbookWin:bindComponents()

self.fishBtnText=UIText.get(self,0)
self.levelUpBtnRD=UIObject.get(self,1)
self.actBtnRD=UIObject.get(self,2)
self.count=UIText.get(self,3)
self.effect=UIObject.get(self,4)
self.scrollView=UIObject.get(self,5)
self.pageScrollView=UIObject.get(self,6)
self.attr1=UIText.get(self,7)
self.attr2=UIText.get(self,8)
self.attr3=UIText.get(self,9)
self.countPB=UIObject.get(self,10)
self.starScrollView=UIObject.get(self,11)
self.actBtn=UIButton.get(self,12)
self.levelUpBtn=UIObject.get(self,13)
self.fishBtn=UIButton.get(self,14)
self.reward1=UIObject.get(self,15)
self.reward2=UIObject.get(self,16)
self.typeName=UIText.get(self,17)
self.name=UIText.get(self,18)
self.icon=UIObject.get(self,19)

self.actBtn:setButtonClick(function()self:onActBtn()end)

self.fishBtn:setButtonClick(function()self:onFishBtn()end)



end


function UIAquariumHandbookWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fishBtnText);self.fishBtnText=nil;
_UIObject_release(self.levelUpBtnRD);self.levelUpBtnRD=nil;
_UIObject_release(self.actBtnRD);self.actBtnRD=nil;
_UIObject_release(self.count);self.count=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.pageScrollView);self.pageScrollView=nil;
_UIObject_release(self.attr1);self.attr1=nil;
_UIObject_release(self.attr2);self.attr2=nil;
_UIObject_release(self.attr3);self.attr3=nil;
_UIObject_release(self.countPB);self.countPB=nil;
_UIObject_release(self.starScrollView);self.starScrollView=nil;
_UIObject_release(self.actBtn);self.actBtn=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.fishBtn);self.fishBtn=nil;
_UIObject_release(self.reward1);self.reward1=nil;
_UIObject_release(self.reward2);self.reward2=nil;
_UIObject_release(self.typeName);self.typeName=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.icon);self.icon=nil;
end



















function UIAquariumHandbookWin:onLoaded(...)
self:bindComponents()

self.pageNames={'小型鱼','中型鱼','大型鱼'}
self.hdType={[1]=true,[2]=true,[3]=true}

self.abName='ui/windows/aquarium/aquarium_atlas_pak.ab'
self.dyABName='ui/windows/yiyuhuiyou/yyhyimage_atlas_pak.ab'
self.starName={
'image_yztjpj_1',
'image_yztjpj_2',
'image_yztjpj_3',
'image_yztjpj_4',
'image_yztjpj_5'
}
self.rwTopImgName={
'image_jihuojiangli_1',
'image_zuidazl_1',
'image_zuixiaozl_1'
}

self.defIconPos=self.icon:getChildAnchoredPosition()

self.datas=self:getHBDatas()

self.pageScrollView:setChildScrollViewInit(0.5,true,function(...)self:onPageClick(...)end,nil)
self.scrollView:setChildScrollViewInit(0.5,true,function(...)self:onItemClick(...)end,nil)
self.starScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end

function UIAquariumHandbookWin:onPageClick(num,index)
if self.pageIndex then
local widget=self.pageScrollView:getChildScrollViewItemWidget(self.pageIndex)
widget:SetChildActive(0,false)
end
self.pageIndex=index
local widget=self.pageScrollView:getChildScrollViewItemWidget(self.pageIndex)
widget:SetChildActive(0,true)

if not self.isRefresh then
self.currSelect=0
end
local datas=self:getHBPageDatas(index+1)
for k,v in ipairs(datas)do
if v and v.id and UIAquariumControl:checkHandleBookItemReddot(v.id)then
self.currSelect=k-1
break
end
end
self:showHBookList(index+1)
end

function UIAquariumHandbookWin:onItemClick(num,index)
if self.currSelect then
local widget=self.scrollView:getChildScrollViewItemWidget(self.currSelect)
widget:SetChildActive(0,false)
end
self.currSelect=index
local widget=self.scrollView:getChildScrollViewItemWidget(self.currSelect)
widget:SetChildActive(0,true)

local cfg=self.selectDatas[index+1]
self:setInfo(cfg)
end


function UIAquariumHandbookWin:__delete()
self:clearFadeTweener()

self:unbindComponents()
end




function UIAquariumHandbookWin:onShow(argtable,afterOnloaded)
self:refresh()
end

function UIAquariumHandbookWin:playEffect()
self.effect:setChildShowEffect(10325,true)
end

function UIAquariumHandbookWin:refresh()
self:showPage()
self.isRefresh=true
self:onPageClick(0,self.pageIndex or 0)
self.isRefresh=false
end

function UIAquariumHandbookWin:setStarLevel(cfg,data)
local level=data.star
local disColor
local disLevel
if level<1 then
disColor=0
disLevel=data.star>=0 and 1 or 0
else
disColor=math.floor(level/5)
disLevel=level%5+1
end
local color=cfg.color+disColor
local len=5
self.starScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.starScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[count-i]
if i<=disLevel then
item:SetChildActive(0,true)
item:SetChildCSImageSprite(0,self.abName,self.starName[color])
else
item:SetChildActive(0,false)
end
end
end

function UIAquariumHandbookWin:showPage()
local len=#self.pageNames
self.pageScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.pageScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildActive(0,false)
item:SetChildText(1,self.pageNames[i])
local check=UIAquariumControl:checkHandleBookTypeReddot(i)
item:SetChildActive(2,check)
end
end

function UIAquariumHandbookWin:getHBDatas()
local cfgs=cfg_yuelongchibookconfig()
local list={}
for i,v in pairs(cfgs)do
local ftype=v.type
if self.hdType[ftype]then
local tb=list[ftype]or{}
table.insert(tb,v)
list[ftype]=tb
end
end
for k,v in pairs(list)do
table.sort(v,function(a,b)
if a.color>b.color then
return true
elseif a.color==b.color then
return a.id<b.id
else
return false
end
end)
end
return list
end

function UIAquariumHandbookWin:getHBPageDatas(ftype)
local datas=self.datas[ftype]
local list={}
for i,v in ipairs(datas)do
local cnd=v.condition
if cnd then
if cnd==2 then
local data=UIAquariumControl:getHandleBookData(v.id)
if data.times>0 or data.star>=0 then
table.insert(list,v)
end
end
else
table.insert(list,v)
end
end
return list
end

function UIAquariumHandbookWin:showHBookList(ftype)
local datas=self:getHBPageDatas(ftype)
self.selectDatas=datas
local len=#datas
self.scrollView:setChildScrollViewCreateGrids(len,4)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
local uNum=0
for i=1,count do
local item=grids[i-1]
local cfg=datas[i]
local info=cfgHelper.get1(cfg_ylcinfoconfig_get,cfg.info)
local itemConfig=itemsConfig.getConfig(info.show_item)
local data=UIAquariumControl:getHandleBookData(cfg.id)
item:SetChildActive(0,false)
local star=data.star>=0 and data.star or 0
local unlock=data.times>0 or data.star>=0
item:SetChildQulaity(1,cfg.color+math.floor(star/5))
if unlock then
uNum=uNum+1
item:SetChildIcon(2,iconHelper.getIconName(itemConfig.icon),true)
else
item:SetChildCSImageSprite(2,self.abName,'icon_weijiesuoyztj_1')
end

item:SetChildText(3,info.name)
local check=UIAquariumControl:checkHandleBookItemReddot(cfg.id)
item:SetChildActive(4,check)
local actHD=YiYuHuiYouController:checkActivityByTuJianID(cfg.id)
item:SetChildActive(5,actHD)
end

self.typeName:setText(FMT.fmt('{0}（{1}/{2}）',self.pageNames[ftype],uNum,len))

self:onItemClick(0,self.currSelect or 0)
end

function UIAquariumHandbookWin:setActiveReward(cfg,data)
local rwWidget=self.reward1:getChildWidgetBase()
local rwdata=cfg.reward[1][1]
local itemId=rwdata[1]
local itemCount=rwdata[2]
local itemConfig=itemsConfig.getConfig(itemId)
rwWidget:SetChildIcon(0,iconHelper.getIconName(itemConfig.icon),true)
rwWidget:SetChildText(7,FMT.fmt('x{0}',itemCount))
rwWidget:SetChildCSImageSprite(1,self.dyABName,'image_yzgsdpinzhi_'..itemConfig.color)
rwWidget:SetChildCSImageSprite(2,self.abName,self.rwTopImgName[1])
rwWidget:SetChildActive(3,false)
rwWidget:SetChildActive(4,false)

local check=data.star>=0
rwWidget:SetChildActive(8,check)
rwWidget:SetChildButtonClick(5,function()
if check then
UIAquariumControl:reqHBReward(cfg.id,4)
else
itemsComponentHelper.onItemClickEx(itemId)
end
end)
end

function UIAquariumHandbookWin:setSizeReward(cfg)
local rwWidget=self.reward1:getChildWidgetBase()
local rwdata=cfg.reward[3][1]
local itemId=rwdata[1]
local itemCount=rwdata[2]
local itemConfig=itemsConfig.getConfig(itemId)
rwWidget:SetChildIcon(0,iconHelper.getIconName(itemConfig.icon),true)
rwWidget:SetChildText(7,FMT.fmt('x{0}',itemCount))
rwWidget:SetChildCSImageSprite(1,self.dyABName,'image_yzgsdpinzhi_'..itemConfig.color)
rwWidget:SetChildCSImageSprite(2,self.abName,self.rwTopImgName[2])
rwWidget:SetChildActive(3,true)
local showTips=false
local showRD=false
local check=UIAquariumControl:checkHandleBookFlag(cfg.id,2)
local receive=UIAquariumControl:checkHandleBookFlag(cfg.id,3)
if check then
rwWidget:SetChildText(6,FMT.fmt('{0}斤',cfg.max))
rwWidget:SetChildActive(4,receive)

if not receive then
showRD=true
rwWidget:SetChildButtonClick(5,function()
UIAquariumControl:reqHBReward(cfg.id,3)
end)
end
showTips=receive
else
rwWidget:SetChildText(6,'??斤')
rwWidget:SetChildActive(4,false)

showTips=true
end
rwWidget:SetChildActive(8,showRD)
if showTips then
rwWidget:SetChildButtonClick(5,function()
if receive then
itemsComponentHelper.onItemClickEx(itemId)
else
UIManager.info('捕获该鱼最大重量可领取奖励')
end
end)
end

rwWidget=self.reward2:getChildWidgetBase()
rwdata=cfg.reward[2][1]
itemId=rwdata[1]
itemCount=rwdata[2]
itemConfig=itemsConfig.getConfig(itemId)
rwWidget:SetChildIcon(0,iconHelper.getIconName(itemConfig.icon),true)
rwWidget:SetChildText(7,FMT.fmt('x{0}',itemCount))
rwWidget:SetChildCSImageSprite(1,self.dyABName,'image_yzgsdpinzhi_'..itemConfig.color)
rwWidget:SetChildCSImageSprite(2,self.abName,self.rwTopImgName[3])
rwWidget:SetChildActive(3,true)
showTips=false
showRD=false
check=UIAquariumControl:checkHandleBookFlag(cfg.id,0)
local receive2=UIAquariumControl:checkHandleBookFlag(cfg.id,1)
if check then
rwWidget:SetChildText(6,FMT.fmt('{0}斤',cfg.min))

rwWidget:SetChildActive(4,receive2)

if not receive2 then
showRD=true
rwWidget:SetChildButtonClick(5,function()
UIAquariumControl:reqHBReward(cfg.id,1)
end)
end
showTips=receive2
else
rwWidget:SetChildText(6,'??斤')
rwWidget:SetChildActive(4,false)

showTips=true
end
rwWidget:SetChildActive(8,showRD)
if showTips then
rwWidget:SetChildButtonClick(5,function()
if receive2 then
itemsComponentHelper.onItemClickEx(itemId)
else
UIManager.info('捕获该鱼最小重量可领取奖励')
end
end)
end
end

function UIAquariumHandbookWin:clearFadeTweener()
if self.fadeTweener then
self.fadeTweener:Kill()
self.fadeTweener=nil
end
end

function UIAquariumHandbookWin:setInfo(cfg)
self.currConfig=cfg
local data=UIAquariumControl:getHandleBookData(cfg.id)
local info=cfgHelper.get1(cfg_ylcinfoconfig_get,cfg.info)
self.name:setText(info.name)
local ssdata=isometricMapSystem:getModelScales2Pram(info.model,7)
self.icon:setChildUIModelShowTarget(info.model,ssdata[1],nil,eAnimationID.stand,true)
self.icon:setChildAnchoredPosition(Vector2.New(self.defIconPos.x+ssdata[2],self.defIconPos.y+ssdata[3]))
self.icon:setChildCanvasGroupAlpha(0)
self:clearFadeTweener()
self.fadeTweener=self.icon:setChildCanvasGroupDOFade(1,0.5,nil)
local unlock=data.times>0 or data.star>=0
self.icon:setChildUIModelShowColor(unlock and Color.New(1,1,1,1)or Color.New(0,0,0,1))
local needActive=data.star==-1
if needActive then
self.countPB:setChildUIProgressbar(data.times,1,false)
self.count:setText(FMT.fmt('{0}/{1}',data.times,1))
self:setAttr(self.attr1)
self:setAttr(self.attr2)
self.attr3:setText(unlock and''or'未捕获该鱼')

self:setActiveReward(cfg,data)

self.reward2:setActive(false)
self.actBtn:setActive(true)
self.actBtnRD:setActive(data.times>0)
self.levelUpBtn:setActive(false)
else
local sdata=cfg.star[data.star]
local isFull=data.star>=#cfg.star
if isFull then
self.countPB:setChildUIProgressbar(1,1,false)
self.count:setText('已满级')
else
self.countPB:setChildUIProgressbar(data.times,sdata[1],false)
self.count:setText(FMT.fmt('{0}/{1}',data.times,sdata[1]))
end

if sdata[2][2]then
self:setAttr(self.attr1,sdata[2][1])
self:setAttr(self.attr2,sdata[2][2])
self:setAttr(self.attr3)
else
self:setAttr(self.attr1)
self:setAttr(self.attr2)
self:setAttr(self.attr3,sdata[2][1])
end

local receive=UIAquariumControl:checkHandleBookFlag(cfg.id,4)
if receive then
self:setSizeReward(cfg)
self.reward2:setActive(true)
else
self:setActiveReward(cfg,data)
self.reward2:setActive(false)
end

self.actBtn:setActive(false)
self.levelUpBtn:setActive(not isFull)
self.levelUpBtnRD:setActive(data.times>=sdata[1])
end

self:setStarLevel(cfg,data)

local actHD=YiYuHuiYouController:checkActivityByTuJianID(cfg.id)
self.fishBtnText:setText(actHD and'前往钓鱼'or'该鱼群\n未出没')
end

function UIAquariumHandbookWin:setAttr(obj,data)
if data then
local type=data[1]
local value=data[2]
local cfg=cfgHelper.get1(cfg_attributesconfig_get,type)
obj:setText(FMT.fmt('{0}<color=#549327>+{1}</color>',cfg.attrname,value))
else
obj:setText('')
end
end


function UIAquariumHandbookWin:onHide()

end

function UIAquariumHandbookWin:checkLevelUp(cfg,wraning)
local data=UIAquariumControl:getHandleBookData(cfg.id)
if data.star==-1 then
if data.times<1 then
if wraning then
UIManager.error('次数不足激活')
end
return false
end
else
local sdata=cfg.star[data.star]
if data.times<sdata[1]then
if wraning then
UIManager.error('次数不足提升灵性')
end
return false
end
end
return true
end



function UIAquariumHandbookWin:onActBtn()
if self:checkLevelUp(self.currConfig,true)then
UIAquariumControl:reqHBStarUp(self.currConfig.id)
end
end

function UIAquariumHandbookWin:onLevelUpBtn()
if self:checkLevelUp(self.currConfig,true)then
UIAquariumControl:reqHBStarUp(self.currConfig.id)
else

AudioManager.playBtnClick()
end
end

function UIAquariumHandbookWin:onFishBtn()
local actHD=YiYuHuiYouController:checkActivityByTuJianID(self.currConfig.id)
if not actHD then
UIManager.info('该鱼群未出没')
return
end
if self.currConfig.jump then
jumpManager:jump(self.currConfig.jump)
end
end

