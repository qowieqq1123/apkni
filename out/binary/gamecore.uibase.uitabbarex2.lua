









UITabBarEx2=simple_class(UITabBarEx)

function UITabBarEx2:__init(tab_list,callback,disable_callback,isMoreClick)
self.lockPanel_obj={}
self.normalPanel_text={}
self.selectPanel_text={}

otherHelper.invokeFuncOnEveryData(self.toggles,function(index,handle_toggle)

local normalLabel=handle_toggle.transform:Find('NormalBg/Label').gameObject
local normalText=ComponentHelper.GetComponent(normalLabel,UI.Text)
self.normalPanel_text[index]=normalText


local selectLabel=handle_toggle.transform:Find('SelectBg/Label').gameObject
local selectText=ComponentHelper.GetComponent(selectLabel,UI.Text)
self.selectPanel_text[index]=selectText


local obj=handle_toggle.transform:Find('lockPanel').gameObject
self.lockPanel_obj[#self.lockPanel_obj+1]=obj


local btn=ComponentHelper.GetComponent(obj,UI.Button)
local function btnCall()
if self.lockPanelOnClick then
self.lockPanelOnClick(index)
end
AudioManager.playBtnClick()
end
btn.onClick:AddListener(btnCall)
end)


self.lockPanel_visible={}
for i=1,#self.lockPanel_obj do
self.lockPanel_visible[i]=true
self.lockPanel_obj[i]:SetActive(true)
end
end

function UITabBarEx2:UpdateSelected(index)
if not self.toggles_state[index]then
if self.disable_callback then
self.disable_callback(index)
end
self.state_lock=true
otherHelper.invokeFuncOnEveryData(self.toggles,function(index,handle_toggle)
handle_toggle.isOn=self.select_index==index
end)
self.state_lock=false
return
end

self.select_index=index

for i=1,#self.toggles_select_img do
self.toggles_select_img[i]:SetActive(i==self.select_index)
end

self:ExecuteSelect()
end





function UITabBarEx2:SetLockPanelVisible(index,bool)
if not self.lockPanel_visible[index]then
return false
end

self.lockPanel_visible[index]=bool
self.lockPanel_obj[index]:SetActive(self.lockPanel_visible[index])
end


function UITabBarEx2:SetLockPanelClickEvent(callback)
self.lockPanelOnClick=callback
end


function UITabBarEx2:SetTabText(index,str)
if not self.toggles[index]then
return false
end

self.normalPanel_text[index].text=str or""
self.selectPanel_text[index].text=str or""
end


function UITabBarEx2:SetRed(index,num)
if not self.toggles[index]then
return false
end

RedHelper.SetRedDoc(self.toggles[index],num)
end
