







def_class("UIHYPTTuJianWin",UIWindowBase)









function UIHYPTTuJianWin:bindComponents()

self.topTipsText=UIText.get(self,0)
self.showRankBtn=UIButton.get(self,1)
self.rankFirstList=UIObject.get(self,2)
self.leftBtn=UIButton.get(self,3)
self.rightBtn=UIButton.get(self,4)
self.timeText=UIText.get(self,5)
self.bottomTipsText=UIText.get(self,6)
self.Content=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.time=UIText.get(self,9)
self.catpanel=UIObject.get(self,10)
self.catmodelone=UIObject.get(self,11)
self.catmodeltwo=UIObject.get(self,12)
self.catmodelthree=UIObject.get(self,13)
self.mask=UIButton.get(self,14)
self.onclosebtn=UIButton.get(self,15)
self.bgModel=UIObject.get(self,16)

self.showRankBtn:setButtonClick(function()self:onShowRankBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.onclosebtn:setButtonClick(function()self:onOnclosebtn()end)



end


function UIHYPTTuJianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.topTipsText);self.topTipsText=nil;
_UIObject_release(self.showRankBtn);self.showRankBtn=nil;
_UIObject_release(self.rankFirstList);self.rankFirstList=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.bottomTipsText);self.bottomTipsText=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.catpanel);self.catpanel=nil;
_UIObject_release(self.catmodelone);self.catmodelone=nil;
_UIObject_release(self.catmodeltwo);self.catmodeltwo=nil;
_UIObject_release(self.catmodelthree);self.catmodelthree=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.onclosebtn);self.onclosebtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end

















local _this
local abname="ui/windows/activities/sub_huiyingpintu/huiyingpintu_atlas_pak.ab"
local _Count=24


function UIHYPTTuJianWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIHYPTTuJianWin:__delete()
self:unbindComponents()
_this=nil
end




function UIHYPTTuJianWin:onShow(argtable,afterOnloaded)
self.bgModel:setChildUIModelShowTarget(5231,1,{},eAnimationID.enter,false,false,0,nil)

_this:delayDo(0.6,function(...)
_this.root:setChildCanvasGroupDOFade(1,2,nil)
end)
if argtable then
self.actID=argtable.actID
self.subType=argtable.subType
self.subid=argtable.subid
self:refreshScrollerView()
end
end


function UIHYPTTuJianWin:onHide()

end





function UIHYPTTuJianWin:onShowRankBtn()
end
function UIHYPTTuJianWin:onLeftBtn()
end
function UIHYPTTuJianWin:onRightBtn()
end
function UIHYPTTuJianWin:onMask()
self:closeSelf()
end
function UIHYPTTuJianWin:onOnclosebtn()
self:closeSelf()
end



function UIHYPTTuJianWin:refreshScrollerView()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local puzzle_id=mydata.puzzle_id
local recv_puzzle_id=mydata.recv_puzzle_id
local debrisList=mydata.debrisList
local recvList=mydata.recvList
local cfg=cfg_paintedpuzzleactivityconfig_get(_this.subid)
local pintulist=cfg.puzzlename
local pintulist_img=cfg.puzzleimgsmall
local pintulist_siju=cfg.pintulist_siju

_this.rankFirstList:setChildScrollViewCreateGrids(#pintulist,#pintulist)
local grids=_this.rankFirstList:getChildScrollViewItemWidgets()
_this.pageCount=#_this.rankFirstList
local count=grids.Count
for i=1,count do
local item=grids[i-1]

if puzzle_id>=i then

if recv_puzzle_id>=i then
local titlestr=FMT.fmt("<color=#7D3D19>{0}</color>",pintulist[i])
item:SetChildText(1,titlestr)
item:SetChildCSImageSprite(2,abname,pintulist_img[i])

item:SetChildText(3,"")


item:SetChildText(4,FMT.fmt("<color=#7D3D19>{0}</color>",pintulist_siju[i][1]))
item:SetChildText(5,FMT.fmt("<color=#7D3D19>{0}</color>",pintulist_siju[i][2]))
item:SetChildActive(6,true)
else
if#debrisList>=_Count then

local titlestr=FMT.fmt("<color=#7D3D19>{0}</color>",pintulist[i])
item:SetChildText(1,titlestr)
item:SetChildCSImageSprite(2,abname,pintulist_img[i])

item:SetChildText(3,"")


item:SetChildText(4,FMT.fmt("<color=#7D3D19>{0}</color>",pintulist_siju[i][1]))
item:SetChildText(5,FMT.fmt("<color=#7D3D19>{0}</color>",pintulist_siju[i][2]))
item:SetChildActive(6,true)
else

local titlestr=FMT.fmt("<color=#827f78>{0}</color>",pintulist[i])
item:SetChildText(1,titlestr)
item:SetChildCSImageSprite(2,abname,"image_pintuchahuaA0")

item:SetChildText(3,FMT.fmt("<color=#827f78>未激活</color>"))


item:SetChildText(4,FMT.fmt("<color=#827f78>{0}</color>",pintulist_siju[i][1]))
item:SetChildText(5,FMT.fmt("<color=#827f78>{0}</color>",pintulist_siju[i][2]))
item:SetChildActive(6,false)

end
end
else

local titlestr=FMT.fmt("<color=#827f78>{0}</color>",pintulist[i])
item:SetChildText(1,titlestr)
item:SetChildCSImageSprite(2,abname,"image_pintuchahuaA0")

item:SetChildText(3,FMT.fmt("<color=#827f78>未激活</color>"))


item:SetChildText(4,FMT.fmt("<color=#827f78>{0}</color>",pintulist_siju[i][1]))
item:SetChildText(5,FMT.fmt("<color=#827f78>{0}</color>",pintulist_siju[i][2]))
item:SetChildActive(6,false)
end
end
end
