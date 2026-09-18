







def_class("UIWorldMapTabWin",UIWindowBase)









function UIWorldMapTabWin:bindComponents()

self.ButtonBack=UIButton.get(self,0)
self.ButtonZM=UIButton.get(self,1)
self.Button_1=UIButton.get(self,2)
self.Button_2=UIButton.get(self,3)
self.Button_3=UIButton.get(self,4)
self.Name_1=UIText.get(self,5)
self.Name_2=UIText.get(self,6)
self.Name_3=UIText.get(self,7)
self.Icon_1=UIImage.get(self,8)
self.Icon_2=UIImage.get(self,9)
self.Icon_3=UIImage.get(self,10)
self.Selected_1=UIObject.get(self,11)
self.Selected_2=UIObject.get(self,12)
self.Selected_3=UIObject.get(self,13)

self.ButtonBack:setButtonClick(function()self:onButtonBack()end)

self.ButtonZM:setButtonClick(function()self:onButtonZM()end)

self.Button_1:setButtonClick(function()self:onButton_1()end)

self.Button_2:setButtonClick(function()self:onButton_2()end)

self.Button_3:setButtonClick(function()self:onButton_3()end)
self.Button={
self.Button_1,
self.Button_2,
self.Button_3,
}
self.Name={
self.Name_1,
self.Name_2,
self.Name_3,
}
self.Icon={
self.Icon_1,
self.Icon_2,
self.Icon_3,
}
self.Selected={
self.Selected_1,
self.Selected_2,
self.Selected_3,
}



end


function UIWorldMapTabWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ButtonBack);self.ButtonBack=nil;
_UIObject_release(self.ButtonZM);self.ButtonZM=nil;
_UIObject_release(self.Button_1);self.Button_1=nil;
_UIObject_release(self.Button_2);self.Button_2=nil;
_UIObject_release(self.Button_3);self.Button_3=nil;
_UIObject_release(self.Name_1);self.Name_1=nil;
_UIObject_release(self.Name_2);self.Name_2=nil;
_UIObject_release(self.Name_3);self.Name_3=nil;
_UIObject_release(self.Icon_1);self.Icon_1=nil;
_UIObject_release(self.Icon_2);self.Icon_2=nil;
_UIObject_release(self.Icon_3);self.Icon_3=nil;
_UIObject_release(self.Selected_1);self.Selected_1=nil;
_UIObject_release(self.Selected_2);self.Selected_2=nil;
_UIObject_release(self.Selected_3);self.Selected_3=nil;
self.Button=nil;
self.Name=nil;
self.Icon=nil;
self.Selected=nil;
end
















local _this=nil
local _image_ab="ui/windows/world/sharedtextures/dashijie_scene_icon_altas.ab"
local _selected=nil



function UIWorldMapTabWin:onLoaded(...)
self:bindComponents()
_this=self
self.enter=worldMapController:getEnterScene()
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,self.enter)
self.Icon[1]:setIcon("icon_sjquyu_1",true)
self.Name[3]:setText(FMT.fmt("返回\n({0})",worldCfg.name))
self.Icon[3]:setIcon(worldCfg.mapicon,true)
local show=worldBlockModel:getAreaStateCount(2,eWorldBlockState.OPEN)>0
self.Button[3]:setActive(show)




end


function UIWorldMapTabWin:__delete()
self:unbindComponents()
_this=nil
_selected=nil




end




function UIWorldMapTabWin:onShow(argtable,afterOnloaded)
self.scene=worldMapController:getLastScene()
local curr=worldMapController:getCurrentScene()
self:setSelected(curr==self.scene and 2 or nil)
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,self.scene)
self.Name[2]:setText(worldCfg.name)
self.Icon[2]:setIcon(worldCfg.mapicon,true)
end


function UIWorldMapTabWin:onHide()

end





function UIWorldMapTabWin:onButtonBack()
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,self.enter)
worldController:breakOverTopBackEnter(worldCfg.cameraPos[2])
worldMapController:exitMapModel()
worldController:setCameraState(eWorldCameraState.Normal)
end



function UIWorldMapTabWin:onButtonZM()
if worldController:exitWorld()then
worldMapController:exitMapModel()
end
end



function UIWorldMapTabWin:onButton_1()
if systemModel.isOpen(SYSTEM_DEFINE.eWorldMap)then
if not worldController:checkCameraState(eWorldCameraState.WorldMap)then
UIManager:callWindowFunc("UIWorldSceneWin","doAnimationScale",function()

end)
UIManager:showWindow("UIWorldMapWin")
worldController:setCameraState(eWorldCameraState.WorldMap)


self:setSelected(1)
end
else
UIManager.error(FMT.fmt("{0}系统未开起",cfgHelper.get2(cfg_systemopenconfig_get,SYSTEM_DEFINE.eWorldMap,"name")))
end
end



function UIWorldMapTabWin:onButton_2()
if systemModel.isOpen(SYSTEM_DEFINE.eWorldSceneMap)then
if not worldController:checkCameraState(eWorldCameraState.SceneMap)then
UIManager:callWindowFunc("UIWorldMapWin","doAnimationScale",function()
UIManager:hideWindow("UIWorldMapWin")



worldController:setCameraState(eWorldCameraState.SceneMap)
end)
local last=worldMapController:getLastScene()
worldMapController:setCurrentScene(last)
UIManager:showWindow("UIWorldSceneWin")


self:setSelected(2)
else
local last=worldMapController:getLastScene()
local current=worldMapController:getCurrentScene()
if current~=last then
worldMapController:setCurrentScene(last)
UIManager:showWindow("UIWorldSceneWin")
self:onShow()
self:setSelected(2)
else
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,current)
UIManager.info(FMT.fmt("已在{0}",worldCfg.name))
end
end
else
UIManager.error(FMT.fmt("{0}系统未开起",cfgHelper.get2(cfg_systemopenconfig_get,SYSTEM_DEFINE.eWorldSceneMap,"name")))
end
end



function UIWorldMapTabWin:onButton_3()








if systemModel.isOpen(SYSTEM_DEFINE.eWorldSceneMap)then
if not worldController:checkCameraState(eWorldCameraState.SceneMap)then
UIManager:callWindowFunc("UIWorldMapWin","doAnimationScale",function()
UIManager:hideWindow("UIWorldMapWin")



worldController:setCameraState(eWorldCameraState.SceneMap)
end)
local enter=worldMapController:getEnterScene()
worldMapController:setCurrentScene(enter)
UIManager:showWindow("UIWorldSceneWin")


self:setSelected(3)
else
local enter=worldMapController:getEnterScene()
local current=worldMapController:getCurrentScene()
if current~=enter then
worldMapController:setCurrentScene(enter)
UIManager:showWindow("UIWorldSceneWin")
self:onShow()
self:setSelected(3)
else
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,current)
UIManager.info(FMT.fmt("已在{0}",worldCfg.name))
end
end
else
UIManager.error(FMT.fmt("{0}系统未开起",cfgHelper.get2(cfg_systemopenconfig_get,SYSTEM_DEFINE.eWorldSceneMap,"name")))
end
end

function UIWorldMapTabWin:setSelected(index)
if _selected~=index then
if _selected then
self.Selected[_selected]:setActive(false)
end
_selected=index
if _selected then
self.Selected[_selected]:setActive(true)
end
end
end