







Deque=simple_class()

function Deque:__init()
self.deque={}
self.size_=0
self.head=0
self.rear=-1
end

function Deque:PushFront(element)
self.head=self.head-1
self.deque[self.head]=element
self.size_=self.size_+1
end

function Deque:PushBack(element)
self.rear=self.rear+1
self.deque[self.rear]=element
self.size_=self.size_+1
end

function Deque:PopFront()
if self:IsEmpty()then
printError("Error: The Deque is empty.")
return
end
local value=self.deque[self.head]
self.deque[self.head]=nil
self.head=self.head+1
self.size_=self.size_-1
return value
end

function Deque:PopBack()
if self:IsEmpty()then
printError("Error: The Deque is empty.")
return
end
local value=self.deque[self.rear]
self.deque[self.rear]=nil
self.rear=self.rear-1
self.size_=self.size_-1
return value
end

function Deque:Clear()
self.deque={}
self.size_=0
self.head=0
self.rear=-1
end

function Deque:IsEmpty()
if self:Size()==0 then
return true
end
return false
end

function Deque:Size()
return self.size_
end
